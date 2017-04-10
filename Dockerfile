#
# Scala and sbt Dockerfile
#
# https://github.com/hseeberger/scala-sbt
#

# Pull base image
FROM  openjdk:8-jre-alpine

ENV SCALA_VERSION 2.12.1
ENV SBT_VERSION 0.13.15

RUN \
  touch /usr/lib/jvm/java-1.8-openjdk/jre/release && \
  apk add --no-cache bash && \
  apk add --no-cache curl && \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /usr/local && \
  ln -s /usr/local/scala-2.12.1/bin/* /usr/local/bin/ && \
  scala -version && \
  scalac -version

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

# Define working directory
WORKDIR /root
