#!/usr/bin/env bash

mkdir build
cd build

if [[ "$(uname)" == "Darwin" ]]; then
    export ENABLE_TESTS=no
else
    LDFLAGS="-lrt ${LDFLAGS}"
    export ENABLE_TESTS=yes
fi

cmake \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DPAGMO_WITH_EIGEN3=yes \
    -DPAGMO_WITH_NLOPT=yes \
    -DPAGMO_WITH_IPOPT=yes \
    -DPAGMO_BUILD_TESTS=$ENABLE_TESTS \
    -DPAGMO_BUILD_TUTORIALS=yes \
    ..

make

ctest

make install
