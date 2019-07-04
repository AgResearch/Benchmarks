# AgResearch Scientific Compute Platform Benchmark Suite

This repository includes benchmarks that will be used to ensure the fit for purpose and to measure the performance of the Scientific Compute Platform in AgResearch.  Benchmarks are classified into three categories:

* Science Workflow - based on science workflows that are frequently run or are expected to run on the platform.  It benchmarks the platform's capability and also capacity on support strategically important workflows.  A workflow is a series of runs of science applications;

* Storage Performance - benchmarks to measure performance of the platform in an theoretical way.

Each individual benchmark has its own README file which describes the purpose of the benchmark, how to run the benchmark and how to verify its output(s).

This benchmark suite uses binary distributions in the [Conda](https://conda.io) repositories to deploy benchmark programs.  In such a case, there shall be a Conda environment specification file included in the benchmark's subdirectory.  Please follow its README file to deploy the benchmark program.  Some benchmark program will required to be built from the source.  Please use the Conda environment specification file included in the benchmark to crate a Conda environment for building and running such a benchmark program.  This approach ensures a stable, although not necessary optimal, building and executing environment for benchmarking.  If the target platform does not have Conda installed, follow instruction [here](https://conda.io/miniconda.html) to install it on the platform.

## Environment Variables

Please update environment *BENCHMARK_ROOT* variable in file ```benchmark.env``` included in this repository based on target platform's local environment.  This file must be sourced before deploying and running this benchmark suite.  

```
$ source benchmark.env
```

## Getting and Preparing Input Data

To obtain all input data required to execute this benchmark, please [email](dan.sun@agresearch.co.nz) a Linux system administrator in AgResearch Ltd and ask for access to the [Globus share](https://app.globus.org/file-manager?origin_id=8d37b9ec-9ea1-11e9-a378-0a2653bc2660&origin_path=%2F) to download the input data via using Globus.

The input data is packaged in a tarball.  Please place the download tarball in the root directory of the benchmark suite and then use the following command to extract data from the tarball:

```
$ cd $BENCHMARK_ROOT
$ tar xzf benchmark_input_data.taz
```
