#!/bin/sh
run_pipeline.pl -Xms512m -Xmx500g -fork1 -UTagCountToTagPairPlugin -w ./ -e 0.03 -endPlugin -runfork1

#Usage is as follows:
# -e  Error tolerance rate in the network filter. (Default: 0.03)
##The -e option, which is the Error tolerance rate (ETR), is an important argument. Higher ETR generates more
##SNPs (Especially those of high coverage SNPS), also more false SNP calls. When ETR equals to 0, it means only
##purely reciprocal tags are called and no sequencing error happened to these tags. This is the most stringent
##criteria, but unrealistic, which would largely reduced the number of SNPs, especially when the coverage is high.
##The default of ETR is 0.03. Based on the observation on Illumina sequencing error rate, the ETR should not be
##greater than 0.05.
##
##RB: We went with 0.03 which served us well
# -i  Input file of merged tag counts
# -o  Output file of tag pairs
# -w  Working directory to contain subdirectories
#(note: must supply EITHER the working directory OR both the input and output files

