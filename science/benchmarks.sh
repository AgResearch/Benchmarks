#!/bin/sh

export SEQ_PRISMS_BIN=/dataset/invermay_hpc_benchmarking/active/afm/benchmarks/science/seq_prisms

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
\n
"

   # defaults:
   while getopts ":nhO:C:a:" opt; do
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
      echo "SAMPLER must be fasta or fastq"
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
   cd ../$SEQ_PRISMS_BIN
   get_prisms
   cp ./benchmarks.sh $OUT_DIR
   echo "
[tardish]
[tardis_engine]
" > $OUT_DIR/.tardishrc
   cd $OUT_DIR
}


function check_env() {
   if [ -z "$SEQ_PRISMS_BIN" ]; then
      echo "SEQ_PRISMS_BIN not set - exiting"
      exit 1
   fi
}


function generate_bench() {
   # this is done by doing a dry run of a number of prisms
   exit 0
}

function run_bench() {
   # TBA
   exit 0
}


function main() {
   get_opts "$@"
   check_opts
   echo_opts
   check_env
   configure_env
   if [ $TASK == "generate" ]; then
      generate_bench
   elif 
   else
      run_prism
      if [ $? == 0 ] ; then
         html_prism
      else
         echo "error state from sample run - skipping html page generation"
         exit 1
      fi
   fi
}


set -x
main "$@"
set +x
crash$


function get_prisms() {
   git clone git@github.com:AgResearch/seq_prisms.git
}


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




#get_prisms
#run_fasta_sample_prism 
#make_link_farm
#run_taxonomy_prism 
#run_sensitive_blast_prism  /dataset/GBS_Tcirc/scratch/ref_genomes/T_circumcincta_db
#run_sensitive_blast_prism  /dataset/GBS_Tcirc/scratch/ref_genomes/H_contortus_db 
#run_blast_align_prism
#run_bwa_align_prism
#run_fastq_sample_prism 
#archive_bwa
run_kmer_prism
