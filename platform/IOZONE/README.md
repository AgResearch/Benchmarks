# IOzone Filesystem Benchmark

IOzone is a free filesystem benchmark tool.  It generates and measure a variety of file operations.

## Purpose

This benchmark is used to measure the performance of the platform's filesystem. It measures the performance of the following operations: *Read, write, re-read, re-write, read backwards, read strided, fread, fwrite, random read, pread ,mmap, aio_read, aio_write.*

## Installation

Create a Conda environment based on the provided environment file and then activate the environment:

```
$ mkdir -p $IOZONE_CONDA_ENV
$ conda-env create -p $IOZONE_CONDA_ENV -f $IOZONE_CONDA_ENV_SPEC
$ conda activate $IOZONE_CONDA_ENV
```

## Execution

Use the following command to test the performance of a specified file system on

* write/rewrite
* read/re-read
* random-read/random-write

The test produces output that cover all tested file operations for record size of 4k to 16M  and for file size of 64k to the max file size `<max_file_size>`, which should be twice the size of the memory of the node where the benchmark is run.  The output will also be stored in an Excel file called IOZone_results.xls

```
$ conda activate $IOZONE_CONDA_ENV
$ iozone -az -i 0 -i 1 -i 2 –c –e -b IOZone_results.xls \
         -f <file system> \
         -y 4 -q 16m \
         -g <max_file_size>
```
