# https://github.com/iotaledger/rpchub/blob/master/docs/getting_started.md

# FROM debian:9
FROM ubuntu:18.04

WORKDIR /root
EXPOSE 50051

# reqs
RUN apt-get update && \
  apt-get install -y wget sqlite3 python python-pip
RUN pip install pyparsing

# bazel
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.19.2/bazel_0.19.2-linux-x86_64.deb
RUN dpkg -i bazel_0.19.2-linux-x86_64.deb; exit 0
RUN apt install -y -f && \
  dpkg -i bazel_0.19.2-linux-x86_64.deb && \
  rm -f bazel_0.19.2-linux-x86_64.deb

# rpchub
RUN mkdir -p rpchub && \
  wget -O - https://github.com/iotaledger/rpchub/archive/v1.0.0.tar.gz | tar xzf - --strip-components 1 -C rpchub
RUN cd rpchub && bazel build -c opt //hub:hub

# sqlite3
RUN mkdir -p /data
RUN sqlite3 /data/wallet.db3 -init /root/rpchub/schema/schema.sql .exit && \
  sqlite3 /data/wallet.db3 -init /root/rpchub/schema/triggers.sqlite3.sql .exit

RUN rm -f /var/cache/apt/archives/*

ENTRYPOINT ["/root/rpchub/bazel-bin/hub/hub", "--dbType", "sqlite3", "--db", "/data/wallet.db3", "--minWeightMagnitude", "14", "--salt", "rJ8067pkJ4QvIuB7f7tZd"]
