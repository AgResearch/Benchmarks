# ABySS

## Purpose

ABySS is a de novo, parallel, paired-end sequence assembler.

## Installation

Once the science datasets have been unpacked, and `../science-benchmarks.env`
has been updated appropriately:

```
$ conda env create -f abyss-conda-env.yml
```

### Sample data [optional]

$SAMPLE_DATA_ROOT/VELVET/*.fastq.gz

## Execution

```
$ source activate abyss
$ . ../science-benchmarks.env
```

And then either directly:
```
$ ./run_abyss.sh
```

or via job submission:
```
$ sbatch -p $SLURM_PARTITION ./run_abyss.sh
```

### Output verification

**TBD**