## dataset explanation and requirements

You can clone the github to a local host and then (1) install the sotware (2) install the databases (2) download the experiment data

---

## software

All software can be installed via conda using ```conda env export > paint.yml```. Here is the complete list:

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

## databases 

Databases can be downloaded using wget on the following links and redirecting them to the relative folders:

- [sortmerna dbs](https://github.com/biocore/sortmerna/tree/master/data/rRNA_databases) in dbs/sortmerna/db
- [pfam](ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz)in dbs/sortmerna/db
- [uniref90](https://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/uniref90.fasta.gz)in dbs/sortmerna/db

---

## reads

Let's start by downlading the raw RNA-seq reads reads from SRA (only available after the paper is published) into the reads/crema_raw and and reads/vicia_raw folders.

Vicia has accessions SRR15671599 - SRR15671608
Crema has accessions

they can be downloaded using:

```for i in {15671599..15671608}; do fastq-dump --defline-seq '@$sn[_$rn]/$ri' --split-files reads/vicia_raw/SRR$i```

```for i in {..}; do fastq-dump --defline-seq '@$sn[_$rn]/$ri' --split-files reads/crema_raw/SRR$i```

## assemblies
