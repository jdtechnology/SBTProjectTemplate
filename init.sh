NAME=$1
NAMESPACE=$2
MAINCLASS=$3
NAMESPACESL=$(echo $2 | tr '.' '/')
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

# Temlate main and test classes
proc() {
  LCP="main"
  if [ $1 = true ]; then
    PP="Test"
    LCP="test"
  fi
  sed -i -e s/com.jd.SBTProjectTemplate/$NAMESPACE/g ./src/$LCP/scala/com/jd/SBTProjectTemplate/SBTProjectMainClass"$PP".scala
  sed -i -e s/SBTProjectMainClass"$PP"/"$MAINCLASS""$PP"/g ./src/$LCP/scala/com/jd/SBTProjectTemplate/SBTProjectMainClass"$PP".scala
  mv ./src/$LCP/scala/com/jd/SBTProjectTemplate/SBTProjectMainClass"$PP".scala ./tmp/"$MAINCLASS""$PP".scala
  rm -r ./src/$LCP/scala/*
  mkdir -p ./src/$LCP/scala/$NAMESPACESL/
  mv ./tmp/"$MAINCLASS""$PP".scala ./src/$LCP/scala/$NAMESPACESL/"$MAINCLASS""$PP".scala
}
proc false
proc true

#CleanUp
rm -r tmp
rm -rf .git
git init
git add .
git commit -m "Initial Commit"
