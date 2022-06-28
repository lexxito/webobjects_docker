FROM lexxito/woantenvironment:1.10.3-jdk8-wonder7.4 as build

COPY . .

RUN ant -f build.xml -Duser.home=/opt -lib /opt/ant/lib/woproject.jar 

FROM openjdk:11-oracle

ENV PROJECT_NAME=wodockerapp
COPY --from=build /root/dist/${PROJECT_NAME}.woa /woapps/${PROJECT_NAME}.woa

ENV NEXT_ROOT=/

CMD /woapps/${PROJECT_NAME}.woa/${PROJECT_NAME} -WODirectConnectEnabled YES -WOPort 2000 
