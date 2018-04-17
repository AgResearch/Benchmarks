# AgResearch Scientific Compute Platform Benchmark Suite

This repository includes benchmarks that will be used to ensure the fit for purpose and to measure the performance of the Scientific Compute Platform in AgResearch.  Benchmarks are classified into three categories:

* Science - based on science applications that are frequently run or are expected to run on the platform.  It benchmarks the platform's capability on supporting strategically important applications;

* Workflow - based on science workflows that are frequently run or are expected to run on the platform.  It benchmarks the platform's capability and also capacity on support strategically important workflows.  A workflow is a series of runs of science applications;

* Platform - well known HPC platform benchmarks which measure performance of the platform in an theoretical way.

Each individual benchmark has its own README file which describes the purpose of the benchmark, how to run the benchmark and how to verify its output(s).

If a benchmark needs to be built from the source, it should be build and execute in a [Conda](https://conda.io) environment created by using the Conda environment specified in the benchmark's documentation.  This approach ensures a stable, although not necessary optimal, building and executing environment.  If the target platform does not have Conda installed, follow instruction [here](https://conda.io/miniconda.html) to install it on the platform.
