FROM frekele/ant:1.10.3-jdk8 as build

#Installing WebObjects 5.4.3 naitive libraries 
RUN wget https://jenkins.wocommunity.org/job/WOInstaller/lastSuccessfulBuild/artifact/Utilities/WOInstall/WOInstaller.jar
RUN java -jar WOInstaller.jar 5.4.3 /opt || true

#Installing Wonder libraries
RUN wget https://jenkins.wocommunity.org/job/Wonder7/lastSuccessfulBuild/artifact/Root/Roots/Wonder-Frameworks.tar.gz
RUN tar -xf Wonder-Frameworks.tar.gz  -C /opt/Library/Frameworks/

#Download woproject.jar for compiling ant project
RUN wget https://jenkins.wocommunity.org/job/WOLips410/ws/wolips/core/plugins/org.objectstyle.wolips.woproject/lib/woproject.jar -P /opt/ant/lib/

COPY . .

ENV PATH_WITH_SPACE "/opt/Library/Application Support/WOLips/wolips.properties"
COPY deploy/wolips.properties $PATH_WITH_SPACE

RUN ant -f build.xml -Duser.home=/opt -lib /opt/ant/lib/woproject.jar 

FROM openjdk:11-oracle as java

FROM httpd:2.4

# Compilation and installation of adaptor
ENV buildDeps gcc make libc6-dev libpcre++-dev apache2-dev
RUN  set -x \
  && apt-get update \
  && apt-get install --yes --no-install-recommends curl $buildDeps \
  && rm -r /var/lib/apt/lists/* \
  && cd /tmp \
  && curl -LOk https://github.com/wocommunity/wonder/archive/master.tar.gz \
  && tar xfz master.tar.gz \
  && cd /tmp/wonder-master/Utilities/Adaptors \
  && sed -ri 's/ADAPTOR_OS = MACOS/ADAPTOR_OS = LINUX/g' make.config \
  && sed -ri 's/ADAPTORS = CGI Apache2.2/ADAPTORS = Apache2.4/g' make.config \
  && make \
  && cd /tmp/wonder-master/Utilities/Adaptors/Apache2.4 \
  && mv mod_WebObjects.so /usr/local/apache2/modules/. \
  && mkdir /usr/local/apache2/htdocs/WebObjects \
  && sed -ri 's#WebObjectsAlias /cgi-bin/WebObjects#WebObjectsAlias /apps/WebObjects#g' apache.conf \
  && sed -ri 's#WebObjectsDocumentRoot LOCAL_LIBRARY_DIR/WebServer/Documents#WebObjectsDocumentRoot /usr/local/apache2/htdocs/WebObjects#g' apache.conf \
  && echo "<Location /apps/WebObjects> \n\
    Require all granted \n \
</Location>\n \
<Location /WebObjects>\n \
    Require all granted\n \
</Location>" >> apache.conf \
  && mv apache.conf /usr/local/apache2/conf/webobjects.conf \
  && echo "Include /usr/local/apache2/conf/webobjects.conf" >> /usr/local/apache2/conf/httpd.conf \
  && rm /tmp/master.tar.gz && rm -Rf /tmp/wonder-master \
  && apt-get purge -y --auto-remove $buildDeps

#COPY deploy/apache.conf /usr/local/apache2/conf/webobjects.conf
COPY --from=java /usr/java/openjdk* /usr/java

RUN ln -s /usr/java/bin/java /usr/bin/java

# Installation of wotaskd and javamonitor
ENV NEXT_ROOT /opt

RUN  mkdir -p /woapps \
  && cd /woapps \
  && curl -LOk https://jenkins.wocommunity.org/job/Wonder7/lastSuccessfulBuild/artifact/Root/Roots/JavaMonitor.tar.gz  \
  && tar xzf JavaMonitor.tar.gz && rm JavaMonitor.tar.gz  \
  && curl -LOk https://jenkins.wocommunity.org/job/Wonder7/lastSuccessfulBuild/artifact/Root/Roots/wotaskd.tar.gz  \
  && tar xzf wotaskd.tar.gz && rm wotaskd.tar.gz  \
  && mkdir /var/log/webobjects

COPY --from=build /root/dist/webobjects_docker.woa /woapps/webobjects_docker.woa

RUN ln -s /woapps/webobjects_docker.woa /usr/local/apache2/htdocs/WebObjects/webobjects_docker.woa

COPY deploy/launchwo.sh /woapps/launchwo.sh
RUN chmod +x /woapps/launchwo.sh

EXPOSE 80 1085 56789

CMD ["/woapps/launchwo.sh"]
