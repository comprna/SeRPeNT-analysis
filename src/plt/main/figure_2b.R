# ##################################################################################
# figure_2b.R 
# 
# Hierarchical clustering of the clusters of profiles for a cell line or compartment
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ##################################################################################

# Load libraries
library(ape)

# Read command line arguments
command_args <- commandArgs(trailingOnly=TRUE)
stats <- command_args[1]
svgof <- command_args[2]

# Load data
d <- read.table(stats, header = T, row.names = 1)

# Convert data
m <- as.matrix(d)
dist <- as.dist(m)
hc <- hclust(dist)
tree <- as.phylo(hc)

# Write tree in neWick format
write.tree(phy = tree, file = svgof)
