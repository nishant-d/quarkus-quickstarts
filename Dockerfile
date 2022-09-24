FROM maven:3.6.3-jdk-11-slim  as build
WORKDIR /app
ADD ./pom.xml /app/pom.xml
RUN mvn dependency:go-offline
ADD ./src ./src
RUN mvn clean package

FROM openjdk:11-jre-slim 
COPY --from=build  /app/target/quarkus-app/  /app/
EXPOSE 8080  
CMD ["java","-jar","/app/quarkus-run.jar"]  
