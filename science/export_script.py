#!/bin/env python

import re
import sys

if len(sys.argv) != 6:
   print 'usage example : cat /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments/B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz.blastn.nt.1.0e6.sh | ./export_script.py  /dataset/bioinformatics_dev/scratch/tardis/bin/activate /dataset/GBS_Tcirc/ztmp/test/seq_prisms/fastq_samples/SQ0499_CB6K1ANXX_s_6_fastq "tardis -hpctype slurm -d  /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments" /dataset/invermay_hpc_benchmarking/scratch/afm/benchmarks/science/alignments  B74234_CCACAGTCA_psti.R1.fastq.gz.fastq.s.001.fastq.gz.blastn.nt.1.0e6.sh'
   sys.exit(1)


old_environment_source= sys.argv[1]
old_data_source = sys.argv[2]
old_prefix = sys.argv[3]
old_output_folder = sys.argv[4]
script_basename =  sys.argv[5]

#print "using %s\n\n\n"%sys.argv

for record in sys.stdin:
   if record.find(old_environment_source) >=  0: 
      print record.replace(old_environment_source, "BENCHMARK_ENVIRONMENT_SOURCE").strip()
   elif record.find(old_prefix) >= 0:
      new_record = record.replace(old_prefix, "")
      new_record = new_record.replace(old_data_source, "$BENCHMARK_DATA_FOLDER").strip()
      new_record = new_record.replace(old_output_folder, "$BENCHMARK_OUTPUT_FOLDER").strip()
      new_record = new_record.replace("\\", "").strip()
      new_record = re.sub("_condition_\S+_input_","",new_record)
      new_record = re.sub("_condition_\S+_output_","",new_record)
      print new_record + " 2>$BENCHMARK_OUTPUT_FOLDER/%s.stderr"%script_basename
   else:
      print record.strip()
      
