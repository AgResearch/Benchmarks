# blast / bwa

Using Blast and bwa are sequence aligners in a high throughput workload.

## Purpose
Benchmark the platform's performance, particularly its capacity to support a high throughput workflow which is frequently executed in AgResearch.

## Setup
The benchmark script `run-blast-bwa-benchmark` is created offline at AgResearch by running the script `setup-blast-bwa-benchmark`.

## Installation

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark.

```
$ mkdir -p $BLAST_BWA_CONDA_ENV
$ conda-env create -p $BLAST_BWA_CONDA_ENV -f $BLAST_BWA_CONDA_ENV_SPEC
$ conda activate $BLAST_BWA_CONDA_ENV
```

## Execution

Activate the Conda environment created for this benchmark then run the shell script, *run-blast-bwa-benchmark*, to launch the benchmark.

```
$ conda activate $BLAST_BWA_CONDA_ENV
$ $BENCHMARK_SOURCE/science/blast-bwa/run-blast-bwa-benchmark
```

### Output verification

**TBD**
