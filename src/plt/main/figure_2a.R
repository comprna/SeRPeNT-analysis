# #######################################
# figure_2a.R 
#
# Summary of the known and novel profiles

# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #######################################

# Load libraries
library(ggplot2)
library(RSvgDevice)

# Read command line arguments
command_args <- commandArgs(trailingOnly=TRUE)
stats <- command_args[1]
svgof <- command_args[2]

# Load data
prf <- read.table(stats, sep = "\t")
colnames(prf) <- c("cell", "status", "profiles")

# Plot figure
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(prf, aes(x = cell, y = profiles, fill = status)) + geom_bar(stat = "identity", width = .5) + coord_flip()
dev.off()
