# ABySS

ABySS is a de novo, parallel, paired-end sequence assembler.

## Purpose
TBD

## Installation

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark. 

```
$ mkdir -p $ABYSS_CONDA_ENV
$ conda-env create -p $ABYSS_CONDA_ENV -f $ABYSS_CONDA_ENV_SPEC
$ conda activate $ABYSS_CONDA_ENV
```

## Execution

Activate the Conda environment created for this benchmark then run the shell script, *run-abyss-benchmark*, to launch the benchmark.

```
$ conda activate $ABYSS_CONDA_ENV
$ $BENCHMARK_SOURCE/science/abyss/run-abyss-benchmark <num_of_processes> <num_of_threads>
```

Where ```<num_of_processes>``` is mandatory and should match the number of physical CPU cores allocated to the run.  If these cores are distributed across multiple compute node, please ensure a nodelist is correctly configured for OpenMPI.  ```<num_of_threads>``` is an optional argument.  It should match the number of physical CPU cores or hyperthreads availabel on a single compute node.  If it not provided, it defaults to the same value of ```<num_of_processes>```.

### Output verification

**TBD**
