# Start from official base image
FROM jenkins/jenkins:lts

USER root

# Install maven, make
RUN apt-get update -y && apt-get install apt-utils maven build-essential uuid-runtime \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y \
    && rm -rf /var/lib/apt/lists/*



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
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false"

# Copy seed job and pipelines definition
ADD jobs.groovy  /tmp/

# Copy init script
COPY init-jenkins.groovy /usr/share/jenkins/ref/init.groovy.d/
