#L6_V2.extendedFrags.fastq.clipped
#L6_V2.notCombined_1.fastq.clipped
#L6_V2.notCombined_2.fastq.clipped
#L6_V2.notCombined_unpaired.fastq.clipped
#L7_200_V2.extendedFrags.fastq.clipped
#L7_200_V2.notCombined_1.fastq.clipped
#L7_200_V2.notCombined_2.fastq.clipped
#L7_200_V2.notCombined_unpaired.fastq.clipped
#L7_500.extendedFrags.fastq.clipped
#L7_500.notCombined_1.fastq.clipped
#L7_500.notCombined_2.fastq.clipped
#L7_500.notCombined_unpaired.fastq.clipped
#L8.extendedFrags.fastq.clipped
#L8.notCombined_1.fastq.clipped
#L8.notCombined_2.fastq.clipped
#L8.notCombined_unpaired.fastq.clipped
#Sample1_LongRead_manual_trim.fastq
#Sample2_LongRead.fastq
#Sample3_LongRead.fastq
#Trinity.fasta
module load openmpi-x86_64
export PATH=$PATH:/dataset/bioinformatics_dev/active/abyss2/bin/
#abyss-pe np=20 k=84 name=abyss2_k84 q=20 lib='pe200a pe200b pe500a pe500b' mp='mp5kb mp8kb' long='longa longb' \
abyss-pe np=20 k=84 name=abyss2_k84_trans q=20 lib='pe200a pe200b pe500a pe500b' mp='mp5kb mp8kb' long='longa longb longc longd' \
pe200a='L6_V2.notCombined_1.fastq.clipped L6_V2.notCombined_2.fastq.clipped' \
pe200b='L7_200_V2.notCombined_1.fastq.clipped L7_200_V2.notCombined_2.fastq.clipped' \
pe500a='L7_500.notCombined_1.fastq.clipped L7_500.notCombined_2.fastq.clipped' \
pe500b='L8.notCombined_1.fastq.clipped L8.notCombined_2.fastq.clipped' \
se='L6_V2.extendedFrags.fastq.clipped L7_200_V2.extendedFrags.fastq.clipped L7_500.extendedFrags.fastq.clipped L8.extendedFrags.fastq.clipped' \
longa='Sample1_LongRead_manual_trim.fastq' \
longb='Sample2_LongRead.fastq' \
longc='Sample3_LongRead.fastq' \
longd='Trinity.fasta' \
mp5kb='GSM02-3Kb_S1_L001_R1_001.fastq GSM02-3Kb_S1_L001_R2_001.fastq' \
mp8kb='GSM02-8Kb_S1_L001_R1_001.fastq GSM02-8Kb_S1_L001_R2_001.fastq' > abyss2_k84_trans.out 2> abyss2_k84_trans.se &
