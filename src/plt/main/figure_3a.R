# #################################################
# figure_3a.R 
#
# Clustering solutions for ENCODE cell compartments
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################

# Load libraries
library(ggplot2)
library(plyr)
library(RSvgDevice)

# Read command line arguments
command_args <- commandArgs(trailingOnly=TRUE)
stats <- command_args[1]
svgof <- command_args[2]

# Load data
prf <- read.table(stats, sep = "\t")
colnames(prf) <- c("name", "index", "cluster", "entropy", "Elements", "Biotype", "Partials")

# Plot figure
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(prf, aes(x = index, y = entropy, col = Biotype, label = cluster)) + geom_point(aes(size = Partials)) + scale_size() + xlab("Cluster number") + ylab("Normalized entropy") + facet_grid(.~name, scale = "free_x")
dev.off()
