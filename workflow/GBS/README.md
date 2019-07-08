# GBS

Genotyping By Sequencing is a frequently used method in genomics today.  It is implemented as a pipeline in AgResearch based on TASSEL3 and KGD (open sourced code developed by AgResearch). 

## Purpose

Validate a platform's fit for purpose to support a major workflow used by scientists in AgResearch.

## Installation

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark. 

```
$ mkdir -p $GBS_CONDA_ENV
$ conda-env create -p $GBS_CONDA_ENV -f $GBS_CONDA_ENV_SPEC
$ conda activate $GBS_CONDA_ENV
```


## Execution

This workflow benchmark consists a serial of tasks, which are encapsulated by a single shell script, *run-gbs-benchmark*.  To execute this benchmark, first activate the Conda environment created for this benchmark and then execute.

```
$ conda activate $GBS_CONDA_ENV
$ $BENCHMARK_SOURCE/workflow/GBS/run-gbs-benchmark
```

### Output verification

Use the following command to extract the last 8 lines our tis benchmakr's output file

```
tail -n 16 $OUTPUT_DATA_ROOT_DIR/tassel3-kgd/hapMap/KGD_run_1/KGD_run_1.log 
```

If the benchmark ran successfully, the last 8 lines of above command should match the following:

```
# SNPs:  67927
# individuals:  95
Mean co-call rate (for sample pairs): 0.7850626
Min  co-call rate (for sample pairs): 0.6412325
Proportion of missing genotypes:  0.1445101 Callrate: 0.8554899
Mean sample depth: 5.905667
Mean self-relatedness (G5 diagonal): 1.072013
minimum eigenvalue:  1.774021e-34
```

