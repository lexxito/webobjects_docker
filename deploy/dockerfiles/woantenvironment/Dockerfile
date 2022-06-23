FROM frekele/ant:1.10.3-jdk8 as build

#Installing WebObjects 5.4.3 naitive libraries 
RUN wget https://jenkins.wocommunity.org/job/WOInstaller/lastSuccessfulBuild/artifact/Utilities/WOInstall/WOInstaller.jar
RUN java -jar WOInstaller.jar 5.4.3 /opt || true

#Installing Wonder libraries
RUN wget https://jenkins.wocommunity.org/job/Wonder7/lastSuccessfulBuild/artifact/Root/Roots/Wonder-Frameworks.tar.gz
RUN tar -xf Wonder-Frameworks.tar.gz  -C /opt/Library/Frameworks/

#Download woproject.jar for compiling ant project
RUN wget https://jenkins.wocommunity.org/job/WOLips410/ws/wolips/core/plugins/org.objectstyle.wolips.woproject/lib/woproject.jar -P /opt/ant/lib/

ENV PATH_WITH_SPACE "/opt/Library/Application Support/WOLips/wolips.properties"
COPY deploy/wolips.properties $PATH_WITH_SPACE
