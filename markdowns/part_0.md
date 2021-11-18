## Requirements and dataset explanation


You can clone the github to a local host and then:


- install the sotware
- download the databases
- download the experiment data


**NB1**: all command lines reported here have to be launched from the project main folder.


**NB2**: some commands are executed through slurm but can easily be moved to other schedulers - such as qsub.


---


### install the software


Most software can be installed via conda using ```conda env create -f yaml.main```.


Due to conflicts a specific environiment is necessary for expression analyses. Install it by ```conda env create -f yaml.DE``.


---


### download the databases 


While smaller databases are allready present in the repository,
large one can be downloaded using wget on the following links and redirecting them to the relative folders:


- sortmerna_dbs at ```https://github.com/biocore/sortmerna/tree/master/data/rRNA_databases``` and move all in ```dbs/sortmerna_db```
- pfam at ```ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz``` in ```dbs/pfam```
- swissprot at ```https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz``` in ```dbs/swissprot```
- uniref90 at ```https://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/uniref90.fasta.gz``` in ```dbs/uniref90```
- download nr BLAST database with ```for i in {1..55}; do wget https://ftp.ncbi.nlm.nih.gov/blast/db/nr.$i.tar.gz; tar -xf nr.$i.tar.gz; done```
- wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nr.gz
- ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.gz
- taxdump at ```ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz``` and ```tar -zxvf``` in ```dbs/taxdump```


Moreover, remember to ```makeblastdb -dbtype prot -in dbs/uniref90``` and ```makeblastdb -dbtype prot -in dbs/swissprot``, along with ```hmmpress dbs/Pfam-A.hmm```.


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


NB: databases were downloaded in November 2021.

---


### download the experiment data


Let's start by downlading the raw RNA-seq reads reads from SRA (only available after the paper is published) into the reads/crema_raw and and reads/vicia_raw folders.


vicia has accessions SRR15671599 - SRR15671608


crema has accessions SRR15728993 - SRR15729012


they can be downloaded using:


```for i in {15671599..15671608}; do fastq-dump --defline-seq '@$sn[_$rn]/$ri' --split-files reads/vicia_raw/SRR$i```


```for i in {15728993..15729012}; do fastq-dump --defline-seq '@$sn[_$rn]/$ri' --split-files reads/crema_raw/SRR$i```


Reference transcriptome assemblies are deposited on TSA with accession XXX and YYY respectively for vicia and crema.


---


### experimental design


This project revolves around the interaction between _Vicia faba_ and _Crematogaster scutellaris_, with two major aims:


1. charachterize in _Crematogaster scutellaris_ genes associated with feeding on _Vicia faba_ EFN in different tissues and timepoints.
2. understand wether we could identify in _Vicia faba_ any gene expression change associated to the interaction.


To do so we generated two RNA-seq experiments:


1. two different tissue (haead+thorax and abdomen) and four different conditions were considered for _Crematogaster scutellaris_:


**A**  -  never visited _Vicia faba_
**B**  -  visited by _Vicia faba_ only until 24h before experiment
**C**  -  visited by _Vicia faba_ only after 24h before experiment 
**D**  -  visited by _Vicia faba_ continuously


2. nectarium of _Vicia faba_ which:

**N**  -  were never visited by _Crematogaster scutellaris_
**Y**  -  2' after the visit of _Crematogaster scutellaris_


---


[main](https://github.com/for-giobbe/PAINT) / [next](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_1.md)
