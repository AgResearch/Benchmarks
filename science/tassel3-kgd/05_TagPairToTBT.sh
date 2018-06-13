#!/bin/sh
run_pipeline.pl -Xms512m -Xmx500g -fork1 -UTagPairToTBTPlugin -w ./ -endPlugin -runfork1

#Usage is as follows:
# -w  Working directory to contain subdirectories
