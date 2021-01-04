#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=10:00:00
#SBATCH --job-name=hisat2er
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/home/erossini/output_%j.o
#SBATCH --error=/home/erossini/error_%j.o

#load the modules for HISAT2 aligner and samtools.
module add UHTS/Aligner/hisat/2.2.1
module add UHTS/Analysis/samtools/1.10

#create a variable for the directory of the fastq files.
FASTQ_DIR=/data/courses/rnaseq/lncRNAs/Project2/fastq

#create a directory for the results.
mkdir -p /data/users/erossini/Hisat2/sample1_dta

#enter the directory and create a symbolic link with the reference file.
cd /data/users/erossini/Hisat2/sample1_dta
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/grch38 .

#perform alignment of the reads to the reference genome with HISAT2 software.
hisat2 --dta -x grch38/genome -1 $FASTQ_DIR/1_1_L3_R1_001_ij43KLkHk1vK.fastq.gz -2 $FASTQ_DIR/1_1_L3_R2_001_qyjToP2TB6N7.fastq.gz -S Replicate_1_1.sam
samtools view -b Replicate_1_1.sam > Replicate_1_1.bam
samtools sort Replicate_1_1.bam -o Replicate_1_1.sorted.bam

hisat2 --dta -x grch38/genome -1 $FASTQ_DIR/1_2_L3_R1_001_DnNWKUYhfc9S.fastq.gz -2 $FASTQ_DIR/1_2_L3_R2_001_SNLaVsTQ6pwl.fastq.gz -S Replicate_1_2.sam
samtools view -b Replicate_1_2.sam > Replicate_1_2.bam
samtools sort Replicate_1_2.bam -o Replicate_1_2.sorted.bam

hisat2 --dta -x grch38/genome -1 $FASTQ_DIR/1_5_L3_R1_001_iXvvRzwmFxF3.fastq.gz -2 $FASTQ_DIR/1_5_L3_R2_001_iXCMrktKyEh0.fastq.gz -S Replicate_1_5.sam
samtools view -b Replicate_1_5.sam > Replicate_1_5.bam
samtools sort Replicate_1_5.bam -o Replicate_1_5.sorted.bam
