#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10000M
#SBATCH --time=00:30:00
#SBATCH --job-name=polyA
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/erossini/output_polyA_%j.o
#SBATCH --error=/data/users/erossini/error_polyA_%j.o

#load module.
module add UHTS/Analysis/BEDTools/2.29.2

mkdir -p /data/users/erossini/PolyA

#enter the directory.
cd /data/users/erossini/PolyA

#create symbolic links with the input files needed.
ln -s /data/users/erossini/FANTOM/transcripts.gtf
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/Integrative_analysis/atlas.clusters.2.0.GRCh38.96.bed  .

#search for intersectio at polyA sites.
bedtools intersect -a transcripts.gtf -b atlas.clusters.2.0.GRCh38.96.bed
