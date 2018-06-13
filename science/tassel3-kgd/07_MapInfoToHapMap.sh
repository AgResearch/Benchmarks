#!/bin/sh
run_pipeline.pl -Xms512m -Xmx500g -fork1 -UMapInfoToHapMapPlugin -w ./ -mnMAF 0.03 -mxMAF 0.5 -mnC 0.1 -mxC 1 -endPlugin -runfork1

#Usage is as follows:
# -w      Working directory to contain subdirectories
# -mnMAF  Mimimum minor allele frequency. Default: 0.05
##RB: We've set this at 0.03
# -mxMAF  Maximum minor allele frequency. Default: 0.5
##RB: We've left that at the default
# -mnC    Minimum call rate
##RB: For a tag pair to get accepted at least one tag needs to be seen in at least 'minimum call rate' of all samples.
##    That's the same as saying that the SNP position in question needs to be interogated by at least 'minimum call rate' of all samples.
##    We've set this at 0.1 (10%).
##    A tag has to be seen in at least 10% of all samples in a population to be accepted.
# -mxC    Maximum call rate. Default: 1
##RB: We've left that at the default
