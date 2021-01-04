#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=05:00:00
#SBATCH --job-name=mergeBAMer
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/home/erossini/output_%j.o
#SBATCH --error=/home/erossini/error_%j.o


#this script was used in order to obtain one single BAM for every sample.
#load module to work with the BAM files.
module add UHTS/Analysis/samtools/1.10

#create a directory for the merged BAM.
mkdir -p /data/users/erossini/mergedBAM

#enter the directory.
cd /data/users/erossini/mergedBAM

#create symbolic links for all the sorted BAM files generated with HISAT2.
ln -s /data/users/erossini/Hisat2/sample1_dta/Replicate_1_1.sorted.bam
ln -s /data/users/erossini/Hisat2/sample1_dta/Replicate_1_2.sorted.bam
ln -s /data/users/erossini/Hisat2/sample1_dta/Replicate_1_5.sorted.bam

ln -s /data/users/erossini/Hisat2/sample2_dta/Replicate_2_2.sorted.bam
ln -s /data/users/erossini/Hisat2/sample2_dta/Replicate_2_3.sorted.bam
ln -s /data/users/erossini/Hisat2/sample2_dta/Replicate_2_4.sorted.bam

ln -s /data/users/erossini/Hisat2/sample3_dta/Replicate_3_2.sorted.bam
ln -s /data/users/erossini/Hisat2/sample3_dta/Replicate_3_4.sorted.bam
ln -s /data/users/erossini/Hisat2/sample3_dta/Replicate_3_7.sorted.bam

ln -s /data/users/erossini/Hisat2/sampleP_dta/Replicate_P1.sorted.bam
ln -s /data/users/erossini/Hisat2/sampleP_dta/Replicate_P2.sorted.bam
ln -s /data/users/erossini/Hisat2/sampleP_dta/Replicate_P3.sorted.bam

#merge all the replicate BAM files into single sample BAM files.
samtools merge sample1.merged.bam Replicate_1_1.sorted.bam Replicate_1_2.sorted.bam Replicate_1_5.sorted.bam
samtools merge sample2.merged.bam Replicate_2_2.sorted.bam Replicate_2_3.sorted.bam Replicate_2_4.sorted.bam
samtools merge sample3.merged.bam Replicate_3_2.sorted.bam Replicate_3_4.sorted.bam Replicate_3_7.sorted.bam
samtools merge sampleP.merged.bam Replicate_P1.sorted.bam Replicate_P2.sorted.bam Replicate_P3.sorted.bam
