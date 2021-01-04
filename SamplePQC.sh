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

#create and go to the directory for the SampleP quality control results.
mkdir -p /data/users/erossini/QCresults/SampleP
cd /data/users/erossini/QCresults/SampleP

#create symbolic link for each replicate of the parental sample.
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/P1_L3_R1_001_9L0tZ86sF4p8.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/P1_L3_R2_001_yd9NfV9WdvvL.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/P2_L3_R1_001_R82RphLQ2938.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/P2_L3_R2_001_06FRMIIGwpH6.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/P3_L3_R1_001_fjv6hlbFgCST.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/P3_L3_R2_001_xo7RBLLYYqeu.fastq.gz

#check the quality of the reads using fastqc. Each replicate is analysed separately.
fastqc -t 6 *.fastq.gz

#multiqc is used to produce a single file for SampleP quality control.
multiqc .
