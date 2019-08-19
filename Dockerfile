# Start from official base image
FROM jenkins/jenkins:latest
MAINTAINER ittiel

USER root


# Install jq, awscli, Ansible and other
RUN apt-get update -y && apt-get install -y \
    curl \
    awscli \
    jq \
    wget \
    unzip \
    ansible \
    golang-go\
    make \
    groff \
    && rm -rf /var/lib/apt/lists/*

#Terraform
RUN wget https://releases.hashicorp.com/terraform/0.12.4/terraform_0.12.4_linux_amd64.zip
RUN unzip ./terraform_0.12.4_linux_amd64.zip -d /usr/local/bin/


USER jenkins

# Copy plugin list
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Workaround plugin download issues
#ENV CURL_CONNECTION_TIMEOUT=60 JENKINS_UC_DOWNLOAD="http://mirrors.jenkins-ci.org"
ENV CURL_CONNECTION_TIMEOUT=60 JENKINS_UC_DOWNLOAD="http://ftp-nyc.osuosl.org/pub/jenkins"

# Install plugins
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
#RUN xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt


# Setup credentials
ENV JENKINS_USER=admin JENKINS_PASS=admin

# Skip wizard, setup verbose logging
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false -DsessionTimeout=1440"

# Copy seed job and pipelines definition
ADD jobs.groovy  /tmp/

# Copy init script
COPY init-jenkins.groovy /usr/share/jenkins/ref/init.groovy.d/

