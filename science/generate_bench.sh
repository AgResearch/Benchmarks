#!/bin/sh
#
# this script is used to generate , run and export benchmark scripts and data files
# The "generate" and "run" steps re-use seq_prisms code. ("generate" simply uses 
# the dry-run seq_prisms option )
# 
# "export" , means that the generated scripts and data chunks are edited and 
# renamed for portability and archived into a tarball (which may for example 
# be sent to a hardware vendor for benchmarking). (As part of the export step, 
# for example hard-coded paths are converted to bash variable references, so that 
# actual paths to data can be set by the end-user via environment variables)
#
# (Note it is not intended that this script itself be exported in any way)
# 
#

export SEQ_PRISMS_BIN=/dataset/invermay_hpc_benchmarking/active/afm/benchmarks/science/seq_prisms
BENCHMARK_INPUT_DATA_FOLDER=/dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/data

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

}

function echo_opts() {
  echo OUT_DIR=$OUT_DIR
  echo DEBUG=$DEBUG
  echo TASK=$TASK
  echo MINIMUM_SAMPLE_SIZE=$MINIMUM_SAMPLE_SIZE
}


#
# edit this method to set required environment (or set up
# before running this script)
#
function configure_env() {
   # set up scripts etc.
   cd ../$SEQ_PRISMS_BIN
   get_prisms
   cp ./benchmarks.sh $OUT_DIR
   echo "
[tardish]
[tardis_engine]
" > $OUT_DIR/.tardishrc

   # set up data source (if need be)
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
}


