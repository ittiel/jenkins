# Jenkins on Docker example
## This project builds a jenkins master on docker, with a predefined job

Build docker image: 

`build jenkins: docker build -t jenkins .`


Run docker container

`run jenkins:  docker run -d -p 8080:8080 -p 50000:50000 jenkins`

### jenkins login credentials
	user: admin
	pass: admin