#!/usr/bin/env bash

if [[ "$target_platform" == osx-* ]]; then
    # Workaround for compile issue on older OSX SDKs.
    export CXXFLAGS="$CXXFLAGS -fno-aligned-allocation"
else
    LDFLAGS="-lrt ${LDFLAGS}"
fi

if [[ "$target_platform" != "linux-ppc64le" && "$target_platform" != "osx-arm64" ]]; then
  CMAKE_ARGS="${CMAKE_ARGS} -DPAGMO_ENABLE_IPO=ON"
fi

cmake ${CMAKE_ARGS} -LAH \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DPAGMO_WITH_EIGEN3=yes \
    -DPAGMO_WITH_NLOPT=yes \
    -DPAGMO_WITH_IPOPT=yes \
    -DPAGMO_BUILD_TESTS=yes \
    -DPAGMO_BUILD_TUTORIALS=yes \
    -B build .

cd build
make install -j${CPU_COUNT}

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    ctest -j${CPU_COUNT} --output-on-failure --timeout 1000 -E fork_island
fi
