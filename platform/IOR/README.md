# IOR

IOR is open source (GPLv2) file system benchmarking program.

## Purpose

It measures the sustainable bandwidth of a file system  using the various APIs, such as POSIX, MPI-IO and S3.

## Installation

Download the latest release (v3.1.0) from GitHub and unpack the file.

```
$ cd $BENCHMARK_ROOT
$ git clone git@github.com:AgResearch/ior.git
```

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark.  For example:

```
$ mkdir -p $IOR_CONDA_ENV
$ conda-env create -p $IOR_CONDA_ENV -f $IOR_CONDA_ENV_SPEC
$ conda activate $IOR_CONDA_ENV
```

## Execution

### Sequential Write and Read on a compute node

Run IOR to benchmark the performance of a single process writing to a file and then reading such a file sequentially. The following commands serve as an example, you may need to customise it for the benchmarking platform.

```
$ conda activate $IOR_CONDA_ENV
$ ior -a POSIX -w -r -i 5 -e -b <block_size> -t <transfer_size> -o <path_to_target_filesystem>\ior_seq_test
```

Where ```<block_size>``` should be at least twice as large as the size of the memory of the compute node where the benchmark is executed, ``` <path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked and ```transfer_size``` may be chosen in such a manner as to tune for the file-system characteristics.

### Concurrent Sequential Read/Write on a compute node

Run IOR tests concurrently to benchmark the performance of a filesystem on a compute node. The following is an example bash script for this test, although it may need to be customised for the benchmarking platform.

```
conda activate $IOR_CONDA_ENV
echo "Preparing testing data..."
ior -a POSIX -w -e -k -b <block_size> -t <transfer_size> -o <path_to_target_filesystem>/ior_rw_test > ./ior_concurent.out
echo "Starging Concurrent Read..."
ior -a POSIX -r -E -b <block_size> -t <transfer_size> -o <path_to_target_filesystem>/ior_rw_test > ./ior_concurent_r.out&
echo "Starting Concurrent Write..."
ior -a POSIX -w -e -b <block_size> -t <transfer_size> -o <path_to_target_filesystem>/ior_rw_test2 > ./ior_concurent_w.out
echo "Done!"
```

Where ```<block_size>``` should be at least twice as large as the size of the memory of the compute node where the benchmark is executed, ``` <path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked and ```transfer_size``` may be chosen in such a manner as to tune for the file-system characteristics.

### Sequential Write and Read via MPIIO

Run IOR as a MPI program to benchmark the write and read performance of a platform's filesystem.  The following commands serve as an example, you may need to customise it for the benchmarking platform.

```
$ conda activate $IOR_CONDA_ENV
$ mpirun -np <num_tasks> ior -a MPIIO -w -r -i 5 -N <num_tasks> -b <block_size> -t <transfer_size> -o <path_to_target_filesystem>\ior_seq_test
```

Where ```<num_tasks>``` should be large enough to create sufficient load to test the aggregated bandwidth of the specified filesystem,  ```<block_size>``` times ```number of tasks allocated to a node``` should be twice as large as the size of the memory of the  compute node where the benchmark is executed, ```<path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked, and ```transfer_size``` may be chosen in such a manner as to tune for the file-system characteristics.
