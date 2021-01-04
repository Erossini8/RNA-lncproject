#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2000M
#SBATCH --time=01:00:00
#SBATCH --job-name=sTie_er
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/home/erossini/output_%j.o
#SBATCH --error=/home/erossini/error_%j.o

#load stringtie module.
module add UHTS/Aligner/stringtie/1.3.3b

#create a directory for results.
mkdir -p /data/users/erossini/StringTie

#enter the directory.
cd /data/users/erossini/StringTie

#create symbolic links for required reference annotation and sample BAM files.
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/gencode.v35.chr_patch_hapl_scaff.annotation.gtf
ln -s /data/users/erossini/mergedBAM/sample1.merged.bam
ln -s /data/users/erossini/mergedBAM/sample2.merged.bam
ln -s /data/users/erossini/mergedBAM/sample3.merged.bam
ln -s /data/users/erossini/mergedBAM/sampleP.merged.bam


#assemble the transcriptome with stringtie.
stringtie sample1.merged.bam -G gencode.v35.chr_patch_hapl_scaff.annotation.gtf -o sample1.gtf
stringtie sample2.merged.bam -G gencode.v35.chr_patch_hapl_scaff.annotation.gtf -o sample2.gtf
stringtie sample3.merged.bam -G gencode.v35.chr_patch_hapl_scaff.annotation.gtf -o sample3.gtf
stringtie sampleP.merged.bam -G gencode.v35.chr_patch_hapl_scaff.annotation.gtf -o sampleP.gtf
stringtie --merge -G gencode.v35.chr_patch_hapl_scaff.annotation.gtf sample1.gtf sample2.gtf sample3.gtf sampleP.gtf -o meta-assembly.gtf

#To see how many exons: awk '/exon_number/' meta-assembly.gtf | wc -l
#To see how many transcripts: awk '$3=="transcript"' meta-assembly.gtf | wc -l
#create new file with only transcripts: awk '$3=="transcript"' meta-assembly.gtf > transcripts.gtf
#create new file with only gene_id: awk '{print $10}' transcripts.gtf > genes.txt
#To see how many genes: awk '{print $1}' genes.txt | sort | uniq -c | wc -l
#create a file with only not annotated molecules: awk '/MSTRG/' meta-assembly.gtf > novel.gtf
#To see how many novel exons: awk '/exon_number/' novel.gtf | wc -l
#To see how many novel transcripts: awk '$3=="transcript"' novel.gtf | wc -l
#To see ho many novel genes: awk '{print $10}' novel.gtf > novel_genes.txt
#To see how many novel genes: awk '{print $1}' novel_genes.txt | sort | uniq -c | wc -l
#Quality check: how many single exons?
#create temporary file with only exon_number: awk '{print $14}' meta-assembly.gtf > exons.gtf
#A)awk '/exon_number "1"/' meta-assembly.gtf | wc -l
#B)awk '/exon_number "2"/' meta-assembly.gtf | wc -l
#calculate how many transcripts have single exons: A-B
#how many genes have a more than 1 exon: awk '{print $10}' 2.txt | sort | uniq -c | wc -l
#Genes that have a single exon: total genes - genes with more than 1 exon.
