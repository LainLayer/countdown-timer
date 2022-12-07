#!/bin/bash

set -xe


# CFLAGS="-mretpoline -fstack-clash-protection -fcf-protection -fstack-protector-strong -funsigned-char -ffast-math -ffunction-sections -fdata-sections -march=native -Oz --ld-path=/usr/bin/ld.lld"
CFLAGS="-fstack-clash-protection -fcf-protection -fstack-protector-strong -funsigned-char -ffast-math -ffunction-sections -fdata-sections -march=native -Oz"

# CC="clang"
CC="gcc"

cd ./musl/
make clean
./configure CC=$CC CFLAGS=$CFLAGS --exec_prefix=$(pwd) --prefix=$(pwd)/dest
make -j$(nproc) -B
make install
cd ..

nim r numbers.nim

nim c -f\
	--cc:$CC \
	--gcc.exe:./musl/dest/bin/musl-$CC \
	--gcc.linkerexe:./musl/dest/bin/musl-$CC \
	-d:release \
	-d:danger \
	-d:lto \
	--mm:arc \
	--opt:size \
	--passL:"-Wl,--gc-sections" \
	--passL:"-static" \
	--passC:"$CFLAGS" \
	countdown.nim && strip --strip-all countdown

	# --passL:"-strip-all" \
