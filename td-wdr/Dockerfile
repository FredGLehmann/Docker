FROM amazoncorretto:8

LABEL version="1.0"
LABEL description="tomacat wdr user image"
LABEL author="frederic.lehmann@transdev.com"

ARG stage=pprod

ENV TOMCATMAJORVERSION=10
ENV TOMCATMINORVERSION=10.0.27
ENV TOMCATSOURCEMIRROR=dlcdn.apache.org
ENV TOMCATSECUMIRROR=downloads.apache.org
ENV TOMCATSOURCEPATH=tomcat/tomcat-${TOMCATMAJORVERSION}/v${TOMCATMINORVERSION}/bin
ENV TOMCATPKGFILE=apache-tomcat-10.0.27.tar.gz
ENV TOMCATPGPFILE=${TOMCATPKGFILE}.asc
ENV TOMCATSHAFILE=${TOMCATPKGFILE}.sha512

#https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

# Let's update the container
RUN yum update -y && yum -y install shadow-utils.x86_64 wget tar gzip && yum clean all

# Let's create tomcat group/user
RUN groupadd tomcat
RUN useradd -d ${CATALINA_HOME} -g tomcat -s /bin/false tomcat

# Let's download Tomcat package and check files
RUN cd /tmp
RUN wget https://${TOMCATSOURCEMIRROR}/tomcat/tomcat-${TOMCATMAJORVERSION}/v${TOMCATMINORVERSION}/bin/${TOMCATPKGFILE}
RUN wget https://${TOMCATSECUMIRROR}/tomcat/tomcat-${TOMCATMAJORVERSION}/v${TOMCATMINORVERSION}/bin/${TOMCATPGPFILE}
RUN wget https://${TOMCATSECUMIRROR}/tomcat/tomcat-${TOMCATMAJORVERSION}/v${TOMCATMINORVERSION}/bin/${TOMCATSHAFILE}
RUN wget https://${TOMCATSECUMIRROR}/tomcat/tomcat-${TOMCATMAJORVERSION}/KEYS

# Let's vertify our download and install it
RUN gpg --import KEYS 
RUN gpg --batch --verify ${TOMCATPGPFILE} ${TOMCATPKGFILE}
RUN sha512sum --check --strict ${TOMCATSHAFILE}
RUN tar xvf ${TOMCATPKGFILE} -C ${CATALINA_HOME} --strip-components=1
RUN chgrp -R tomcat ${CATALINA_HOME}
RUN chmod g+rwx ${CATALINA_HOME}/conf
RUN chmod g+r ${CATALINA_HOME}/conf/*

# Let's make a simple test
RUN catalina.sh version

# Let's start tomcat
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
