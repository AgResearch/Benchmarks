# ABySS

ABySS is a de novo, parallel, paired-end sequence assembler.

## Purpose
TBD

## Installation

Create a Conda environment based on the provided environment specification file and then activate the environment before building and running the benchmark. 

```
$ mkdir -p $ABYSS_CONDA_ENV
$ conda-env create -p $ABYSS_CONDA_ENV -f $ABYSS_CONDA_ENV_SPEC
$ conda activate $ABYSS_CONDA_ENV
```

## Execution

Activate the Conda environment created for this benchmark then run the shell script, *run-abyss-benchmark*, to launch the benchmark.

```
$ conda activate $ABYSS_CONDA_ENV
$ $BENCHMARK_SOURCE/science/abyss/run-abyss-benchmark <num_of_processes> <num_of_threads>
```

Where ```<num_of_processes>``` is mandatory and should match the number of physical CPU cores allocated to the run.  If these cores are distributed across multiple compute node, please ensure a nodelist is correctly configured for OpenMPI.  ```<num_of_threads>``` is an optional argument.  It should match the number of physical CPU cores or hyperthreads availabel on a single compute node.  If it not provided, it defaults to the same value of ```<num_of_processes>```.

### Output verification

The following assembly files should be created in ```$OUTPUT_DATA_ROOT_DIR\abyss\```

* abyss2_k84_trans-unitigs.fa
* abyss2_k84_trans-contigs.fa
* abyss2_k84_trans-scaffolds.fa
* abyss2_k84_trans-long-scaffs.fa
* abyss2_k84_trans-[1-10].fa

The stats of the assembly run should be available in ```$OUTPUT_DATA_ROOT_DIR\abyss\abyss2_k84_trans-stats```.  Its content should be similar, but not identical, to the following:

```
n	    n:500	L50	    min N80     N50	    N20	    E-size	max	    sum	    name
3797934	482787	81126	500	932	    2404	6184	4127	76330	794.1e6	abyss2_k84_trans-unitigs.fa
3397250	358309	45725	500	1717	4817	11535	7600	98741	856.2e6	abyss2_k84_trans-contigs.fa
3396437	357496	45290	500	1719	4834	11732	7648	98741	856.2e6	abyss2_k84_trans-scaffolds.fa
3333577	302639	23551	500	2073	9115	22653	13559	119325	853.5e6	abyss2_k84_trans-long-scaffs.fa
```
