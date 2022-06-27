FROM httpd:2.4

ARG LINK_BASE=apps
ARG RESOURCES_PATH=/usr/local/apache2/htdocs/WebObjects

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
  && sed -ri 's#WebObjectsAlias /cgi-bin/WebObjects#WebObjectsAlias /'"$LINK_BASE"'/WebObjects#g' apache.conf \
  && sed -ri 's#WebObjectsDocumentRoot LOCAL_LIBRARY_DIR/WebServer/Documents#WebObjectsDocumentRoot '"$RESOURCES_PATH"'#g' apache.conf \
  && sed -ri 's#WebObjectsConfig http://localhost:1085 10#WebObjectsConfig file:///opt/Local/Library/WebObjects/Configuration/WOConfig.xml 10#g' apache.conf \
  && echo '<Location /'"$LINK_BASE"'/WebObjects> \n\
    Require all granted \n \
</Location>\n \
<Location /WebObjects>\n \
    Require all granted\n \
</Location>' >> apache.conf \
  && mv apache.conf /usr/local/apache2/conf/webobjects.conf \
  && echo "Include /usr/local/apache2/conf/webobjects.conf" >> /usr/local/apache2/conf/httpd.conf \
  && rm /tmp/master.tar.gz && rm -Rf /tmp/wonder-master \
  && apt-get purge -y --auto-remove $buildDeps

CMD httpd-foreground
