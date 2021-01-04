#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10000M
#SBATCH --time=05:00:00
#SBATCH --job-name=sleuth
#SBATCH --mail-user=elia.rossini@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/erossini/output_sleuth_%j.o
#SBATCH --error=/data/users/erossini/error_sleuth_%j.o

#add the R module in order to run the R script: Sleuth.R
module add R/3.6.1

#Done on command line in order to have a cleaner directory for Kallisto results:
#cd /data/users/erossini/Kallisto
#mkdir -p Results
#mv Replicate* Results

#create a directory for Sleuth results
mkdir -p /data/users/erossini/Sleuth

#enter the directory.
cd /data/users/erossini/Sleuth

#copy the script in the directory.
cp /data/users/erossini/Scripts/Sleuth.R .

#execute the R script for Sleuth analyses.
Rscript Sleuth.R
