#!/bin/bash

export CC=gcc-7
export CXX=g++-7

# Set this variable to your desired install directory
INSTALL_PREFIX=$(pwd)/triqs_2.1.x

# Set the number of cores for the compilation
NCORES=32

# Use cmake to configure the triqs build process
mkdir -p triqs.build && cd triqs.build
cmake ../triqs.src -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
                   -DCMAKE_CXX_FLAGS="-std=c++17 -g -O3 -fopenmp"

# Build, test and install triqs
make -j$NCORES && make test && make install
cd ../

# Copy the script that was used to install in the install directory
cp install_triqs.sh $INSTALL_PREFIX/install_triqs.sh
