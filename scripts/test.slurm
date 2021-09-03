#!/bin/bash
#SBATCH -o /home/users/giobbe.forni/gen_red/paint/reads/vicia_ref/myjob.%j.%N.out
#SBATCH -D /home/users/giobbe.forni/gen_red/paint/reads/vicia_ref/
#SBATCH -J trim
#SBATCH --get-user-env
#SBATCH -p light
#SBATCH --nodes=1
#SBATCH -c 16                    # Number of cores per task
#SBATCH --mem-per-cpu 1000       #  Mem for each core
#SBATCH --time=2-00:00:00
#SBATCH --account=gen_red

module load Mlnx/hpcx

cd /home/users/giobbe.forni/gen_red/paint/reads/vicia_ref/

#trimmomatic PE VI_N_20_NP_1.fastq.gz VI_N_20_NP_2.fastq.gz VI_N_20_NP_trimmed_1P VI_N_20_NP_trimmed_1U VI_N_20_NP_trimmed_2P VI_N_20_NP_trimmed_2U ILLUMINACLIP:/gpfs/home/projects/gen_red/cartella/env/paint/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa:2:30:10:2 LEADING:3 TRAILING:3 MINLEN:36 -threads 16

trimmomatic PE VI_N_20_NP_1.fastq.gz VI_N_20_NP_2.fastq.gz VI_N_20_NP_trimmed_1P VI_N_20_NP_trimmed_1U VI_N_20_NP_trimmed_2P VI_N_20_NP_trimmed_2U ILLUMINACLIP:/gpfs/home/projects/gen_red/cartella/env/paint/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa:2:30:10:2:TRUE LEADING:3 TRAILING:3 MINLEN:36  -threads 16
