import Dependencies._

lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.example",
      scalaVersion := "2.12.6",
      version      := "0.1.0-SNAPSHOT"
    )),
    name := "messagepacking",
    libraryDependencies += scalaTest % Test
  )

libraryDependencies += "com.fasterxml.jackson.core" % "jackson-databind" % "2.8.4"
libraryDependencies += "com.fasterxml.jackson.module" %% "jackson-module-scala" % "2.8.4"s
