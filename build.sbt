name := "SBTProjectTemplate"

version := "0.0.1"

scalaVersion := "2.12.5"

libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.4" % Test

coverageEnabled := true

coverageMinimum := 80

coverageFailOnMinimum := true

mainClass in assembly := Some("com.jd.SBTProject.Template")

assemblyJarName in assembly := "SBTProjectTemplate.jar"