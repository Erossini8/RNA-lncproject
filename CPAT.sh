#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10000M
#SBATCH --time=05:00:00
#SBATCH --job-name=CPAT
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/erossini/output_CPAT_%j.o
#SBATCH --error=/data/users/erossini/error_CPAT_%j.o

module add SequenceAnalysis/GenePrediction/cpat/1.2.4
module add R/3.6.1

mkdir -p /data/users/erossini/CPATresults

cd /data/users/erossini/CPATresults

ln -s /data/users/erossini/Kallisto/meta-assembly.fa
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/Integrative_analysis/Human_Hexamer.tsv
ln -s /data/courses/rnaseq/lncRNAs/Project2/reference-files/Integrative_analysis/Human_logitModel.RData

cpat.py -g meta-assembly.fa -d Human_logitModel.RData -x Human_Hexamer.tsv -o CPAT_output.txt

#Done locally to see percentage of protein coding novel trascripts:
#awk '/MSTRG/' CPAT_output.txt > novel_CPAT.txt
#awk '/MSTRG/' novel_CPAT.txt | wc -l
#A total of 63 transcripts, of them only 6 had more than 0.7 coding probability.
#With this threshold, only 9.5 % of the novel transcripts were possible protein coding.
