mkdir build
cd build

cmake ^
    -G "Visual Studio 15 2017 Win64" ^
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

cmake --build . --config RelWithDebInfo --target install

ctest
