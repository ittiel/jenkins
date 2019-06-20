FROM python:3.7.2-stretch as py3
# Start from official base image
FROM jenkins/jenkins:latest

USER root
#Python 3.7
COPY --from=py3 /usr/local/lib /usr/local/lib
COPY --from=py3 /usr/local/bin /usr/local/bin
COPY --from=py3 /usr/local/include /usr/local/include
COPY --from=py3 /usr/local/man /usr/local/man
COPY --from=py3 /usr/local/share /usr/local/share
#install npm, node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash -


# Install maven, makeת, jq, awscli
RUN apt-get update -y && apt-get install -y apt-utils maven build-essential uuid-runtime \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common  \
    awscli \
    jq \
    nodejs \
    && rm -rf /var/lib/apt/lists/*


#Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

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

