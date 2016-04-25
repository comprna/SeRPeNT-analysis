# ###########################################################################
# supplementary_figure_5.R 
#
# Histogram of the number of cell lines for which a profile is expressed
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ###########################################################################

# Load libraries
library(ggplot2)
library(RSvgDevice)

# Read command line arguments
command_args <- commandArgs(trailingOnly=TRUE)
stats <- command_args[1]
svgof <- command_args[2]

# Load data
prf <- read.table(stats, sep = "\t")
colnames(prf) <- c("type", "entropy", "cells")

# Plot figure
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(prf, aes(x = factor(cells))) + geom_histogram() + xlab("# cell lines") + ylab("# profiles")
dev.off()
