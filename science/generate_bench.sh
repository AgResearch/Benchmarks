#!/bin/sh
################################################################################
# PLEASE NOTE THIS WAS/IS JUST AN INITIAL MINIMAL IMPLEMENTATION TO ILLUSTRATE 
# THE GENERATE-RUN-EXPORT APPROACH (have indicated todos below - search for TODO ) 
# (there are probably some todo's I've overlooked)
################################################################################
#
# this script was intended to generate , run and export benchmark scripts and data files
# The "generate" and "run" steps re-use seq_prisms code. ("generate" simply uses 
# the dry-run seq_prisms option )
# 
# "export" , means that the generated scripts and data chunks are edited and 
# renamed for portability and archived into a tarball, along with an installation 
# README coped from this source tree  ( - the tarball can then 
# be sent to a hardware vendor for benchmarking). As part of the export step, 
# for example hard-coded paths are converted to bash variable references, so that 
# actual paths to data can be set by the end-user via environment variables
#
# (Note it is not intended that this script itself be exported in any way or sent
#  to vendors)
# 
#


export SEQ_PRISMS_BIN=/dataset/invermay_hpc_benchmarking/active/afm/benchmarks/science/seq_prisms
BENCHMARK_INPUT_DATA_FOLDER=/dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/data
# TODO - compile some test data , copy to /dataset/somewhere/archive, and point BENCHMARK_INPUT_DATA_FOLDER at that 
# (for the very early version used some recent data I am familiar with but this is not suitable 
# for the production release )

function get_opts() {
   DEBUG=no
   HPC_TYPE=slurm
   OUT_DIR=""
   help_text="
\n
./benchmarks.sh  [-h] [-n] [-d] [-x generate|run|export ] -O outdir [-C local|slurm ]\n
\n
\n
example:\n
./benchmarks.sh -x generate -O /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science
./benchmarks.sh -x export -O /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science
\n
"

   # defaults:
   while getopts ":nhO:C:x:" opt; do
   case $opt in
       n)
         DRY_RUN=yes
         ;;
       d)
         DEBUG=yes
         ;;
       h)
         echo -e $help_text
         exit 0
         ;;
       O)
         OUT_DIR=$OPTARG
         ;;
       x)
         TASK=$OPTARG
         ;;
       \?)
         echo "Invalid option: -$OPTARG" >&2
         exit 1
         ;;
       :)
         echo "Option -$OPTARG requires an argument." >&2
         exit 1
         ;;
     esac
   done
}


function get_prisms() {
   # this script re-uses some existing code. Note that seq_prisms itself
   # is quite early work-in-progress ! 
   git clone git@github.com:AgResearch/seq_prisms.git
}

function check_opts() {
   if [ ! -d $OUT_DIR ]; then
      echo "OUT_DIR $OUT_DIR not found"
      exit 1
   fi

   if [[ $TASK != "generate" && $TASK != "run" && $TASK != "export" ]]; then
      echo "TASK must be one of generate, run, export"
      exit 1
   fi

   # TODO - add some additional checks 

}

function echo_opts() {
  echo OUT_DIR=$OUT_DIR
  echo DEBUG=$DEBUG
  echo TASK=$TASK
}


