#set working directory

setwd('C:/Users/angs2/Desktop/code/RNA-seq-analysis/data')

#Load the count data

counts <- read.table("GSE153873_summary_count.star.txt",
                     header = TRUE,
                     sep = "\t",
                     row.names = 1,
                     check.names = FALSE,
                     stringsAsFactors = FALSE)


# Keep only columns that are sample counts
# If all columns are samples, skip this
counts <- counts[, grep("AD|Old|Young", colnames(counts))]  # adjust as needed

# Remove genes with zero counts across all samples
counts <- counts[rowSums(counts) > 0, ]


write.csv(counts, file = "GSE153873_counts_clean.csv")

# Filter just AD and Old samples
sample_names <- colnames(counts)
condition <- ifelse(grepl("AD", sample_names), "AD",
                    ifelse(grepl("Old", sample_names), "Old", "Young"))
keep <- condition %in% c("AD", "Old")

counts_AD_vs_Old <- counts[, keep]

# Save this filtered matrix
write.csv(counts_AD_vs_Old, file = "GSE153873_counts_AD_vs_Old.csv")

