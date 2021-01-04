#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=15000M
#SBATCH --time=10:00:00
#SBATCH --job-name=Kallisto
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/home/erossini/output_%j.o
#SBATCH --error=/home/erossini/error_%j.o

#load Kallisto module.
module add UHTS/Analysis/kallisto/0.46.0

#create a varible to easier acces to fastq files.
FASTQ_DIR=/data/courses/rnaseq/lncRNAs/Project2/fastq

#enter the directory for Kallisto results.
cd /data/users/erossini/Kallisto

#perform quantification.
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_1_1 -b 50 $FASTQ_DIR/1_1_L3_R1_001_ij43KLkHk1vK.fastq.gz $FASTQ_DIR/1_1_L3_R2_001_qyjToP2TB6N7.fastq.gz
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_1_2 -b 50 $FASTQ_DIR/1_2_L3_R1_001_DnNWKUYhfc9S.fastq.gz $FASTQ_DIR/1_2_L3_R2_001_SNLaVsTQ6pwl.fastq.gz
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_1_5 -b 50 $FASTQ_DIR/1_5_L3_R1_001_iXvvRzwmFxF3.fastq.gz $FASTQ_DIR/1_5_L3_R2_001_iXCMrktKyEh0.fastq.gz
