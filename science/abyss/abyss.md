# ABySS

ABySS is a de novo, parallel, paired-end sequence assembler.

## Purpose
TBD

## Installation

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark. 

```
$ mkdir -p $ABYSS_CONDA_ENV
$ conda-env create -p $ABYSS_CONDA_ENV -f $ABYSS_CONDA_ENV_SPEC
$ source activate $ABYSS_CONDA_ENV
```

## Execution

Activate the Conda environment created for this benchmark then run the shell script, *run-abyss-benchmark*, to launch the benchmark.

```
$ source activate abyss
$ $BENCHMARK_SOURCE/science/abyss/run-abyss-benchmark
```

### Output verification

**TBD**
