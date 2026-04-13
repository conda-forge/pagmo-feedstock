cmake %CMAKE_ARGS% -LAH -G "Ninja" ^
    -DBoost_NO_BOOST_CMAKE=ON ^
    -DPAGMO_WITH_EIGEN3=yes ^
    -DPAGMO_WITH_NLOPT=yes ^
    -DPAGMO_WITH_IPOPT=yes ^
    -DPAGMO_BUILD_TESTS=yes ^
    -DPAGMO_BUILD_TUTORIALS=yes ^
    -DPAGMO_ENABLE_IPO=yes ^
    -B build .

cd build
cmake --build . --config Release --target install

ctest
