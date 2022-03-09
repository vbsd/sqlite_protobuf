FROM ubuntu:21.10

ARG protobuf_version=3.19.4

# Ubuntu dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install libsqlite3-dev g++ cmake pkg-config meson ninja-build python3-pip wget autoconf automake libtool curl make g++ unzip python-setuptools -y

# Protobuf libraries and compiler
RUN wget -q https://github.com/protocolbuffers/protobuf/releases/download/v3.19.4/protobuf-python-${protobuf_version}.zip
RUN unzip protobuf-python-${protobuf_version}.zip
WORKDIR /protobuf-${protobuf_version}
RUN ./autogen.sh
RUN ./configure
RUN make -j$(nproc)
# RUN make check
RUN make install
RUN ldconfig

# Python protobuf
WORKDIR /protobuf-${protobuf_version}/python
RUN python3 setup.py build
RUN python3 setup.py test
RUN python3 setup.py install
RUN pip install protobuf==${protobuf_version}

WORKDIR /sqlite_protobuf
CMD ["./build.sh"]