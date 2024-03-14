FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
#COPY /webapp/target/*.war /usr/local/tomcat/webapps
COPY  /home/CI-CD-Project3/project3/target/*.war /usr/local/tomcat/webapps

