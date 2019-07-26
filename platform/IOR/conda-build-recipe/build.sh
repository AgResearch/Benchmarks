./bootstrap
./configure LDFLAGS="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib" CFLAGS="-I$PREFIX/include" --prefix=$PREFIX
make
make install