function generate_bench() {
   # this is done by doing a dry run of a number of prisms
   #
   # generate a blast test bench 
   # (note this is not the final dataset we will use)
   cd $SEQ_PRISMS_BIN/..
   mkdir -p $OUT_DIR/alignments
   seq_prisms/align_prism.sh -n -m 30 -a blastn -r nt -p "-e 1.0e-6"  -O $OUT_DIR/alignments  $BENCHMARK_INPUT_DATA_FOLDER/*.fastq.gz
}


function run_bench() {
   # this contains essentially the same commands as "generate_bench", but without the dry-run option being set
   cd $OUT_DIR
   echo "tba"
   #
}


function export_bench() {
   # tar up the data files
   # [ to complete ]
   # 
   # edit the blast scripts. After the generate step, these will look like : 
##!/bin/bash
#source /dataset/bioinformatics_dev/scratch/tardis/bin/activate
#tardis -hpctype slurm -d  /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments   blastn -db nt -query  _condition_fasta_input_/dataset/GBS_Tcirc/ztmp/test/seq_prisms/fastq_samples/SQ0499_CB6K1ANXX_s_6_fastq/B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz -e 1.0e-6 \> _condition_text_output_/dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments/B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz.blastn.nt.1.0e6.results
   # and will be edited to look like
##!/bin/bash
#source $BENCHMARK_ENVIRONMENT_SOURCE
#time blastn -db nt -query  $BENCHMARK_DATA_FOLDER/SQ0499_CB6K1ANXX_s_6_fastq/B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz -e 1.0e-6 1>B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz.blastn.nt.1.0e6.stdout 2>B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz.blastn.nt.1.0e6.stderr
   # old_environment_source= sys.argv[1]
old_data_source = sys.argv[2]
old_prefix = sys.argv[3]
old_output_folder = sys.argv[4]
script_basename =  sys.argv[5]


   mkdir -p $OUT_DIR/alignments/export
   for blast_script in $OUT_DIR/alignments/*.blastn.*.sh; do
      base=`basename $blast_script`
      cat $blast_script | ./export_script.py  /dataset/bioinformatics_dev/scratch/tardis/bin/activate  $BENCHMARK_INPUT_DATA_FOLDER "tardis -hpctype slurm -d  /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments" $OUT_DIR $base > $OUT_DIR/alignments/export/$base
   done
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


##################### BELOW HERE IS JUNK - WILL BE DELETED SOON (source code for copy-and-paste) #################





#

function run_fastq_sample_prism() {
   set -x
   mkdir $OUT_DIR/fastq_samples
   for demulti in /dataset/GBS_Tcirc/active/test/*_demulti /dataset/GBS_Tcirc/scratch/SQ0054_C4UAUACXX_s_8_fastq.txt.gz_demulti; do
      base=`basename $demulti .txt.gz_demulti`
      mkdir -p $OUT_DIR/fastq_samples/$base
      seq_prisms/sample_prism.sh -s .001 -M 100000 -a fastq -O $OUT_DIR/fastq_samples/$base $demulti/*.fastq.gz
   done
   set +x
}


function make_link_farm() {
   mkdir  $OUT_DIR/link_farm
   for lane_sample  in SQ0499_CB6K1ANXX_s_5_fastq  SQ0499_CB6K1ANXX_s_6_fastq  SQ0500_CB6K1ANXX_s_7_fastq  SQ0500_CB6K1ANXX_s_8_fastq SQ0054_C4UAUACXX_s_8_fastq; do 
      lane_moniker=`echo $lane_sample | awk -F_ '{printf("%s_%s",$1,$4)}' - `
      for sample in $OUT_DIR/fastq_samples/$lane_sample/*.fastq.gz; do
         base=`basename $sample`
         cp -s $sample $OUT_DIR/link_farm/${lane_moniker}_${base}
      done 
   done
}


function run_taxonomy_prism() {
   set -x
   mkdir $OUT_DIR/nt_taxonomy
   seq_prisms/taxonomy_prism.sh -m 10 -D $OUT_DIR/link_farm  -O $OUT_DIR/nt_taxonomy  /dataset/GBS_Tcirc/ztmp/test/seq_prisms/link_farm/*.fasta.gz
   set +x
}


function run_sensitive_blast_prism() {
   # not actually a prism yet
   blastdb=$1
   blastbase=`basename $blastdb`
   set -x
   mkdir -p $OUT_DIR/sensitive_blast 
   for infile in $OUT_DIR/link_farm/*.fasta.gz; do
      base=`basename $infile .fasta.gz`
      tardis.py -c 10 -hpctype slurm blastn -word_size 7 -dust no -soft_masking false -db $blastdb -query _condition_fasta_input_$infile -out _condition_uncompressedtext_output_$OUT_DIR/sensitive_blast/${base}.$blastbase -evalue 0.05 -num_descriptions 1 -num_alignments 1 -num_threads 4
   done
   set +x
}


function run_blast_align_prism() {
   echo "
/dataset/GBS_Tcirc/scratch/ref_genomes/H_contortus_db
/dataset/GBS_Tcirc/scratch/ref_genomes/T_circumcincta_db
"  > $OUT_DIR/blast_references.txt
   echo  "
-evalue 1.0e-6
-evalue 1.0e-6
"  > $OUT_DIR/blast_parameters.txt
    seq_prisms/align_prism.sh -m 30 -a blastn -r $OUT_DIR/blast_references.txt -p $OUT_DIR/blast_parameters.txt -O $OUT_DIR/alignments  $OUT_DIR/link_farm/*Dovile*
}


function run_bwa_align_prism() {
   echo "
/dataset/GBS_Tcirc/scratch/ref_genomes/H_contortus_genomic.fa
/dataset/GBS_Tcirc/scratch/ref_genomes/T_circumcincta_genomic.fna
"  > $OUT_DIR/bwa_references.txt
    #seq_prisms/align_prism.sh -m 10 -a bwa -r $OUT_DIR/bwa_references.txt -O $OUT_DIR/alignments  $OUT_DIR/link_farm/*.fastq.gz
    seq_prisms/align_prism.sh -m 10 -f -a bwa -r $OUT_DIR/bwa_references.txt -O $OUT_DIR/alignments  $OUT_DIR/link_farm/*.fastq.gz
}

function run_kmer_prism() {
    #seq_prisms/kmer_prism.sh -n  -f -a fastq -O $OUT_DIR/kmer_analysis  $OUT_DIR/link_farm/*.fastq.gz
    #seq_prisms/kmer_prism.sh -n  -f -a fastq -O $OUT_DIR/kmer_analysis   /dataset/GBS_Tcirc/ztmp/test/seq_prisms/link_farm/SQ0500_8_Dovile_GAACCTC_apeki.R1.fastq.gz.fastq.s.001.fastq.gz /dataset/GBS_Tcirc/ztmp/test/seq_prisms/link_farm/SQ0500_8_undetermined.fastq.gz.fastq.s.001.fastq.gz 
    seq_prisms/kmer_prism.sh -f -a fastq -O $OUT_DIR/kmer_analysis   /dataset/GBS_Tcirc/ztmp/test/seq_prisms/link_farm/SQ0500_8_Dovile_GAACCTC_apeki.R1.fastq.gz.fastq.s.001.fastq.gz /dataset/GBS_Tcirc/ztmp/test/seq_prisms/link_farm/SQ0500_8_undetermined.fastq.gz.fastq.s.001.fastq.gz 
}



function archive_bwa() {
   set -x
   #rsync -a $OUT_DIR/alignments/*.bam  $ARCHIVE_BASE/alignments
   #rsync -a $OUT_DIR/alignments/*.stats  $ARCHIVE_BASE/alignments
   #rsync -a $OUT_DIR/alignments/*.align_prism  $ARCHIVE_BASE/alignments
   #rsync -a $OUT_DIR/alignments/*.sh  $ARCHIVE_BASE/alignments
   rsync -a $OUT_DIR/alignments/*.log  $ARCHIVE_BASE/alignments
   set +x
}



