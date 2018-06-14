# Name of the Benchmark

## Purpose

Velvet is a genome assembler that we use reasonably often. Velvetoptimizer is a wrapper script for velvet to find the optimal parameters. This script will generate several instances of the assembler at once, providing a decent benchmark of IO, CPU and memory performance.

## Installation

Once the science datasets have been unpacked, and `../science-benchmarks.env`
has been updated appropriately:

```
$ conda env create -f velvet-conda-env.yml
```

## Execution

```
$ source activate velvet
$ . ../science-benchmarks.env
$ ./run-velvet-benchmark
```

### Output verification [optional]

Optimal Velvet hash value should be 189, i.e. grep for the followingi n the output:

"Velvet hash value: 189"

