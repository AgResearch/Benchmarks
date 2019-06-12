# AgResearch Scientific Compute Platform Benchmark Suite

This repository includes benchmarks that will be used to ensure the fit for purpose and to measure the performance of the Scientific Compute Platform in AgResearch.  Benchmarks are classified into three categories:

* Workflow - based on science workflows that are frequently run or are expected to run on the platform.  It benchmarks the platform's capability and also capacity on support strategically important workflows.  A workflow is a series of runs of science applications;

* Platform - well known HPC platform benchmarks which measure performance of the platform in an theoretical way.

Each individual benchmark has its own README file which describes the purpose of the benchmark, how to run the benchmark and how to verify its output(s).

This benchmark suite uses binary distributions in the [Conda](https://conda.io) repositories to deploy benchmark programs.  In such a case, there shall be a Conda environment specification file included in the benchmark's subdirectory.  Please follow its README file to deploy the benchmark program.  Some benchmark program will required to be built from the source.  Please use the Conda environment specification file included in the benchmark to crate a Conda environment for building and running such a benchmark program.  This approach ensures a stable, although not necessary optimal, building and executing environment for benchmarking.  If the target platform does not have Conda installed, follow instruction [here](https://conda.io/miniconda.html) to install it on the platform.

## Environment Variables

Please update environment *BENCHMARK_ROOT* variable in file ```benchmark.env``` included in this repository based on target platform's local environment.  This file must be sourced before deploying and running this benchmark suite.  

```
$ source benchmark.env
```

## Getting and Preparing Input Data

All input data required to execute this benchmark suite can be downloaded from [here](https://url/to/be/confirmed).  Please download it and save it in the same root directory as the benchmark suite and then use the following command to extract data from the tarball:

```
$ cd $BENCHMARK_ROOT
$ wget https://url/to/be/confirmed
$ tar xzf benchmark_input_data.taz
```
