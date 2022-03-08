FROM fedora:35

RUN dnf update -y
RUN dnf install sqlite-devel protobuf-devel gcc-c++ meson ninja-build python3-pip which -y
RUN pip install poetry
WORKDIR /sqlite_protobuf
CMD ["./build.sh"]