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
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_2_2 -b 50 $FASTQ_DIR/2_2_L3_R1_001_77KSDZXkzpN2.fastq.gz $FASTQ_DIR/2_2_L3_R2_001_2oenLbeyyPvS.fastq.gz
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_2_3 -b 50 $FASTQ_DIR/2_3_L3_R1_001_DZmuiRvA53zD.fastq.gz $FASTQ_DIR/2_3_L3_R2_001_bW28atsMceL2.fastq.gz
kallisto quant -i meta-assembly.idx -o /data/users/erossini/Kallisto/Replicate_2_4 -b 50 $FASTQ_DIR/2_4_L3_R1_001_ezH0ldTDxUdi.fastq.gz $FASTQ_DIR/2_4_L3_R2_001_5qJL43xGflsJ.fastq.gz
