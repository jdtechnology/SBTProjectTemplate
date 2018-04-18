#!/usr/bin/env bash

if [ -e target/scala-2.12/SBTProjectTemplate.jar ]; then
    java -jar target/scala-2.12/SBTProjectTemplate.jar
else
    sbt assembly
    java -jar target/scala-2.12/SBTProjectTemplate.jar
fi