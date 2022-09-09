#!/usr/bin/env bash

mkdir build
cd build

if [[ "$target_platform" == osx-* ]]; then
    # Workaround for compile issue on older OSX SDKs.
    export CXXFLAGS="$CXXFLAGS -fno-aligned-allocation"
else
    LDFLAGS="-lrt ${LDFLAGS}"
fi

if test "$target_platform" != "linux-ppc64le"
then
  CMAKE_ARGS="${CMAKE_ARGS} -DPAGMO_ENABLE_IPO=ON"
fi

cmake ${CMAKE_ARGS} \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DPAGMO_WITH_EIGEN3=yes \
    -DPAGMO_WITH_NLOPT=yes \
    -DPAGMO_WITH_IPOPT=yes \
    -DPAGMO_BUILD_TESTS=yes \
    -DPAGMO_BUILD_TUTORIALS=yes \
    ..

make install -j${CPU_COUNT}

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    ctest -j${CPU_COUNT} --output-on-failure --timeout 1000 -E fork_island
fi
