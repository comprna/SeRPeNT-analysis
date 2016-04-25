# ###########################################################################
# supplementary_figure_5.R 
#
# Volcano plots of control vs protein-knockdow
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
basof <- command_args[2]
cutoff <- 0.05#command_args[3]

# Load data
dat <- read.table(stats, sep = "\t")
colnames(dat) <- c("type", "annotation", "logfold", "padj", "Significant")

# Plot figure
svgof <- paste(basof, "mirna.svg", sep = "_")
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(dat[dat$type == "miRNA",], aes(x = logfold, y = -log(padj, 10), col = Significant)) + geom_point() + facet_grid(annotation ~ ., scale = "free_y") + geom_hline(yintercept = -log(cutoff,10), size =.1)
dev.off()
svgof <- paste(basof, "snorna.svg", sep = "_")
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(dat[dat$type == "snoRNA",], aes(x = logfold, y = -log(padj, 10), col = Significant)) + geom_point() + facet_grid(annotation ~ ., scale = "free_y") + geom_hline(yintercept = -log(cutoff,10), size =.1)
dev.off()
svgof <- paste(basof, "trna.svg", sep = "_")
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(dat[dat$type == "tRNA",], aes(x = logfold, y = -log(padj, 10), col = Significant)) + geom_point() + facet_grid(annotation ~ ., scale = "free_y") + geom_hline(yintercept = -log(cutoff,10), size =.1)
dev.off()
svgof <- paste(basof, "snrna.svg", sep = "_")
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(dat[dat$type == "snRNA",], aes(x = logfold, y = -log(padj, 10), col = Significant)) + geom_point() + facet_grid(annotation ~ ., scale = "free_y") + geom_hline(yintercept = -log(cutoff,10), size =.1)
dev.off()
svgof <- paste(basof, "unknown.svg", sep = "_")
devSVG(file = svgof, bg = "white", fg = "black", onefile = TRUE, xmlHeader = TRUE)
ggplot(dat[dat$type == "unknown",], aes(x = logfold, y = -log(padj, 10), col = Significant)) + geom_point() + facet_grid(annotation ~ ., scale = "free_y") + geom_hline(yintercept = -log(cutoff,10), size =.1)
dev.off()