#
# edit this method to set required environment (or set up
# before running this script)
#
function configure_env() {
   # set up scripts etc.
   cd ../$SEQ_PRISMS_BIN
   get_prisms
   cp ./generate_bench.sh $OUT_DIR # (seq_prisms and this script use an approach of copying scripts etc. into the 
                                   # output folder  - this improves the reproducbility and debuggability of 
                                   # the run)
   echo "
[tardish]
[tardis_engine]
" > $OUT_DIR/.tardishrc

   # set up data source (if need be)
   # TODO - this block is only here in the very early version of this script, until we 
   # put together a static set of test data - this will be warehouse under the active or 
   # archive tiers of an appropriate dataset , and BENCHMARK_INPUT_DATA_FOLDER will point 
   # there. This next if-fi block will then be deleted  
   if [ $TASK != "export" ]; then 
      #### this dataset just for initial testing
      mkdir -p $BENCHMARK_INPUT_DATA_FOLDER
      cd $BENCHMARK_INPUT_DATA_FOLDER
      cp -s /dataset/GBS_T*/ztmp/test/seq_prisms/fastq_samples/SQ*/*.fastq.gz .   # i.e. just a link farm currently 
   fi
}


function check_env() {
   if [ -z "$SEQ_PRISMS_BIN" ]; then
      echo "SEQ_PRISMS_BIN not set - exiting"
      exit 1
   fi

   # TODO - add additional checks
}


function generate_bench() {
   # this is done by doing a dry run of a number of prisms
   #
   # generate a blast test bench 
   cd $SEQ_PRISMS_BIN/..
   mkdir -p $OUT_DIR/alignments
   seq_prisms/align_prism.sh -n -m 30 -a blastn -r nt -p "-e 1.0e-6"  -O $OUT_DIR/alignments  $BENCHMARK_INPUT_DATA_FOLDER/*.fastq.gz
   #
   # TODO add generation of a bwa (and maybe other ) test bench - this will look similar 
}


function run_bench() {
   # this is essentially identical to "generate_bench", but without the -n dry-run option 
   #
   # generate a blast test bench
   cd $SEQ_PRISMS_BIN/..
   mkdir -p $OUT_DIR/alignments
   time seq_prisms/align_prism.sh -n -m 30 -a blastn -r nt -p "-e 1.0e-6"  -O $OUT_DIR/alignments  $BENCHMARK_INPUT_DATA_FOLDER/*.fastq.gz
   #
   # TODO - here I am blasting against the "nt" database - thats a good test, but would require vendor to download
   #   a heap of blast index files from ncbi which would really annoy them I think. I think will 
   #   need to supply a blast database in or tarball - probably a genome
   # TODO add generation of a bwa (and maybe other ) test bench - this will look similar
   # TODO  - probably will need to add some capture/logging  of the timing information obtained 
}


function export_bench() {
   # tar up the data files
   # TODO - add tar-ing up of data files and writing of this to 
   #
   # copy README instructions from the source tree to the output folder so included in tarball
   # TODO - add that 
   # 
   # edit the blast scripts. After the generate step, these will look like : 
##!/bin/bash
#source /dataset/bioinformatics_dev/scratch/tardis/bin/activate
#tardis -hpctype slurm -d  /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments   blastn -db nt -query  _condition_fasta_input_/dataset/GBS_Tcirc/ztmp/test/seq_prisms/fastq_samples/SQ0499_CB6K1ANXX_s_6_fastq/B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz -e 1.0e-6 \> _condition_text_output_/dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments/B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz.blastn.nt.1.0e6.results
   # and will be edited to look like
##!/bin/bash
#source $BENCHMARK_ENVIRONMENT_SOURCE
#time blastn -db nt -query  $BENCHMARK_DATA_FOLDER/SQ0499_CB6K1ANXX_s_6_fastq/B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz -e 1.0e-6 1>B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz.blastn.nt.1.0e6.stdout 2>B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz.blastn.nt.1.0e6.stderr
   # 
   # this edit is done by a python script which takes the following args : 
   # old_environment_source= sys.argv[1]
   # old_data_source = sys.argv[2]
   # old_prefix = sys.argv[3]
   # old_output_folder = sys.argv[4]
   # script_basename =  sys.argv[5]
   # example : 
   #   cat $blast_script | ./export_script.py  /dataset/bioinformatics_dev/scratch/tardis/bin/activate  $BENCHMARK_INPUT_DATA_FOLDER "tardis -hpctype slurm -d  /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments" $OUT_DIR $base > $OUT_DIR/alignments/export/$base

   mkdir -p $OUT_DIR/alignments/export
   for blast_script in $OUT_DIR/alignments/*.blastn.*.sh; do
      base=`basename $blast_script`
      cat $blast_script | ./export_script.py  /dataset/bioinformatics_dev/scratch/tardis/bin/activate  $BENCHMARK_INPUT_DATA_FOLDER "tardis -hpctype slurm -d  /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments" $OUT_DIR $base > $OUT_DIR/alignments/export/$base
      # TODO  - that last will need updating as /dataset/bioinformatics_dev/scratch/tardis/bin/activate is deprecated 
      # TODO  - that last line was an initial test - e.g. replace /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments with $OUT_DIR/alignments 
   done
   # TODO - will need to add edits of additional benchmarks we add such as bwa
}


function main() {
   get_opts "$@"
   check_opts
   echo_opts
   check_env
   configure_env
   if [ $TASK == "generate" ]; then
      generate_bench
   elif [ $TASK == "run" ]; then
      run_bench
   elif [ $TASK == "export" ]; then
      export_bench
   else 
      echo "error unsupported task $TASK"
      exit 1
   fi
}


set -x
main "$@"
set +x
