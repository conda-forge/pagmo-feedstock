mkdir build
cd build

cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBoost_NO_BOOST_CMAKE=ON ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DPAGMO_WITH_EIGEN3=yes ^
    -DPAGMO_WITH_NLOPT=yes ^
    -DPAGMO_WITH_IPOPT=yes ^
    -DPAGMO_BUILD_TESTS=yes ^
    -DPAGMO_BUILD_TUTORIALS=yes ^
    -DPAGMO_ENABLE_IPO=yes ^
    ..

cmake --build . --config Release --target install

ctest
