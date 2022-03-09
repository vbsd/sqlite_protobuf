#!/bin/bash
set -ue

printf "\n\nBUILDING libsqlite_protobuf\n\n"

rm -rf builddir
meson builddir
pushd builddir
meson compile
popd

printf "\n\nRUNNING libsqlite_protobuf TEST\n\n"

pushd pytests/unit
export SQLITE_PROTOBUF_EXTENSION_PATH=../../builddir/libsqlite_protobuf.so
for test in $(python3 ../list_tests.py .)
do
    python3 -X faulthandler -m unittest -v $test
done
popd