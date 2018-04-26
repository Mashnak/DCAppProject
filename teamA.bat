@echo off

set command=%1

if "%command%" == "init" (
  echo "Initializing Backend"
  cd .\backend\
  @echo on
  npm install
  docker pull mongo
  docker image build -t backend .
  @echo off

  echo "Initializing Business Logic"
  @echo on
  cd ..\business_logic\
  .\gradlew build
  docker pull openjdk:8-jdk-alpine
  docker image build -t businesslogic .
  @echo off
) else if "%command%" == "start" (
  docker container stop mongo_int backend_int businesslogic_int
  cd business_logic
  .\gradlew build
  docker-compose build
  docker-compose up
) else if "%command%" == "qstart" (
  docker container stop mongo_int backend_int businesslogic_int
  docker-compose up
) else if "%command%" == "startBE" (
  cd backend
  docker container stop mongo backend
  docker-compose build
  docker-compose up
) else if "%command%" == "qstartBE" (
  cd backend
  docker container stop mongo backend
  docker-compose up
) else if "%command%" == "startBL" (
  cd business_logic
  docker container stop mongo backend businesslogic
  .\gradlew build
  docker image build -t businesslogic .

  cd ..\backend\
  docker-compose up -d

  set ip=%2
  set port=%3

  if "%ip%"=="" (
    set ip="192.168.99.100"
  )
  if "%port%"=="" (
    set port="3000"
  )

  docker run -p 8080:8080 -e "DB_IP=%ip%" -e "DB_PORT=%port%" businesslogic
) else if "%command%" == "qstartBL" (
  cd backend
  docker container stop mongo backend businesslogic
  docker-compose up -d

  set ip=%2
  set port=%3

  if "%ip%"=="" (
    set ip="192.168.99.100"
  )
  if "%port%"=="" (
    set port="3000"
  )

  docker run -p 8080:8080 -e "DB_IP=%ip%" -e "DB_PORT=%port%" businesslogic
)
