# GBS

Genotyping By Sequencing is a frequently used method in genomics today.  It is implemented as a pipeline in AgResearch based on TASSEL3 and KGD (open sourced code developed by AgResearch). 

## Purpose

Validate a platform's fit for purpose to support a major workflow used by scientists in AgResearch.

## Installation

## Installation

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark. 

```
$ mkdir -p $GBS_CONDA_ENV
$ conda-env create -p $GBS_CONDA_ENV -f $GBS_CONDA_ENV_SPEC
$ source activate $GBS_CONDA_ENV
```


## Execution

This workflow benchmark consists a serial of tasks, which are encapsulated by a single shell script, *run-gbs-benchmark*.  To execute this benchmark, first activate the Conda environment created for this benchmark and then execute.

```
$ source activate $GBS_CONDA_ENV
$ $BENCHMARK_SOURCE/workflow/GBS/run-gbs-benchmark
```

### Output verification

**TBD**
