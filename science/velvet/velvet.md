# Name of the Benchmark

Velvet is a genome assembler that we use reasonably often. Velvetoptimizer is a wrapper script for velvet to find the optimal parameters. This script will generate several instances of the assembler at once,

## Purpose

Benchmark a platform's IO, CPU and memory performance via a regularly used genome assembler.

## Installation

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark. 

```
$ mkdir -p $VELVET_CONDA_ENV
$ conda-env create -p $VELVET_CONDA_ENV -f $VELVET_CONDA_ENV_SPEC
$ source activate $VELVET_CONDA_ENV
```

## Execution

Activate the Conda environment created for this benchmark then run the shell script, *run-velvet-benchmark*, to launch the benchmark.

```
$ source activate $VELVET_CONDA_ENV
$ BENCHMARK_SOURCE/science/velvet/run-velvet-benchmark
```

### Output verification [optional]

Optimal Velvet hash value should be 189, i.e. grep for the following in the output:

"Velvet hash value: 189"
