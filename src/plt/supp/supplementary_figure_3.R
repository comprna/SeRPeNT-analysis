# ###########################################################################
# supplementary_figure_3.R 
#
# Benchmarking against (Li et al. 2010) on microRNA arm switching
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
colnames(prf) <- c("mirna", "dp", "lfc")

# Plot figure
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(prf, aes(x = reorder(mirna, lfc), y = lfc, col = dp)) + geom_point() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + xlab(NULL) + geom_hline(yintercept = log(2.5, 10))
dev.off()
