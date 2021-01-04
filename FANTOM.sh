#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10000M
#SBATCH --time=00:30:00
#SBATCH --job-name=FANTOM
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/erossini/output_FANTOM_%j.o
#SBATCH --error=/data/users/erossini/error_FANTOM_%j.o

#load module.
module add UHTS/Analysis/BEDTools/2.29.2
module add Utility/UCSC-utils/359

#create directory.
mkdir -p /data/users/erossini/FANTOM

#enter the directory.
cd /data/users/erossini/FANTOM

#create symbolic links with the input files needed.
ln -s /data/users/erossini/StringTie/meta-assembly.gtf .
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/Integrative_analysis/hg19.cage_peak_phase1and2combined_coord.bed .

awk '$3=="transcript"' meta-assembly.gtf > transcripts.gtf

bedtools intersect -a transcripts.gtf -b hg19.cage_peak_phase1and2combined_coord.bed
