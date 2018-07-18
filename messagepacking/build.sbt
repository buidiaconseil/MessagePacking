import Dependencies._

lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.buissondiaz",
      scalaVersion := "2.12.6",
      version      := "0.1.0-SNAPSHOT"
    )),
    name := "messagepacking",
    libraryDependencies += scalaTest % Test
  )

libraryDependencies += "com.fasterxml.jackson.core" % "jackson-databind" % "2.8.4"
libraryDependencies += "com.fasterxml.jackson.module" %% "jackson-module-scala" % "2.8.4"
libraryDependencies += "org.apache.avro"  %  "avro"  %  "1.8.2"
libraryDependencies += "org.msgpack" %% "msgpack-scala"  %  "0.8.13"
libraryDependencies += "com.esotericsoftware" % "kryo" % "5.0.0-RC1"
libraryDependencies += "io.protostuff" % "protostuff" % "1.6.0" pomOnly()
libraryDependencies += "io.protostuff" % "protostuff-core" % "1.6.0"
libraryDependencies += "io.protostuff" % "protostuff-runtime" % "1.6.0"
