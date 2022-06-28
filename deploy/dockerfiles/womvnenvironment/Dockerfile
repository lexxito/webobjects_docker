FROM maven:3.8.5-openjdk-11

COPY deploy/mvn/settings.xml /root/.m2/
COPY deploy/mvn/archetype-catalog.xml /root/.m2/
COPY deploy/mvn/pom.xml /root/

RUN mvn  wobootstrap:install -DwebObjectsLibFolder=/home -DwebObjectsVersion=5.4.3

WORKDIR /root/

RUN mvn dependency:resolve
