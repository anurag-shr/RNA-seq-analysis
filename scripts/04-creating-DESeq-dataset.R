# read counts data

counts_data <- read.csv('GSE153873_counts_AD_vs_Old.csv', row.names = 1, check.names = FALSE)
head(counts_data)

# read sample info

colData <- read.csv('sample_info.csv')
head(colData)


sample_info_filtered$condition <- ifelse(
  grepl("Alzheimer", sample_info_filtered$condition, ignore.case = TRUE),
  "AD",
  "Old"
)

table(sample_info_filtered$condition)

rownames(colData) <- colData$sample

colData$sample <- NULL  # Remove redundant column

colnames(colData)[colnames(colData) == "X"] <- "sample"


# Making sure all the column names in countData are present as row names in colData

all(colnames(counts_data) %in% rownames(colData)) # This should return true 


# also checking if they are in the same order 

all(rownames(colData) == colnames(counts_data))  # Should be TRUE




