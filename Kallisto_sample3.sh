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
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_3_2 -b 50 $FASTQ_DIR/3_2_L3_R1_001_DID218YBevN6.fastq.gz $FASTQ_DIR/3_2_L3_R2_001_UPhWv8AgN1X1.fastq.gz
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_3_4 -b 50 $FASTQ_DIR/3_4_L3_R1_001_QDBZnz0vm8Gd.fastq.gz $FASTQ_DIR/3_4_L3_R2_001_ng3ASMYgDCPQ.fastq.gz
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_3_7 -b 50 $FASTQ_DIR/3_7_L3_R1_001_Tjox96UQtyIc.fastq.gz $FASTQ_DIR/3_7_L3_R2_001_f60CeSASEcgH.fastq.gz
