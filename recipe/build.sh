#!/usr/bin/env bash

mkdir build
cd build

if [[ "$(uname)" == "Darwin" ]]; then
    export ENABLE_TESTS=no
    export AR_CMAKE_SETTING=
    export RANLIB_CMAKE_SETTING=
else
    LDFLAGS="-lrt ${LDFLAGS}"
    export ENABLE_TESTS=yes
    # Workaround for making the LTO machinery work on Linux.
    export AR_CMAKE_SETTING="-DCMAKE_CXX_COMPILER_AR=$GCC_AR -DCMAKE_C_COMPILER_AR=$GCC_AR"
    export RANLIB_CMAKE_SETTING="-DCMAKE_CXX_COMPILER_RANLIB=$GCC_RANLIB -DCMAKE_C_COMPILER_RANLIB=$GCC_RANLIB"
fi

cmake \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DPAGMO_WITH_EIGEN3=yes \
    -DPAGMO_WITH_NLOPT=yes \
    -DPAGMO_WITH_IPOPT=yes \
    -DPAGMO_BUILD_TESTS=$ENABLE_TESTS \
    -DPAGMO_ENABLE_IPO=yes \
    $AR_CMAKE_SETTING \
    $RANLIB_CMAKE_SETTING \
    -DPAGMO_BUILD_TUTORIALS=yes \
    ..

make

ctest

make install
