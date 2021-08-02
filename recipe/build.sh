#!/usr/bin/env bash

mkdir build
cd build

if [[ "$target_platform" == osx-* ]]; then
    # Workaround for compile issue on older OSX SDKs.
    export CXXFLAGS="$CXXFLAGS -fno-aligned-allocation"
else
    LDFLAGS="-lrt ${LDFLAGS}"
fi

if [[ "$target_platform" == linux-aarch64 ||  "$target_platform" == linux-ppc64le ]]; then
    export ENABLE_IPOPT=no
else
    export ENABLE_IPOPT=yes
fi

cmake ${CMAKE_ARGS} \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DPAGMO_WITH_EIGEN3=yes \
    -DPAGMO_WITH_NLOPT=yes \
    -DPAGMO_WITH_IPOPT=$ENABLE_IPOPT \
    -DPAGMO_BUILD_TESTS=yes \
    -DPAGMO_ENABLE_IPO=yes \
    -DPAGMO_BUILD_TUTORIALS=yes \
    ..

make -j${CPU_COUNT} VERBOSE=1

if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
    ctest -j${CPU_COUNT} --output-on-failure
fi

make install
