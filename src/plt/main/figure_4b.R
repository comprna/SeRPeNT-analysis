# ######################################################
# figure_4b.R 
#
# Volcano plots of snoRNAs in control vs Dicer-knockdown
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################################################

# Load libraries
library(ggplot2)
library(RSvgDevice)

# Read command line arguments
command_args <- commandArgs(trailingOnly=TRUE)
stats <- command_args[1]
svgof <- command_args[2]
cutoff <- as.numeric(command_args[3])

# Load data
dat <- read.table(stats, sep = "\t")
colnames(dat) <- c("type", "annotation", "logfold", "padj", "Significant")

# Plot figure
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(dat[dat$type == "snoRNA",], aes(x = logfold, y = -log(padj, 10), col = Significant)) + geom_point() + facet_grid(annotation ~ ., scale = "free_y") + geom_hline(yintercept = -log(cutoff,10), size =.1)
dev.off()
