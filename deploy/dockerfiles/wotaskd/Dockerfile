FROM openjdk:11-oracle

# Installation of wotaskd and javamonitor
ENV NEXT_ROOT /opt
ENV WEBOBJECTS_ARGS ""

RUN  mkdir -p /woapps \
  && cd /woapps \
  && curl -LOk https://jenkins.wocommunity.org/job/Wonder7/lastSuccessfulBuild/artifact/Root/Roots/wotaskd.tar.gz  \
  && tar xzf wotaskd.tar.gz && rm wotaskd.tar.gz  \
  && mkdir /var/log/webobjects

EXPOSE 1085

CMD /woapps/wotaskd.woa/wotaskd $WEBOBJECTS_ARGS
