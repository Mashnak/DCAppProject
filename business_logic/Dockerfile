FROM openjdk:8-jdk-alpine
VOLUME /tmp
# ARG JAR_FILE USE WHEN DOCKER-GRADLE WORKS
# ADD ${JAR_FILE} app.jar
EXPOSE 8080
ADD build/libs/business-logic-0.1.0.jar app.jar
# ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar", "--DB.ip=$ip", "--DB.port=$port"]
ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom -jar /app.jar --DB.ip=$DB_IP --DB.port=$DB_PORT
