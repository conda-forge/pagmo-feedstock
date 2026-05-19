cmake %CMAKE_ARGS% -LAH -G Ninja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DPAGMO_WITH_EIGEN3=yes ^
    -DPAGMO_WITH_NLOPT=yes ^
    -DPAGMO_WITH_IPOPT=yes ^
    -DPAGMO_BUILD_TESTS=yes ^
    -DPAGMO_BUILD_TUTORIALS=yes ^
    -DPAGMO_ENABLE_IPO=yes ^
    -DCMAKE_UNITY_BUILD=ON ^
    -B build .

cmake --build build --config Release --target install

ctest --test-dir build
