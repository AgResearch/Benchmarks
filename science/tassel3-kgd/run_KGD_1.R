#gform <- "Tassel"  ####Used for RA files
gform <- "uneak"   ####Used for HapMap files
genofile <- "../HapMap.hmc.txt"   ###Add location to Ra or HapMap file
sampdepth.thresh <- 0.3
source("../GBS-Chip-Gmatrix.R")
Gfull <- calcG()
GHWdgm.05 <- calcG(which(HWdis > -0.05),"HWdgm.05", npc=4)

###To save a G Matrix

G5 <- GHWdgm.05$G5
sampleID  <- read.table(text=seqID,sep="_",fill=TRUE)[,1]  ###This takes the first part of the ID before a '_'. Might need to be edited for consistent sample ID format.
save(G5,sampleID,file="KGD_run_1.RData") ###Insert name of file
write.csv(G5, "KGD_run_1.RData.csv", row.names=F)
