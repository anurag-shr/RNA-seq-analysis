library(DESeq2)

dds <- DESeqDataSetFromMatrix(countData = counts_data,
                              colData = colData,
                              design = ~ condition)

dds

# pre-filtering: removing rows with low gene counts
# keeping rows that have at least 10 reads total
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

dds

# set the factor level

dds$condition <- relevel(dds$condition, ref = "AD")

# Run DESeq

dds <- DESeq(dds)
res <- results(dds)

res

summary(res)

res0.05 <- results(dds, alpha = 0.05)
summary(res0.05)

sig_genes <- res[which(res$padj < 0.05), ]

sig_genes <- res[which(res$padj < 0.05 & abs(res$log2FoldChange) > 1), ]

write.csv(as.data.frame(sig_genes), "DEGs_AD_vs_Old.csv")

sig_genes
