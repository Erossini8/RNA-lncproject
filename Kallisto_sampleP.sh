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
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_P1 -b 50 $FASTQ_DIR/P1_L3_R1_001_9L0tZ86sF4p8.fastq.gz $FASTQ_DIR/P1_L3_R2_001_yd9NfV9WdvvL.fastq.gz
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_P2 -b 50 $FASTQ_DIR/P2_L3_R1_001_R82RphLQ2938.fastq.gz $FASTQ_DIR/P2_L3_R2_001_06FRMIIGwpH6.fastq.gz
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_P3 -b 50 $FASTQ_DIR/P3_L3_R1_001_fjv6hlbFgCST.fastq.gz $FASTQ_DIR/P3_L3_R2_001_xo7RBLLYYqeu.fastq.gz
