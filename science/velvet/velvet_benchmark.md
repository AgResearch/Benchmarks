# Name of the Benchmark

## Purpose

Velvet is a genome assembler that we use reasonably often. Velvetoptimizer is a wrapper script for velvet to find the optimal parameters. This script will generate several instances of the assembler at once, providing a decent benchmark of IO, CPU and memory performance.

## Installation

conda env create -f velvet.yml

### Sample data [optional]

$SAMPLE_DATA_ROOT/VELVET/*.fastq.gz

## Execution

gunzip *.fastq.gz
source activate VELVET
VelvetOptimiser.pl -s 131 -e 231 -f '-shortPaired -fastq -separate SRR5420176_1.fastq SRR5420176_2.fastq'

### Output verification [optional]

Optimal Velvet hash value should be 189, i.e. grep for the followingi n the output:

"Velvet hash value: 189"

