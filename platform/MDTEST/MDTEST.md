# MDTEST

MDTEST is open source (GPLv2) file system benchmarking program and is now part of IOR.

## Purpose

It measures the performance of a file system when performing metadata operations.

## Installation

Refer to [IOR's](../IOR/IOR.md) instructions

## Execution

Benchmark the performance of a specified filesystem by creating 1,048,576 (1024x1024) files and directories, and then removing them.

### Single Compute Node

The following example will launch a test on a single compute node to create and remove required files and directories and then remove them.

```
cd /tmp/benchmark/ior/bin
source activate /tmp/benchmark/ior-env
./mdtest -F -C -T -r -n 1048576 -d <path_to_target_filesystem>
```

Where, ``` <path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked.

### Multiple Compute Nodes

The following example will launch a test on group of nodes to create and remove required files and directories and then remove them.

```
cd /tmp/benchmark/ior/bin
source activate /tmp/benchmark/ior-env
mpirun -np <num_tasks> -N <num_tasks_per_node> ./mdtest -F -C -T -r -n <1048576/<num_tasks>> -d <path_to_target_filesystem> -N <num_tasks_per_node>
```

Where ```<num_tasks>``` should be sufficiently large to create sufficient load to stress metadata operations of the specified filesystem, ```<num_tasks_per_node>``` is number of tasks to run on a allocated node, and ```<path_to_target_filesystem>``` is the path to the target filesystem that is been benchmarked.
