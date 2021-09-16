## Requirements and dataset explanation

You can clone the github to a local host and then 

- install the sotware
- download the databases
- download the experiment data

NB1: all command lines reported here have to be launched from the project main folder.

NB2: some commands are executed through slurm but can easily be moved to other scheduler such as qsub.

---

### software

All software can be installed via conda using ```conda env create -f paint.yml```. Here is the complete list:

- trimmomatic
- fastqc
- trinity
- DESeq2
- Orthofinder
- blast
- hmmscan
- transdecoder
- pyfasta
- taxonkit
- snakemake
- fastqdump

---

### databases 

Databases can be downloaded using wget on the following links and redirecting them to the relative folders:

- [sortmerna dbs](https://github.com/biocore/sortmerna/tree/master/data/rRNA_databases) in ```dbs/sortmerna/db```
- [pfam](ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz) in ```dbs/sortmerna/db```
- [uniref90](https://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/uniref90.fasta.gz) in ```dbs/sortmerna/db```

Moreover ```makeblastdb -dbtype prot -in uniprot_sprot.fasta``` and ```hmmpress Pfam-A.hmm```

---

### reads

Let's start by downlading the raw RNA-seq reads reads from SRA (only available after the paper is published) into the reads/crema_raw and and reads/vicia_raw folders.

Vicia has accessions SRR15671599 - SRR15671608
Crema has accessions SRR15728993 - SRR15729012

they can be downloaded using:

```for i in {15671599..15671608}; do fastq-dump --defline-seq '@$sn[_$rn]/$ri' --split-files reads/vicia_raw/SRR$i```

```for i in {15728993..15729012}; do fastq-dump --defline-seq '@$sn[_$rn]/$ri' --split-files reads/crema_raw/SRR$i```

### assemblies

Reference transcriptome assemblies are deposited on TSA with accession and respectively for vicia and crema.

---

### dataset explanation


---

[back](https://github.com/for-giobbe/PAINT) to main
