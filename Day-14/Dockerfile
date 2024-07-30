FROM openjdk:11
RUN mkdir -p /usr/src/myapp
COPY Sample.java /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac Sample.java
CMD ["java", "Sample"]