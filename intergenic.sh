#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10000M
#SBATCH --time=05:00:00
#SBATCH --job-name=intergenic
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/erossini/output_intergenic_%j.o
#SBATCH --error=/data/users/erossini/error_intergenic_%j.o

#load module.
module add UHTS/Analysis/BEDTools/2.29.2

#create directory for the results.
mkdir -p /data/users/erossini/intergenic

#enter the directory.
cd /data/users/erossini/intergenic

#create symbolic links with the input files needed.
ln -s /data/users/erossini/StringTie/meta-assembly.gtf
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/gencode.v35.chr_patch_hapl_scaff.annotation.gtf

#create a new file with only the novel genes.
awk '/MSTRG/' meta-assembly.gtf > novel_assembly.gtf

#beedtools intersect in order to test the overlap between coordinates of annotated
#genes and coordinates of our novel genes.
bedtools intersect -v -a novel_assembly.gtf \
                      -b gencode.v35.chr_patch_hapl_scaff.annotation.gtf

#No overlap found by bedtools intersect.
#To see the novel 'intergenic' genes, the following step were performed on the command line
#awk '/MSTRG/ {print $10}' novel_assembly.gtf > gene_id.txt
#sort gene_id.txt | uniq -c | wc -l
#Result: 12476 genes.
