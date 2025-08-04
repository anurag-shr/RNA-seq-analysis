
plotMA(res0.05, ylim = c(-5, 5), main = "MA Plot: Old vs AD")

library(ggplot2)

# Top 10 from GO Biological Process
go_df <- enrich_results[["GO_Biological_Process_2023"]]
top_go <- go_df[1:10, ]

ggplot(top_go, aes(x = reorder(Term, -Combined.Score), y = Combined.Score)) +
  geom_col(fill = "#008080") +
  coord_flip() +
  labs(title = "Top Enriched GO Terms", x = "Biological Process", y = "Combined Score") +
  theme_minimal()

library(EnhancedVolcano)

EnhancedVolcano(res,
                lab = rownames(res0.05),
                x = 'log2FoldChange',
                y = 'padj',
                title = 'Volcano Plot: Old vs AD',
                pCutoff = 0.05,
                FCcutoff = 1,
                pointSize = 2.5,
                labSize = 3,
                col = c('grey30', 'forestgreen', 'royalblue', 'red2'))

library(ggplot2)

top_go <- head(go_df[order(go_df$Combined.Score, decreasing = TRUE), ], 10)

ggplot(top_go, aes(x = reorder(Term, Combined.Score), y = Combined.Score)) +
  geom_col(fill = "#0072B2") +
  coord_flip() +
  labs(title = "Top GO Terms (Upregulated in AD)",
       x = "GO Biological Process",
       y = "Combined Score") +
  theme_minimal()

