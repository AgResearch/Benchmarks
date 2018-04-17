# IOR

IOR is open source (GPLv2) file system benchmarking program.

## Purpose

It measures the sustainable bandwidth of a file system  using the various APIs, such as POSIX, MPI-IO and S3.

## Installation

Download the latest release (v3.1.0) from GitHub and unpack the file.

```
mkdir -p /tmp/benchmark/
cd /tmp/benchmark/
wget https://github.com/hpc/ior/archive/3.1.0.tar.gz
tar xzf 3.1.0.tar.gz
```

Create a Conda environment based on the provided environment file and then activate the environment before building and running the benchmark.  For example:

```
conda-env conda-env create -p /tmp/benchmark/ior-env -f <path>/ior-conda-env.yml
source activate /tmp/benchmark/ior-env
```

Use the following instructions to navigate into directory, ior-3.1.0, and to build it.

```
cd ior-3.1.0
./bootstrap
./configure
make
```

## Execution

### Sequential Write and Read on a compute node

Run IOR to benchmark the performance of a single process writing to a file and then reading such a file sequentially. The following commands serve as an example, you may need to customise it for the benchmarking platform. 

```
cd /tmp/benchmark/ior-3.1.0/src
source activate /tmp/benchmark/ior-env
./ior -a POSIX -w -r -e -b <block_size> -o <path_to_target_filesystem>\ior_seq_test
```

Where ```<block_size>``` should be at least twice as large as the size of the compute node where the benchmark is executed and ``` <path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked.

### Concurrent Sequential Read/Write on a compute node

Run IOR tests concurrently to benchmark the performance of a filesystem on a compute node. The following is an example bash script for this test, although it may need to be customised for the benchmarking platform.

```
echo "Preparing testing data..."
./ior -a POSIX -w -e -k -b <block_size> -o <path_to_target_filesystem>/ior_rw_test > ./ior_concurent.out
echo "Starging Concurrent Read..."
./ior -a POSIX -r -b <block_size> -o <path_to_target_filesystem>/ior_rw_test > ./ior_concurent_r.out&
echo "Starting Concurrent Write..."
./ior -a POSIX -w -e -b <block_size> -o <path_to_target_filesystem>/ior_rw_test2 > ./ior_concurent_w.out
echo "Done!"
```

Where ```<block_size>``` should be at least twice as large as the size of the compute node where the benchmark is executed and ``` <path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked.

### Sequential Write and Read via MPIIO

Run IOR as a MPI program to benchmark the write and read performance of a platform's filesystem.  The following commands serve as an example, you may need to customise it for the benchmarking platform.

```
cd /tmp/benchmark/ior-3.1.0/src
source activate /tmp/benchmark/ior-env
mpirun -np <num_tasks> ior -a MPIIO -w -r -N <num_tasks> -b <block_size> -o <path_to_target_filesystem>\ior_seq_test
```

Where ```<num_tasks>``` should be large to create sufficient load to test the aggregated bandwidth of the specified filesystem, ```<block_size>``` times the number of tasks allocated to a single compute node should be twice as large as the size of the compute node where the benchmark is executed, and ```<path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked.
