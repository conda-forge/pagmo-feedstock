cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_UNITY_BUILD=ON ^
    -DPAGMO_WITH_EIGEN3=yes ^
    -DPAGMO_WITH_NLOPT=yes ^
    -DPAGMO_WITH_IPOPT=yes ^
    -DPAGMO_BUILD_TESTS=yes ^
    -DPAGMO_BUILD_TUTORIALS=yes ^
    -DPAGMO_ENABLE_IPO=yes ^
    -B build .

cmake --build build --config Release --target install

ctest --test-dir build --output-on-failure
