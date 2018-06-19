#!/bin/sh
run_pipeline.pl -Xms512m -Xmx500g -fork1 -UMergeTaxaTagCountPlugin -w ./ -t n -m 600000000 -x 100000000 -c 3 -endPlugin -runfork1

#Usage is as follows:
# -w  Working directory to contain subdirectories
# -t  Option to merge taxa (y/n). Default: y
##RB: We've decided to never merge taxa at this level. We run samples through without merging, check via KGD if merging is okay, then merge allele counts.
# -m  Maximum tag number in the merged TagCount file. Default: 60000000
##RB: I've increased this from 60M to 600M
##    We've seen 46.5M (Salmon), e.g. /mergedTagCounts/mergedAll.cnt
# -x  Maximum tag number in TagCount file for each taxa. Default: 10000000
##RB: I've increased this from 10M to 100M
##    Individual files (unmerged) go up to 1M, e.g. /tagCounts/2342_F12_C6K0YANXX_1_105_X4.cnt
##    Merged files (e.g. positive controls) can go up to 3.1M (Salmon), e.g. /tagCounts/932592_merged_X3.cnt
# -c  Minimum count of a tag must be present to be output. Default: 5
##RB: As I understand it this is the overall count (all individuals) for a given tag
##    We've set this at 30 (previously 3).
##    This value depends on the number of samples, MAF, sequence depth.
##    For 3.5k samples we have 7k alleles. We are interested in SNPs down to a MAF of 0.03. That would be 7000*0.03 = 210.
