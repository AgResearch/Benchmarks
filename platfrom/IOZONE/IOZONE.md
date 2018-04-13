# IOzone Filesystem Benchmark

IOzone is a free filesystem benchmark tool.  It generates and measure a variety of file operations.

## Purpose

This benchmark is used to measure the performance of the platform's filesystem. It measures the performance of the following operations: *Read, write, re-read, re-write, read backwards, read strided, fread, fwrite, random read, pread ,mmap, aio_read, aio_write.*

## Installation

The benchmark (v3-471)can be downloaded from http://www.iozone.org/src/current/iozone3_471.tar

```
wget http://www.iozone.org/src/current/iozone3_471.tar
```

Once the file is downloaded, navigate to the directory where the downloaded file is store and use the following instructions to build it.  A C compiler and make is required to build it.

```
tar xf iozone3_471.tar
cd iozone3_471/src
make
# make will display a list of supported platforms.  Pick the one that matches the testing platform.
make <target>
```

## Execution

Use the following command to test the performance of a specified file system on

* write/rewrite
* read/re-read
* random-read/random-write

The test produces output that cover all tested file operations for record size of 4k to 16M for file size of 64k to a specified file size, which should be twice the size of the memory of the node where the benchmark is run.  The output will also be stored in an Excel file called IOZone_results.xls

```
./iozone -az -i 0 -i 1 -i 2 –c –e -b IOZone_results.xls \
         -f <file system> \
         -y 4 -q 16m \
         -g <max file size>
```
