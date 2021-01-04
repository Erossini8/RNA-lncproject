setwd("/data/users/erossini/Sleuth")

suppressMessages({
  library("sleuth")
})

suppressMessages({
  library("biomaRt")
})

sample_id<-dir(file.path("..", "Kallisto", "Results"))
sample_id

kal_dirs<-file.path("..", "Kallisto", "Results", sample_id)
kal_dirs

s2c <- read.table(file.path("..", "Kallisto", "info.txt"), header = TRUE, stringsAsFactors = FALSE)
s2c <- dplyr::mutate(s2c, path = kal_dirs)
print(s2c)

so <- sleuth_prep(s2c, extra_bootstrap_summary = TRUE)
so <- sleuth_fit(so, ~condition, 'full')
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_lrt(so, 'reduced', 'full')
models(so)

sleuth_table <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE)

matrix_tpm <- sleuth_to_matrix(so, 'obs_norm', 'tpm')
matrix_counts <- sleuth_to_matrix(so, 'obs_norm', 'est_counts')

mart <- biomaRt::useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl", host = 'ensembl.org')
t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id", "ensembl_gene_id", "external_gene_name"), mart = mart)
t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id, ens_gene = ensembl_gene_id, ext_gene = external_gene_name)

so <- sleuth_prep(s2c, target_mapping = t2g)
so <- sleuth_fit(so, ~condition, 'full')
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_lrt(so, 'reduced', 'full')

sleuth_significant_genes <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE)
sleuth_significant_genes <- dplyr::filter(sleuth_significant_genes, qval <= 0.1)

Replicate1<-matrix_tpm[,1:3]
Replicate1<-rowSums(Replicate1)
Replicate1<-Replicate1+0.125

Replicate2<-matrix_tpm[,4:6]
Replicate2<-rowSums(Replicate2)
Replicate2<-Replicate2+0.125

Replicate3<-matrix_tpm[,7:9]
Replicate3<-rowSums(Replicate3)
Replicate3<-Replicate3+0.125

ReplicateP<-matrix_tpm[,10:12]
ReplicateP<-rowSums(ReplicateP)
ReplicateP<-ReplicateP+0.125

f_change1<-Replicate1/ReplicateP
f_change2<-Replicate2/ReplicateP
f_change3<-Replicate3/ReplicateP

log2FoldChange1<-log2(f_change1)
log2FoldChange2<-log2(f_change2)
log2FoldChange3<-log2(f_change3)

f_change <- data.frame(transcriptName=rownames(matrix_tpm),log2FoldChange1,log2FoldChange2,log2FoldChange3)

for(i in 1:dim(sleuth_significant_genes)[1]){
  sleuth_significant_genes[i,15:17]<-f_change[f_change$transcriptName==sleuth_significant_genes$target_id[i],2:4]
}

save.image(file = "Sleuth.RData")
