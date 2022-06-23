FROM lexxito/woantenvironment:1.10.3-jdk8-wonder7.4 as build

COPY . .

RUN ant -f build.xml -Duser.home=/opt -lib /opt/ant/lib/woproject.jar 

FROM lexxito/woallinone:apache2.4-wonder7.4

ENV PROJECT_NAME=wodockerapp

#Copy compiled resources and place webserver resources to single place
COPY --from=build /root/dist/${PROJECT_NAME}.woa /woapps/${PROJECT_NAME}.woa
