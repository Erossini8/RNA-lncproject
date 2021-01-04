#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=02:00:00
#SBATCH --job-name=fastQC
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/home/erossini/output_%j.o
#SBATCH --error=/home/erossini/error_%j.o

#load the modules used to perform the quality control of the reads.
module add UHTS/Quality_control/fastqc/0.11.7
module add UHTS/Analysis/MultiQC/1.8

#create and go to the directory for the Sample3 quality control results.
mkdir -p /data/users/erossini/QCresults/Sample3
cd /data/users/erossini/QCresults/Sample3

#create symbolic link for each replicate of the third sample.
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/3_2_L3_R1_001_DID218YBevN6.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/3_2_L3_R2_001_UPhWv8AgN1X1.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/3_4_L3_R1_001_QDBZnz0vm8Gd.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/3_4_L3_R2_001_ng3ASMYgDCPQ.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/3_7_L3_R1_001_Tjox96UQtyIc.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/3_7_L3_R2_001_f60CeSASEcgH.fastq.gz

#check the quality of the reads using fastqc. Each replicate is analysed separately.
fastqc -t 6 *.fastq.gz

#multiqc is used to produce a single file for Sample3 quality control.
multiqc .
