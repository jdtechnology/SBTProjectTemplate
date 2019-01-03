NAME=$1
NAMESPACE=$2
MAINCLASS=$3
NAMESPACESL=$(echo $2 | tr '.' '/')
#echo "com.jd.yay" | tr '.' '/'
echo $NAMESPACESL
mkdir tmp
#BUILD.SBT
sed -i -e s/SBTProjectTemplate/$NAME/g ./build.sbt
sed -i -e s/com.jd.SBTProject/$NAMESPACE/g ./build.sbt
sed -i -e s/.Template/.$MAINCLASS/g ./build.sbt
#README
sed -i -e s/SBTProjectTemplate/$NAME/g ./README.md
#RUN.SH
sed -i -e s/SBTProjectTemplate/$NAME/g ./run.sh
#MAINCLASS.SCALA
sed -i -e s/com.jd.SBTProjectTemplate/$NAMESPACE/g ./src/main/scala/com/jd/SBTProjectTemplate/SBTProjectMainClass.scala
sed -i -e s/SBTProjectMainClass/$MAINCLASS/g ./src/main/scala/com/jd/SBTProjectTemplate/SBTProjectMainClass.scala
mv ./src/main/scala/com/jd/SBTProjectTemplate/SBTProjectMainClass.scala ./tmp/$MAINCLASS.scala
rm -r ./src/main/scala/*
mkdir -p ./src/main/scala/$NAMESPACESL/
mv ./tmp/$MAINCLASS.scala ./src/main/scala/$NAMESPACESL/$MAINCLASS.scala
#MAINTESTCLASS.SCALA
sed -i -e s/com.jd.SBTProjectTemplate/$NAMESPACE/g ./src/test/scala/com/jd/SBTProjectTemplate/SBTProjectMainClassTest.scala
sed -i -e s/SBTProjectMainClassTest/"$MAINCLASS"Test/g ./src/test/scala/com/jd/SBTProjectTemplate/SBTProjectMainClassTest.scala
mv ./src/test/scala/com/jd/SBTProjectTemplate/SBTProjectMainClassTest.scala ./tmp/"$MAINCLASS"Test.scala
rm -r ./src/test/scala/*
mkdir -p ./src/test/scala/$NAMESPACESL/
mv ./tmp/"$MAINCLASS"Test.scala ./src/test/scala/$NAMESPACESL/"$MAINCLASS"Test.scala
