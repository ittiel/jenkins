# Jenkins on Docker example    
 This project builds a jenkins master on docker, with a predefined job and plugins     
 ##### Build docker image:       
`docker build -t jenkins .`     
      
#####  Run docker container:      
 `docker run -d -p 8080:8080 -p 50000:50000 jenkins` 

 #####  Run docker-compose as daemon:  
 `docker-compose up -d`
 
 #### Advanced:     
##### Run Jenkins with **persistency** and **host docker** :  
 `docker run -d -p 8080:8080 -p 50000:50000 -v <Local folder>:/var/jenkins_home/ -v /var/run/docker.sock:/var/run/docker.sock jenkins`    
   
 ##### Run Jenkins with **JAVA_OPTS**   
 see full list  [here](https://wiki.jenkins.io/display/JENKINS/Features+controlled+by+system+properties)    
   
 Example:      
 `docker run -d -p 8080:8080 -p 50000:50000 --env JAVA_OPTS="-Dhudson.footerURL=http://mycompany.com -Djenkins.install.runSetupWizard=false" jenkins`   
  
#### jenkins authentication    
   
- Default:  user: admin pass: admin  
 - Recommended: [Google login plugin](https://plugins.jenkins.io/google-login) .   
 See Google OAuth configuration  [here](https://github.com/jenkinsci/google-login-plugin/blob/master/README.md) .   
 **Note**: Requires setting the URL of jenkins correctly in `Jenkins Location > Jenkins URL` first .   
  
#### Persistency and Backup  
- Run docker with shared volumes on the hosts (on AWS use EBS) .   
Example:    
`docker run -d -p 8080:8080 -p 50000:50000 -v <Host persistent folder>:/var/jenkins_home/  jenkins` - Backup and auditing:    
 -- [Backup configuration with git](https://plugins.jenkins.io/scm-sync-configuration)    
 -- [Backup configuration to s3]([https://plugins.jenkins.io/s3](https://plugins.jenkins.io/s3))


### Troubleshooting
In case you do want to override a file/configuration, append '.override' to the name of the reference file. 
E.g. a file named /usr/share/jenkins/ref/config.xml.override will overwrite an existing config.xml file in JENKINS_HOME.


#### Important: 
Due to a bug with Jenkins, restarting the docker image overrides the config.xml (including the security configuration)
Workaround: 
1. back up the config.xml
2. restore it after image restart
3. reload the local configuration from the Jenkins console.
