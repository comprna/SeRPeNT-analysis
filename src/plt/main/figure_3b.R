# ###############################################################
# figure_3b.R 
#
# Differentially processed profiles between cellular compartments
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ###############################################################

# Load libraries
library(ggplot2)
library(RSvgDevice)

# Read command line arguments
command_args <- commandArgs(trailingOnly=TRUE)
stats <- command_args[1]
svgof <- command_args[2]

# Load data
prf <- read.table(stats, sep = "\t")
colnames(prf) <- c("cond1", "cond2", "Biotype", "dfp", "total", "percent")

# Plot figure
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(prf, aes(x = Biotype, y = percent, fill = Biotype, label = total)) + geom_bar(stat = "identity") + facet_grid(cond1~cond2) + geom_text(size = 4) + ylim(0,100)
dev.off()
