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
$ $BENCHMARK_SOURCE/science/velvet/run-velvet-benchmark <available_memory> > $OUTPUT_DATA_ROOT_DIR/velvet/benchmark_run.out
```

where ```<available_memory>``` should be the total available memory to support this run and its unit is GB.

### Output verification [optional]

Optimal Velvet hash value should be 189 and it is indicated in the *final optimised assembly details* section of the standard out.  For a qucik validation, run the following command against the captured standard output.

```
$ grep "Velvet hash value: 189" $OUTPUT_DATA_ROOT_DIR/velvet/benchmark_run.out
```
