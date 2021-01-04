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
mkdir -p /data/users/erossini/Hisat2/sample2_dta

#enter the directory and create a symbolic link with the reference file.
cd /data/users/erossini/Hisat2/sample2_dta
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/grch38 .

#perform alignment of the reads to the reference genome with HISAT2 software.
hisat2 --dta -x grch38/genome -1 $FASTQ_DIR/2_2_L3_R1_001_77KSDZXkzpN2.fastq.gz -2 $FASTQ_DIR/2_2_L3_R2_001_2oenLbeyyPvS.fastq.gz -S Replicate_2_2.sam
samtools view -b Replicate_2_2.sam > Replicate_2_2.bam
samtools sort Replicate_2_2.bam -o Replicate_2_2.sorted.bam

hisat2 --dta -x grch38/genome -1 $FASTQ_DIR/2_3_L3_R1_001_DZmuiRvA53zD.fastq.gz -2 $FASTQ_DIR/2_3_L3_R2_001_bW28atsMceL2.fastq.gz -S Replicate_2_3.sam
samtools view -b Replicate_2_3.sam > Replicate_2_3.bam
samtools sort Replicate_2_3.bam -o Replicate_2_3.sorted.bam

hisat2 --dta -x grch38/genome -1 $FASTQ_DIR/2_4_L3_R1_001_ezH0ldTDxUdi.fastq.gz -2 $FASTQ_DIR/2_4_L3_R2_001_5qJL43xGflsJ.fastq.gz -S Replicate_2_4.sam
samtools view -b Replicate_2_4.sam > Replicate_2_4.bam
samtools sort Replicate_2_4.bam -o Replicate_2_4.sorted.bam
