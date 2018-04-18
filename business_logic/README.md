# How to run

## Issues

Currently doesn't use the gradle-docker plugin so dockerfile
changes have to manually be rebuild.

In the /business_logic/ folder run the following:

```Bash
docker build -t businesslogic .
```

## Use

### Without Docker

Build using gradle by runnning:

```Bash
./gradlew build
```

Run using:

```Bash
java -jar build/libs/business-logic-0.1.0.jar
```

### Using Docker

Build a new Docker Image and then run

```Bash
docker run -p 8080:8080 -t businesslogic
```

#### Create new docker image using the gradle plugin

Run the gradle command in the project folder

```Bash
./gradlew build docker
```

#### Manually create a new docker image

Run the docker command in the project folder

```Bash
docker build -t businesslogic .
```

