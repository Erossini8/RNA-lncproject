#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=14:00:00
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
mkdir -p /data/users/erossini/Hisat2/sampleP_dta

#enter the directory and create a symbolic link with the reference file.
cd /data/users/erossini/Hisat2/sampleP_dta
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/grch38 .

#perform alignment of the reads to the reference genome with HISAT2 software. 
hisat2 --dta -x grch38/genome -1 $FASTQ_DIR/P1_L3_R1_001_9L0tZ86sF4p8.fastq.gz -2 $FASTQ_DIR/P1_L3_R2_001_yd9NfV9WdvvL.fastq.gz -S Replicate_P1.sam
samtools view -b Replicate_P1.sam > Replicate_P1.bam
samtools sort Replicate_P1.bam -o Replicate_P1.sorted.bam

hisat2 --dta -x grch38/genome -1 $FASTQ_DIR/P2_L3_R1_001_R82RphLQ2938.fastq.gz -2 $FASTQ_DIR/P2_L3_R2_001_06FRMIIGwpH6.fastq.gz -S Replicate_P2.sam
samtools view -b Replicate_P2.sam > Replicate_P2.bam
samtools sort Replicate_P2.bam -o Replicate_P2.sorted.bam

hisat2 --dta -x grch38/genome -1 $FASTQ_DIR/P3_L3_R1_001_fjv6hlbFgCST.fastq.gz -2 $FASTQ_DIR/P3_L3_R2_001_xo7RBLLYYqeu.fastq.gz -S Replicate_P3.sam
samtools view -b Replicate_P3.sam > Replicate_P3.bam
samtools sort Replicate_P3.bam -o Replicate_P3.sorted.bam
