#!/bin/sh
cd hapMap
rm -rf KGD_run_1
mkdir KGD_run_1
cd KGD_run_1
Rscript ../run_KGD_1.R &> KGD_run_1.log
