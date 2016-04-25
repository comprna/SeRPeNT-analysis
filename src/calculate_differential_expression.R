# #####################################################################################
# calculate_differential_expression.R
#
# Uses DESeq2 R package to calculate differential expression of features in the SeRPeNT
# extended annotation between AGO-loaded and DICER-knockdown datasets
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #####################################################################################

# Load libraries
library(DESeq2)

# Read command line arguments
command_args <- commandArgs(trailingOnly=TRUE)
diffexp <- command_args[1]
cutoff <- command_args[2]
deout <- command_args[3]

# Load data
dem <- as.matrix(read.table(diffexp, sep = "\t", header = T, row.names = 1))

# Create sample information data frame
condition <- c("control", "control", "knockdown", "knockdown")
type <- c("single-read", "single-read", "single-read", "single-read")
rows <- colnames(dem)
df <- data.frame(condition, type, row.names = rows)

# Generate DESeqDataSet object from matrix
dds <- DESeqDataSetFromMatrix(countData = dem, colData = df, design = ~ condition)

# Pre-filtering
dds <- dds[ rowSums(counts(dds)) > 1, ]

# Set factor levels
dds$condition <- factor(dds$condition, levels = c("control", "knockdown"))

# Differential expression analysis
dds <- DESeq(dds)
res <- results(dds, alpha = cutoff)

# Write table
write.table(res, file=deout, sep ="\t")
