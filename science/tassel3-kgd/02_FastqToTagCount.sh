#!/bin/sh
run_pipeline.pl -Xms512m -Xmx300g -fork1 -UFastqToTagCountPlugin -w ./ -c 1 -e PstI -s 400000000 -endPlugin -runfork1

#Usage is as follows:
# -w  Working directory to contain subdirectories
# -e  Enzyme used to create the GBS library
# -s  Maximum number of good, barcoded reads per lane. Default: 200,000,000
##RB: I set this to 400M as we see up to 33.3 Gbp, that's 333,000,000 reads
# -c  Minimum number of tags seen to output to file, Default: 1
