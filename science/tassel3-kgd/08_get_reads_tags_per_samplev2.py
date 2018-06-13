#!/usr/bin/env python

import os

cwd = os.getcwd()

#read tag info

os.chdir(cwd)
infile = "02_FastqToTagCount.log"
infh = open(infile)

outfile_lanes = "ReadCount.lanes.csv"
ofh_lanes = open(outfile_lanes, "w")

outfile_tags = "TagCount.csv"
ofh_tags = open(outfile_tags, "w")


outline = ""

print >> ofh_lanes, "sample,flowcell,lane,sq,tags,reads,comment,enzyme,species"
print >> ofh_tags, "sample,flowcell,lane,sq,tags,reads,comment,enzyme,species"

for line in infh.readlines():
	line = line.strip()
	if "Reading FASTQ file:" in line:
		line = line.split("/")
		line = line[-1]
		line = line.split("_")
		sq = line[0].replace("SQ", "")
		while sq.startswith("0"):
			sq = sq[1:]
		flowcell = line[1]
		lane = line[3]
		cellline = "%s,%s,%s" %(flowcell, lane, sq)
	elif "Total number of reads in lane" in line:
		line = line.split("=")
		total_line = "total,%s,,%s" %(cellline, line[-1])
		my_data_0 = []
		my_data_1 = []
		my_data_2 = []
		total_line += ",%s" %'|'.join(my_data_0)
		total_line += ",%s" %'|'.join(my_data_1)
		total_line += ",%s" %'|'.join(my_data_2)
		print >> ofh_lanes, total_line
	elif "Total number of good barcoded reads" in line:
		line = line.split("=")
		good_line = "good,%s,,%s" %(cellline, line[-1])
		good_line += ",%s" %'|'.join(my_data_0)
		good_line += ",%s" %'|'.join(my_data_1)
		good_line += ",%s" %'|'.join(my_data_2)
		print >> ofh_lanes, good_line
		cellline = ""
		total_line = ""
		good_line = ""
	elif "will be output to" in line:
		sample = line.split('tagCounts/')[-1]
#		print sample	#Ali_0226_C4TY8ACXX_3_17_X4.cnt
		sampleID = sample.split('_')[:-4]
		sampleID = '_'.join(sampleID)
		flowcell = sample.split('_')[:-3][-1]
		lane = sample.split('_')[:-2][-1]
		sq = sample.split('_')[:-1][-1]
		outline = "%s,%s,%s,%s" %(sampleID, flowcell, lane, sq)
	elif not outline == "":
		line = line.split()
		outline += ",%s,%s," %(line[1], line[6])
		print >> ofh_tags, outline
		outline = ""
	else:
		pass

infh.close()
ofh_lanes.close()
ofh_tags.close()
