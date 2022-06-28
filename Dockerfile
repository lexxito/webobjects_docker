FROM lexxito/womvnenvironment:3.8.5-openjdk-11-wonder7.3 as build

COPY . .

RUN mvn -Pnoneclipse compile war:war

FROM jetty:9.4.46-jre11-openjdk

#Billions of credits to this guy https://www.databasesandlife.com/activation-error-jetty-javamail-java11/
#Opened issue for jetty https://github.com/eclipse/jetty.docker/issues/10
RUN rm -r /usr/local/jetty/lib/mail

COPY --from=build /root/target/*.war /var/lib/jetty/webapps/ROOT.war
