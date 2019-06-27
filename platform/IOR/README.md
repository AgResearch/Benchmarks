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

Use the following instructions to navigate into directory, ior, and to build it.

```
$ cd $BENCHMARK_ROOT/ior
$ ./bootstrap
$ ./configure LDFLAGS="-L$CONDA_PREFIX/lib -Wl,-rpath,$CONDA_PREFIX/lib" CFLAGS="-I$CONDA_PREFIX/include" --prefix=$CONDA_PREFIX
$ make
$ make install
```

## Execution

### Sequential Write and Read on a compute node

Run IOR to benchmark the performance of a single process writing to a file and then reading such a file sequentially. The following commands serve as an example, you may need to customise it for the benchmarking platform.

```
$ conda activate $IOR_CONDA_ENV
$ ior -a POSIX -w -r -e -b <block_size> -o <path_to_target_filesystem>\ior_seq_test
```

Where ```<block_size>``` should be at least twice as large as the size of the memory of the compute node where the benchmark is executed and ``` <path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked.

### Concurrent Sequential Read/Write on a compute node

Run IOR tests concurrently to benchmark the performance of a filesystem on a compute node. The following is an example bash script for this test, although it may need to be customised for the benchmarking platform.

```
conda activate $IOR_CONDA_ENV
echo "Preparing testing data..."
ior -a POSIX -w -e -k -b <block_size> -o <path_to_target_filesystem>/ior_rw_test > ./ior_concurent.out
echo "Starging Concurrent Read..."
ior -a POSIX -r -b <block_size> -o <path_to_target_filesystem>/ior_rw_test > ./ior_concurent_r.out&
echo "Starting Concurrent Write..."
ior -a POSIX -w -e -b <block_size> -o <path_to_target_filesystem>/ior_rw_test2 > ./ior_concurent_w.out
echo "Done!"
```

Where ```<block_size>``` should be at least twice as large as the size of the memory of the compute node where the benchmark is executed and ``` <path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked.

### Sequential Write and Read via MPIIO

Run IOR as a MPI program to benchmark the write and read performance of a platform's filesystem.  The following commands serve as an example, you may need to customise it for the benchmarking platform.

```
$ conda activate $IOR_CONDA_ENV
$ mpirun -np <num_tasks> -N <num_tasks_per_node> ior -a MPIIO -w -r -N <num_tasks> -b <block_size> -o <path_to_target_filesystem>\ior_seq_test
```

Where ```<num_tasks>``` should be large enough to create sufficient load to test the aggregated bandwidth of the specified filesystem, ```<num_tasks_per_node>``` is number of tasks to run on a allocated node,  ```<block_size>``` times ```<num_tasks_per_node>``` should be twice as large as the size of the memory of the  compute node where the benchmark is executed, and ```<path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked.
