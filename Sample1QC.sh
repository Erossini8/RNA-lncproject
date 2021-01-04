#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=03:00:00
#SBATCH --job-name=fastQC
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/home/erossini/output_%j.o
#SBATCH --error=/home/erossini/error_%j.o

#load the modules used to perform the quality control of the reads.
module add UHTS/Quality_control/fastqc/0.11.7
module add UHTS/Analysis/MultiQC/1.8

#create and go to the directory for the Sample1 quality control results.
mkdir -p /data/users/erossini/QCresults/Sample1
cd /data/users/erossini/QCresults/Sample1

#create symbolic link for each fastq file of the first sample.
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/1_1_L3_R1_001_ij43KLkHk1vK.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/1_1_L3_R2_001_qyjToP2TB6N7.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/1_2_L3_R1_001_DnNWKUYhfc9S.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/1_2_L3_R2_001_SNLaVsTQ6pwl.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/1_5_L3_R1_001_iXvvRzwmFxF3.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/1_5_L3_R2_001_iXCMrktKyEh0.fastq.gz

#check the quality of the reads using fastqc. Each replicate is analysed separately.
fastqc -t 6 *.fastq.gz

#multiqc is used to produce a single file for Sample1 quality control.
multiqc .
