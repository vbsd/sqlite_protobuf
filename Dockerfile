FROM ubuntu:21.10

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install libsqlite3-dev libprotobuf-dev protobuf-compiler g++ cmake pkg-config meson ninja-build python3-pip -y
RUN pip install poetry
WORKDIR /sqlite_protobuf
CMD ["./build.sh"]