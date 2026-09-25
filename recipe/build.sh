#!/usr/bin/env bash

cmake ${CMAKE_ARGS} -G Ninja -LAH \
    -DCMAKE_BUILD_TYPE=Release \
    -DPAGMO_WITH_EIGEN3=yes \
    -DPAGMO_WITH_NLOPT=yes \
    -DPAGMO_WITH_IPOPT=yes \
    -DPAGMO_BUILD_TESTS=yes \
    -DPAGMO_BUILD_TUTORIALS=yes \
    -DCMAKE_UNITY_BUILD=ON \
    -B build .

cmake --build build --target install --parallel ${CPU_COUNT}

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    ctest --test-dir build -j${CPU_COUNT} --output-on-failure --timeout 200
fi
