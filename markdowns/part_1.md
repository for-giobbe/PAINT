## reads qc & preprocessing

In this step we will carry out qc of the two species RNA-seq libraries and preprocess them.

---

Let's start by renaming the RNA-seq libraries from how they are downloaded from the SRA to some more convenient names.

Use the lines ```sh scripts/rename_vicia_SRA.sh reads/vicia_raw``` and ```sh scripts/rename_crema_SRA.sh reads/crema_raw```, respectively.

NB: to rename reads from how they were received from the sequencing facilities use ```sh scripts/rename_vicia.sh reads/vicia_raw``` and ```sh scripts/rename_crema.sh reads/crema_raw``` can be used.

After the initial conversion, libraries filenames are organized in 4 relevant underscore-separated fields:

        1st filed	species
        2nd field	condition
        3rd field	sample id number
        4th field	tissue

For Vicia sp:

        1st	VI for Vicia
        2nd	N for "never visited" / V for "visited"
        3rd	sample id number
        4th	NP for "nectarium plantae"

for Crematogaster sp:

        1st     CR for Crematogaster
        2nd     A for "lt:N; st:N" / B for "lt:N; st:Y" / C for "lt:Y; st:N" / D for "lt:Y; st:Y"
        3rd     sample id number
        4th     AD for "abdomen" / CT for "head and thorax"

To check samples:

```ll reads/crema_ref/ | awk '{print $9}' |  awk -F "_" '{print $1"_"$2"_"$3"_"$4}' | sort -u ```

```ll reads/crema_ref/ | awk '{print $9}' |  awk -F "_" '{print $1"_"$2"_"$3"_"$4}' | sort -u ```

---

Next step is to execute the snakefiles for thq qc, which will carry out:

- adapter removal / reads trimming [trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)

- quality check [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

```snakemake -s scripts/snakefile_qc_reads_vicia --profile slurm --use-conda --cores 16 --profile slurm```

```snakemake -s scripts/snakefile_qc_reads_crema --profile slurm --use-conda --cores 16 --profile slurm```

Trimming has been carried out using a very gentle trimming of PHRED > 5 as indicated [here](https://doi.org/10.3389/fgene.2014.00013) but
setting a high treshold for the minimum length of 99 read length. Trimmomatic has been set with the parmeters:
TruSeq3-PE.fa:2:30:10:2:TRUE SLIDINGWINDOW:5:30 LEADING:5 TRAILING:5 MINLEN:99.

The post-trimming qc looks generally fine but there seem to be some rRNAs/mtDNA/ptDNA contaminations, as suggested by the multiple GC peaks:
they potentially could also derive from other contaminants, but the overepresented sequences from fastQC are all derived from rRNAs, mtDNA and ptDNA.

---

We need to properly preprocess the reads by removing rRNAs:

Let's start by building a database of undesired sequences, which include:

- rfam (5S, 5.8s)
- silva (16s, 23s, 18s, 28s)
- partial rRNA sequences of Vicia genus (which are exluced from rRNA dbs)
- vicia plastid and mitochondrion
- crema (congeneric) mitochondrion
- closely related hymenopteran mitochondria

Use the line:

``` 
mkdir dbs/filter;
cat dbs/sortmerna_db/* dbs/vicia_*/* dbs/crema_tera_mtgen/* dbs/hymn_mtgen/* >> dbs/filter/filter.fasta; 
bowtie2-build dbs/filter/filter.fasta dbs/filter/filter
```

Let's execute the snakefile which will generate the filtered reads and qc them. 

```
snakemake -s scripts/snakefile_preprocessing_reads_vicia --profile slurm --use-conda --cores 16 --profile slurm
```

```
snakemake -s scripts/snakefile_preprocessing_reads_crema --profile slurm --use-conda --cores 16 --profile slurm
```

In vicia cleaned libraries range from 54.8M to 28.2M read pairs but this should'nt be a problem because it is commonly accepted that normalization will
properly account for library differences of 2X _circa_.
Moreover we we can see now there is a single GC peak, implying that rRNAs were the major source of contamination and that we managed to succesfully remove those!
I think this is the correct approach, as it rapresents a non-biological signal which - if removed - won't bias downstream expression analyses.
In crema cleaned libraries are much less variable in size and range from 29.4M to 27.0M read pairs. 

The fastqc files can be found [here](https://github.com/for-giobbe/PAINT/tree/main/reads/crema_ref) and [here](https://github.com/for-giobbe/PAINT/tree/main/reads/vicia_ref)

---

[prev](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_0.md) / [main](https://github.com/for-giobbe/PAINT) / [next](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_2.md)
