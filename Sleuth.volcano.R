#Generate volcano plots for the different samples. 

library(ggplot2)
ggplot(data=sleuth_significant_genes, aes(x=log2FoldChange1,y=-log10(qval))) + geom_point(aes(colour=test), size = 0.8, alpha = 0.4) + scale_colour_manual(values=c('black', 'red')) + theme_minimal() + geom_vline(xintercept = 1.5, color = 'blue', size = 0.3, linetype = 2) + geom_vline(xintercept = -1.5, color = 'blue', size = 0.3, linetype = 2) + geom_hline(yintercept = -log10(0.05), color = 'blue', size = 0.3, linetype = 2) + theme(legend.position = 'none') + theme(axis.title = element_text(size = rel(1.5))) + theme(axis.text  = element_text(size = rel(1.5)))
  

sleuth_significant_genes$test = sleuth_significant_genes$qval < 0.05 & abs(sleuth_significant_genes$log2FoldChange1) > 1.5

ggplot(data=sleuth_significant_genes, aes(x=log2FoldChange2,y=-log10(qval))) + geom_point(aes(colour=test2), size = 0.8, alpha = 0.4) + scale_colour_manual(values=c('black', 'red')) + theme_minimal() + geom_vline(xintercept = 1.5, color = 'blue', size = 0.3, linetype = 2) + geom_vline(xintercept = -1.5, color = 'blue', size = 0.3, linetype = 2) + geom_hline(yintercept = -log10(0.05), color = 'blue', size = 0.3, linetype = 2) + theme(legend.position = 'none')

sleuth_significant_genes$test2 = sleuth_significant_genes$qval < 0.05 & abs(sleuth_significant_genes$log2FoldChange2) > 1.5

ggplot(data=sleuth_significant_genes, aes(x=log2FoldChange3,y=-log10(qval))) + geom_point(aes(colour=test3), size = 0.8, alpha = 0.4) + scale_colour_manual(values=c('black', 'red')) + theme_minimal() + geom_vline(xintercept = 1.5, color = 'blue', size = 0.3, linetype = 2) + geom_vline(xintercept = -1.5, color = 'blue', size = 0.3, linetype = 2) + geom_hline(yintercept = -log10(0.05), color = 'blue', size = 0.3, linetype = 2) + theme(legend.position = 'none')

sleuth_significant_genes$test3 = sleuth_significant_genes$qval < 0.05 & abs(sleuth_significant_genes$log2FoldChange3) > 1.5
