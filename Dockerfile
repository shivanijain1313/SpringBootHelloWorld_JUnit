FROM tomcat:alpine
MAINTAINER Shivani Jain
RUN wget -O /usr/local/tomcat/webapps/shivanijain01.jar http://host.docker.internal:8082/artifactory/jenkins-snapshot/com/javainuse/SpringBootHelloWorld/0.0.1-SNAPSHOT/SpringBootHelloWorld-0.0.1-20200830.123154-1.jar

EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
