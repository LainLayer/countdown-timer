#!/bin/bash

set -xe

cd ./musl/
./configure CC=gcc CFLAGS="-O2 -march=native" --exec_prefix=$(pwd) --prefix=$(pwd)/dest
make -j$(nproc)
make install
cd ..

nim c\
	--cc:gcc\
	--gcc.exe:./musl/dest/bin/musl-gcc\
	--gcc.linkerexe:./musl/dest/bin/musl-gcc\
	-d:release\
	-d:danger\
	-d:lto\
	--mm:arc\
	-d:useMalloc\
	--opt:size\
	--passL:"-static -Wl,--gc-sections"\
	--passC:"-ffunction-sections -fdata-sections -march=native"\
	countdown.nim && strip -s countdown
