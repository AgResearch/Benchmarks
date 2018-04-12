# IOzone Filesystem Benchmark

IOzone is a free filesystem benchmark tool.  It generates and measure a
variety of file operations.

## Purpose

This benchmark is used to measure the performance of the platform's filesystem.
It measures the performance of the following operations: *Read, write, re-read, r
e-write, read backwards, read strided, fread, fwrite, random read, pread ,mmap, 
aio_read, aio_write.*

## Installation

The benchmark (v3-471)can be downloaded from http://www.iozone.org/src/current/iozone3_471.tar

Once the file is downloaded, navigate to the directory where the downloaded file is store and use the following instructions to build it:

```
tar xf iozone3_471.tar
cd iozone3_471/src
make
# make will display a list of supported platform.  Pick the one that matches the platform.
make <target>

```

## Execution

Instructions for executing this benchmark. to be completed.
