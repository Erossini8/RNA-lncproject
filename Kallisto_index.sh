#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10000M
#SBATCH --time=02:00:00
#SBATCH --job-name=Kallisto
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/home/erossini/output_%j.o
#SBATCH --error=/home/erossini/error_%j.o

#load modules for kallisto and gffread.
module add UHTS/Analysis/kallisto/0.46.0
module add UHTS/Assembler/cufflinks/2.2.1

#create a directory for results.
mkdir -p /data/users/erossini/Kallisto

#enter the directory.
cd /data/users/erossini/Kallisto

#create symbolic links for reference fasta genome and meta-assembly.
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/GRCh38.p13.genome.fa .
ln -s /data/users/erossini/StringTie/meta-assembly.gtf

#change the name of the reference for easier use.
mv GRCh38.p13.genome.fa GRCh38_genome.fa

#produce the fasta file of our assembly guided by the reference genome fasta.
gffread -w meta-assembly.fa -g GRCh38_genome.fa meta-assembly.gtf

#indexing of the meta-assembly.
kallisto index -i meta-assembly.idx meta-assembly.fa
