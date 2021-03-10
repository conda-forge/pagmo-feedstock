#!/usr/bin/env bash

mkdir build
cd build

if [[ "$target_platform" == osx-* ]]; then
    export ENABLE_TESTS=yes
    # Workaround for compile issue on older OSX SDKs.
    export CXXFLAGS="$CXXFLAGS -fno-aligned-allocation"
else
    LDFLAGS="-lrt ${LDFLAGS}"
    export ENABLE_TESTS=yes
fi

cmake ${CMAKE_ARGS} \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DPAGMO_WITH_EIGEN3=yes \
    -DPAGMO_WITH_NLOPT=yes \
    -DPAGMO_WITH_IPOPT=yes \
    -DPAGMO_BUILD_TESTS=$ENABLE_TESTS \
    -DPAGMO_ENABLE_IPO=yes \
    -DPAGMO_BUILD_TUTORIALS=yes \
    ..

make -j${CPU_COUNT} VERBOSE=1

ctest -j${CPU_COUNT} --output-on-failure

make install
