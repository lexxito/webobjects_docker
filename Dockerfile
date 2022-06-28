FROM lexxito/womvnenvironment:3.8.5-openjdk-11-wonder7.3 as build

COPY . .

RUN mvn package

FROM openjdk:11-oracle

ENV PROJECT_NAME=wodockerapp
COPY --from=build /root/target/${PROJECT_NAME}.woa /woapps/${PROJECT_NAME}.woa

ENV NEXT_ROOT=/

CMD /woapps/${PROJECT_NAME}.woa/${PROJECT_NAME} -WODirectConnectEnabled YES -WOPort 2000 
