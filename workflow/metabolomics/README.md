# Metabolomics Workflow

This is a workflow commonly by researchers in AgResearch to analyse data generated by the mass spectrometer

## Purpose

Validate a platform's fit for purpose to support a major workflow used by scientists in AgResearch.

## Installation

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark. 

```
$ mkdir -p $METABOLOMICS_CONDA_ENV=
$ conda-env create -p $METABOLOMICS_CONDA_ENV= -f $METABOLOMICS_CONDA_ENV=_SPEC
$ source activate $METABOLOMICS_CONDA_ENV
```


## Execution

This workflow benchmark consists a serial of tasks, which are encapsulated by a single shell script, *run-metabolomics-benchmark*.  To execute this benchmark, first activate the Conda environment created for this benchmark and then execute.

```
$ source activate $METABOLOMICS_CONDA_ENV
$ $BENCHMARK_SOURCE/workflow/metabolomics/run-metabolomics-benchmark
```

### Output verification

There shall be ~1038 lines in *$OUTPUT_DATA_ROOT_DIR/metabolomics/d2.csv*

```
$ wc -l $OUTPUT_DATA_ROOT_DIR/metabolomics/d2.csv
```

Additionally, the average of the **rt** filed in the same csv file should be within the range of 550.0 +/- 5

```
$ sed -e '1d' $OUTPUT_DATA_ROOT_DIR/metabolomics/d2.csv | awk -F',' '{sum+=$4} END {print sum/NR}'
```