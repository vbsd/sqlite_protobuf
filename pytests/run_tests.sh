#!/bin/bash

export SQLITE_PROTOBUF_EXTENSION_PATH=../../builddir/libsqlite_protobuf.so

cd unit
for test in $(poetry run python ../list_tests.py .)
do
    poetry run python -X faulthandler -m unittest -v $test
done
