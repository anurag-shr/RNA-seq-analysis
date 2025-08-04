library(GEOquery)

# This fetches the proper ExpressionSet directly from GEO
gse <- getGEO("GSE153873", GSEMatrix = TRUE)

# Usually a list is returned — use [[1]] to extract the dataset
gse <- gse[[1]]

# Now this works:
pheno_data <- pData(gse)

# View metadata
head(pheno_data[, 1:5])



# Adjust the column name based on your pheno_data
sample_info <- data.frame(
  sample = pheno_data$geo_accession,
  condition = gsub("disease: ", "", pheno_data$characteristics_ch1.1)
)

# Set sample names as row names for DESeq2
rownames(sample_info) <- sample_info$sample
sample_info$condition <- factor(sample_info$condition)


# Check colnames in count matrix
colnames(counts_AD_vs_Old)

# Check rownames in sample_info
rownames(sample_info)

# View relevant columns
pheno_data[, c("geo_accession", "title")]


# Create mapping
title_to_geo <- setNames(pheno_data$geo_accession, pheno_data$title)

# Rename columns in counts
colnames(counts_AD_vs_Old) <- title_to_geo[colnames(counts_AD_vs_Old)]

all(colnames(counts) %in% rownames(sample_info))  # Should be TRUE

# Create mapping from title (e.g., "20-1T-AD") to GSM ID
title_to_geo <- setNames(pheno_data$geo_accession, pheno_data$title)

# Rename columns in counts using the title → GSM map
colnames(counts_AD_vs_Old) <- title_to_geo[colnames(counts)]

# Check which AD/Old sample names are missing from metadata
setdiff(colnames(counts_AD_vs_Old), pheno_data$title)

# Create mapping: from "20-1T-AD" to "GSM4656348"
title_to_geo <- setNames(pheno_data$geo_accession, pheno_data$title)

# Rename only those columns that match the titles in pheno_data
colnames(counts_AD_vs_Old) <- title_to_geo[colnames(counts_AD_vs_Old)]

sample_info_filtered <- sample_info[colnames(counts_AD_vs_Old), ]

all(rownames(sample_info_filtered) == colnames(counts_AD_vs_Old))  # Should return TRUE

print(colnames(counts_AD_vs_Old))
print(names(title_to_geo)[1:10])  # First few keys of the mapping

colnames(counts_AD_vs_Old) <- title_to_geo[colnames(counts_AD_vs_Old)]

counts_AD_vs_Old <- read.csv("GSE153873_counts_AD_vs_Old.csv", row.names = 1, check.names = FALSE)

colnames(counts_AD_vs_Old) <- gsub("\\.", "-", colnames(counts_AD_vs_Old))  # dots → dashes
colnames(counts_AD_vs_Old) <- trimws(colnames(counts_AD_vs_Old))           # remove spaces

print(colnames(counts_AD_vs_Old))

# Check how many match now
sum(colnames(counts_AD_vs_Old) %in% names(title_to_geo))  # Should be > 0
setdiff(colnames(counts_AD_vs_Old), names(title_to_geo))  # Anything still unmatched?

matched_titles <- intersect(colnames(counts_AD_vs_Old), names(title_to_geo))

# Rename matched ones only
colnames(counts_AD_vs_Old)[colnames(counts_AD_vs_Old) %in% matched_titles] <- title_to_geo[matched_titles]

print(colnames(counts_AD_vs_Old))

sample_info_filtered <- sample_info[colnames(counts_AD_vs_Old), ]
all(rownames(sample_info_filtered) == colnames(counts_AD_vs_Old))  # Should be TRUE

# Save filtered counts matrix

write.csv(counts_AD_vs_Old, file = "GSE153873_counts_AD_vs_Old.csv")

# Save filtered sample info

write.csv(sample_info_filtered, file = "sample_info.csv")
