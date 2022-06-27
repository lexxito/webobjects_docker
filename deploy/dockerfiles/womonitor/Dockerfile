FROM openjdk:11-oracle

# Installation of wotaskd and javamonitor
ENV NEXT_ROOT /opt
ENV WEBOBJECTS_ARGS -DWOPort=56789

RUN  mkdir -p /woapps \
  && cd /woapps \
  && curl -LOk https://jenkins.wocommunity.org/job/Wonder7/lastSuccessfulBuild/artifact/Root/Roots/JavaMonitor.tar.gz  \
  && tar xzf JavaMonitor.tar.gz && rm JavaMonitor.tar.gz  

EXPOSE 56789

CMD /woapps/JavaMonitor.woa/JavaMonitor $WEBOBJECTS_ARGS
