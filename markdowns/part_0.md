# Requirements and dataset explanation


*environiment:* yaml.main


*aim:* set up conda environiments / obtain large dbs / understand experimental design


---


Clone the github to a local host and then:


- install the sotware
- download the databases
- download the experiment data


**NB1**: all command lines reported here have to be launched from the project main folder.


**NB2**: some commands are executed through slurm but can easily be moved to other schedulers - such as qsub.


---


### install the software


Most software can be installed via conda using ```conda env create -f yaml.main```.


Due to conflicts specific environiments are necessary for expression analyses. They can be installed by: 


```
conda env create -f yaml.DE
conda env create -f yaml.WCGNA
conda env create -f yaml.enrichment
``` 


---


### download the databases 


While smaller databases are allready present in the repository,
large one can be downloaded using wget on the following links and redirecting them to the relative folders:


- sortmerna_dbs at ```https://github.com/biocore/sortmerna/tree/master/data/rRNA_databases``` and move all in ```dbs/sortmerna_db```
- pfam at ```ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz``` in ```dbs/pfam```
- swissprot at ```https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz``` in ```dbs/swissprot```
- uniref90 at ```https://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/uniref90.fasta.gz``` in ```dbs/uniref90```
- download nr BLAST database with ```for i in {1..55}; do wget https://ftp.ncbi.nlm.nih.gov/blast/db/nr.$i.tar.gz; tar -xf nr.$i.tar.gz; done```
- ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.gz
- taxdump at ```ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz``` and ```tar -zxvf``` in ```dbs/taxdump```


Moreover, remember to ```makeblastdb -dbtype prot -in dbs/uniref90``` and ```makeblastdb -dbtype prot -in dbs/swissprot```, along with ```hmmpress dbs/Pfam-A.hmm```.


Available Fabaceae and Formicidae assemblies for phylostratigrapy and rates analyses were retrieved using:


```
esearch -db assembly -query "Fabaceae" | esummary | xtract -pattern DocumentSummary 
-element AssemblyAccession -element AssemblyName -element SpeciesName > fabaceae_genomes.lst
```


and


```
esearch -db assembly -query "Formicidae" | esummary | xtract -pattern DocumentSummary
-element AssemblyAccession -element AssemblyName -element SpeciesName > formicidae_genomes.lst
```


Subsequently these lists were manually curated to remove assemblies of conspecifics or whick lack annotation.

 
Nucleotides CDS for the two families can be downloaded by ```sh download_fabaceae_cds.sh``` and ```sh download_formicidae_cds.sh```.


**NB:** databases were downloaded in November 2021.


---


### download the experiment data


Let's start by downlading the raw RNA-seq reads reads from SRA - only available after the paper is published!


All reads have been deposited under bioproject PRJNA758979 and can be downloaded using:


```
for i in $(grep "Crema" SRA_accession.tsv | awk '{print $1}'); do fastq-dump --defline-seq '@$sn[_$rn]/$ri' 
--split-files reads/vicia_raw/$i; done
```


```
for i in $(grep "Vicia" SRA_accession.tsv | awk '{print $1}'); do fastq-dump --defline-seq '@$sn[_$rn]/$ri' 
--split-files reads/vicia_raw/$i; done
```


Reference transcriptome assemblies are deposited on TSA with accession XXX and YYY respectively for vicia and crema.


---


### experimental design


This project revolves around the interaction between _Vicia faba_ and _Crematogaster scutellaris_, with two major aims:


1. charachterize in crema genes associated with feeding on vicia extra-floral nectar (EFN) in different tissues and timespans.
2. understand wether we could identify in vicia any gene expression change associated to the interaction.


To do so we generated two RNA-seq experiments:


1. two different tissue (haead+thorax and abdomen) and four different conditions were considered for crema:


**A**  -  never got in contact with vicia

**B**  -  got in contact with vicia only until 24h before experiment

**C**  -  got in contact with vicia only since 24h before experiment 

**D**  -  got in contact with vicia continuously


2. nectarium of vicia which:

**N**  -  never got in contact with crema

**Y**  -  2' after beeing visited by crema


---


[main](https://github.com/for-giobbe/PAINT) / 
[0](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_0.md) / 
[1](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_1.md) / 
[2](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_2.md) / 
[3](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_3.md) / 
[4](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_4.md) / 
[5](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_5.md) / 
[6](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_6.md)
