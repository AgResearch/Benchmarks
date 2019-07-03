# blast / bwa

Using Blast and bwa are sequence aligners in a high throughput workload.

## Purpose
Benchmark the platform's performance, particularly its capacity to support a high throughput workflow which is frequently executed in AgResearch.

## Installation

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark.

```
$ mkdir -p $BWA_BLAST_CONDA_ENV
$ conda-env create -p $BWA_BLAST_CONDA_ENV -f $BWA_BLAST_CONDA_ENV_SPEC
$ conda activate $BWA_BLAST_CONDA_ENV
```

## Execution

Activate the Conda environment created for this benchmark then run the shell script, *run-blast-bwa-benchmark*, to launch the benchmark.

```
$ conda activate BWA_BLAST_CONDA_ENV
$ $BENCHMARK_SOURCE/science/blast-bwa/run-bwa-blast-benchmark
```

### Output verification

**TBD**

 
