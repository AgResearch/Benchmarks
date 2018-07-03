#===THIS R SCRIPT IS INTELLECTUAL PROPERTY OF AGRESEARCH LTD. DISTRIBUTION AND/OR USAGE WITHOUT AGRESEARCH'S KNOWLEDGE IS STRICTLY PROHIBITED===
#=== load required R packages ================================
library(xcms)
library(CAMERA)
library(snow)
library(multtest)
library(Biobase)

#=== setting processing parameters ===========================
# detecting number of available processors
nSlve = as.numeric(Sys.getenv()["NUMBER_OF_PROCESSORS"])

# setting work directory
output_dir = Sys.getenv(){"outdir"}
setwd(output_dir)

list.files()

# setting work directory
filename = "Abbott_HILIC_Pos_Analysis.RData"

# raw data input with only ONE form of ionisation - choose the directory containing your files
input_dir = Sys.getenv(){"datadir"}
mzXMLfiles <- list.files(input_dir, pattern=".mzXML$", recursive = TRUE, full.names = TRUE)

# minimum fraction [%] of samples necessary in at least one of the sample groups for it to be a valid group
minfraction <- 50    


##############################################################
###   HPLC  Orbitrap 
##############################################################

########################################
#XCMS-PRE-PROCESSING
########################################
start.time.t <- Sys.time()
#=== peak detection ==========================================
start.time <- Sys.time()
	xset <- xcmsSet(mzXMLfiles, nSlaves = nSlve, method = "centWave", ppm = 10, mzdiff = 0.001, peakwidth =c(10,60), prefilter = c(3,10000), snthresh = 20, integrate = 1, noise = 5000)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken 
save.image(filename)
#=== peak grouping ===========================================
minFRAC<-as.numeric(minfraction)/100
start.time <- Sys.time()
	xs.grp <- group.density(xset, bw = 5, mzwid = 0.015, minfrac = minFRAC)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # 6 sec 766 peak groups

#=== Retention Time correction ===============================  
start.time <- Sys.time()
	xs.grp.rt <- retcor.obiwarp(xs.grp, plottype = "deviation")
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # 28.4 min 

#=== regrouping ==============================================
start.time <- Sys.time()
	xs.regrp <- group.density(xs.grp.rt, bw = 5, mzwid = 0.015, minfrac = minFRAC)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken # 6 sec 772 peak grps

#=== fill peaks ==============================================
start.time <- Sys.time()
xs.fill <- fillPeaks(xs.regrp, nSlaves = nSlve)
end.time <- Sys.time()
time.taken <- end.time - start.time
save.image(filename)

#==== D1 & D2 Matrices =============================================
d1 <- peakTable(xs.regrp)
d2 <- peakTable(xs.fill)

write.csv(d1, "d1.csv", row.names = FALSE)
write.csv(d2, "d2.csv", row.names = FALSE)
