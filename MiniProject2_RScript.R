
getwd()

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("airway")

library(airway)
data(airway)

airway
geneinfo = rowData(airway)
View(geneinfo)

sampleinfo = colData(airway)
View(sampleinfo)

colData(airway)

counts =  assay(airway)

dim(counts)

head(counts)

log_counts <- log2(counts + 1)
hist(log_counts,
     breaks = 100,
     main = "Distribution of Log2 Transformed Counts",
     xlab = "Log2 Counts")

boxplot(log_counts,
        main = "Gene Expression Distribution Across Samples",
        xlab = "Samples",
        ylab = "Log2 Counts",
        las = 2)

sampleinfo$dex
colnames(geneinfo)
head(geneinfo)
sum(!is.na(geneinfo$gene_name))
which(geneinfo$gene_name == "FKBP5")

fkbp5_counts = log_counts[2071, ]

fkbp5_counts

data.frame(
  Sample = colnames(log_counts),
  Treatment = sampleinfo$dex,
  FKBP5 = fkbp5_counts
)

fkbp5_df <- data.frame(
  Treatment = sampleinfo$dex,
  FKBP5 = fkbp5_counts
)

boxplot(FKBP5 ~ Treatment,
        data = fkbp5_df,
        main = "FKBP5 Expression by Treatment",
        xlab = "Treatment Group",
        ylab = "Log2 Expression")

stripchart(FKBP5 ~ Treatment,
           data = fkbp5_df,
           vertical = TRUE,
           method = "jitter",
           pch = 19,
           main = "FKBP5 Expression by Treatment",
           xlab = "Treatment",
           ylab = "Log2 Expression")



