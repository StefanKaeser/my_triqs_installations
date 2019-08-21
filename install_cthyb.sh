#!/bin/bash

export CC=gcc-7
export CXX=g++-7

# Make sure that the correct cpp2py and triqs are loaded
module load cpp2py/1.6.0
module load triqs/2.1.1

# Set this variable to your desired install directory
INSTALL_PREFIX=$(pwd)/cthyb_2.1.x

# Set the number of cores for the compilation
NCORES=32

# Use cmake to configure the cthyb build process
mkdir -p cthyb.build && cd cthyb.build
cmake ../cthyb.src -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
                   -DCMAKE_CXX_FLAGS="-std=c++17 -g -O3 -fopenmp"

# Build, test and install cthyb 
make -j$NCORES && make test && make install

# Modulefile is only avaible in build -> copy to install directory
cp cthyb.modulefile $INSTALL_PREFIX/share/cthyb.modulefile
cd ../

# Copy the script that was used to install in the install directory
cp install_cthyb.sh $INSTALL_PREFIX/install_cthyb.sh

