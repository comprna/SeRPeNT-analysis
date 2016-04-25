# ###########################################################################
# supplementary_figure_2.R 
#
# Empirical calculation of the fold-change cutoff for differential processing
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
colnames(prf) <- c("reads", "cell", "Significant", "foldchange")

# Plot figure
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(prf, aes(x = foldchange, fill = Significant, col = Significant)) + geom_histogram(position = position_dodge(width=.5)) + scale_x_continuous(breaks = seq(0,20,1), lim=c(0,20)) + geom_freqpoly() + facet_grid(cell~., scale="free_y")
dev.off()
