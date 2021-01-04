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

#create and go to the directory for the Sample2 quality control results.
mkdir -p /data/users/erossini/QCresults/Sample2
cd /data/users/erossini/QCresults/Sample2

#create symbolic link for each replicate of the second sample.
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/2_2_L3_R1_001_77KSDZXkzpN2.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/2_2_L3_R2_001_2oenLbeyyPvS.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/2_3_L3_R1_001_DZmuiRvA53zD.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/2_3_L3_R2_001_bW28atsMceL2.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/2_4_L3_R1_001_ezH0ldTDxUdi.fastq.gz
ln -s /data/courses/rnaseq/lncRNAs/Project2/fastq/2_4_L3_R2_001_5qJL43xGflsJ.fastq.gz

#check the quality of the reads using fastqc. Each replicate is analysed separately.
fastqc -t 6 *.fastq.gz

#multiqc is used to produce a single file for Sample2 quality control.
multiqc .
