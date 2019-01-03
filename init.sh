#!/usr/bin/env bash
#Retrieve User Input
read -p 'Enter Project Name: ' NAME
read -p 'Enter full package name: ' NAMESPACE
read -p 'Enter Name of Main Class: ' MAINCLASS
echo

#Some Setup
NAMESPACESL=$(echo ${NAMESPACE} | tr '.' '/')
mkdir tmp

echo Modifying the content of build.sbt
sed -i -e s/SBTProjectTemplate/${NAME}/g ./build.sbt
sed -i -e s/com.jd.SBTProject/${NAMESPACE}/g ./build.sbt
sed -i -e s/.Template/.${MAINCLASS}/g ./build.sbt

echo Modifying the content of README.md
sed -i -e s/SBTProjectTemplate/${NAME}/g ./README.md

echo Modifying the content of run.sh
sed -i -e s/SBTProjectTemplate/${NAME}/g ./run.sh

# Reused code to rename files and packages
proc() {
  LCP="main"
  if [[ $1 = true ]]; then
    PP="Test"
    LCP="test"
  fi
  sed -i -e s/com.jd.SBTProjectTemplate/${NAMESPACE}/g ./src/${LCP}/scala/com/jd/SBTProjectTemplate/SBTProjectMainClass"$PP".scala
  sed -i -e s/SBTProjectMainClass"$PP"/"$MAINCLASS""$PP"/g ./src/${LCP}/scala/com/jd/SBTProjectTemplate/SBTProjectMainClass"$PP".scala
  mv ./src/${LCP}/scala/com/jd/SBTProjectTemplate/SBTProjectMainClass"$PP".scala ./tmp/"$MAINCLASS""$PP".scala
  rm -r ./src/${LCP}/scala/*
  mkdir -p ./src/${LCP}/scala/${NAMESPACESL}/
  mv ./tmp/"$MAINCLASS""$PP".scala ./src/${LCP}/scala/${NAMESPACESL}/"$MAINCLASS""$PP".scala
}
echo Updating the file and directory structure of the main class
proc false
echo Updating the file and directory structure of the main class
proc true

echo Cleaning up install
rm -r tmp
rm -rf .git
git init
git add .
git commit -m "Initial Commit"

echo 'Ready for development! :)'
