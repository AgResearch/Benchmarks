#!/bin/sh
# needs to run in conda environment abyss

test -n "$SCIENCE_DATA_ROOTDIR" || {
    echo >&2 "fatal error: missing environment variable SCIENCE_DATA_ROOTDIR - source the top-level environment file"
    exit 1
}
test -n "$SCIENCE_OUTPUT_ROOTDIR" || {
    echo >&2 "fatal error: missing environment variable SCIENCE_OUTPUT_ROOTDIR - source the top-level environment file"
    exit 1
}

test -n "$NCORES" -a "$NCORES" -ge 1 -a "$NCORES" -le 100 || {
    echo >&2 "fatal error: missing or implausible value for NCORES"
    exit 1
}

datadir=$SCIENCE_DATA_ROOTDIR/abyss
outdir=$SCIENCE_OUTPUT_ROOTDIR/abyss
test -d "$datadir" || {
    echo >&2 "fatal error: missing data directory $datadir - unpack the data tarball"
    exit 1
}

cd $datadir
test -d "$outdir" || mkdir -p "$outdir" || {
    echo >&2 "fatal error: failed to create output directory $outdir"
    exit 1
}

type abyss-pe >/dev/null 2>&1 || {
    echo >&2 "fatal error: abyss-pe not found - did you create and activate the abyss conda environment?"
    exit 1
}

abyss-pe np=$NCORES k=84 name=abyss2_k84_trans q=20 lib='pe200a pe200b pe500a pe500b' mp='mp5kb mp8kb' long='longa longb longc longd' \
pe200a='L6_V2.notCombined_1.fastq.clipped L6_V2.notCombined_2.fastq.clipped' \
pe200b='L7_200_V2.notCombined_1.fastq.clipped L7_200_V2.notCombined_2.fastq.clipped' \
pe500a='L7_500.notCombined_1.fastq.clipped L7_500.notCombined_2.fastq.clipped' \
pe500b='L8.notCombined_1.fastq.clipped L8.notCombined_2.fastq.clipped' \
se='L6_V2.extendedFrags.fastq.clipped L7_200_V2.extendedFrags.fastq.clipped L7_500.extendedFrags.fastq.clipped L8.extendedFrags.fastq.clipped' \
longa='Sample1_LongRead_manual_trim.fastq' \
longb='Sample2_LongRead.fastq' \
longc='Sample3_LongRead.fastq' \
longd='Trinity.fasta' \
mp5kb='GSM02-3Kb_S1_L001_R1_001.fastq GSM02-3Kb_S1_L001_R2_001.fastq' \
mp8kb='GSM02-8Kb_S1_L001_R1_001.fastq GSM02-8Kb_S1_L001_R2_001.fastq' \
mpirun="mpirun --oversubscribe"
>$outdir/abyss2_k84_trans.out 2>$outdir/abyss2_k84_trans.err