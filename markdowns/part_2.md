# trascriptomes assembly & filtering


*environiment:* yaml.DE


*aim:* assemble crema and vicia trascriptomes / annotate CDS / filter contaminats contigs / QC the assembly.


---


environiment: yaml.main


the rationale here is to carry out the assembly using the reads filtered for rRNAs, mtRNA and ptRNA and then 
find possible additional contaminants (virus, bacteria, _etc_) in order to subsequently exclude them from abundance tables,
Through this approach - suggested [here](https://groups.google.com/g/trinityrnaseq-users/c/P2Ry72h_puQ/m/LpJ8OLzuBAAJ) by Brian Haas - 
we mimize the possibility of reads misalignment while removing possible contaminants from the differential expression step.


---


As there is no crema genomes and the vicia one appears to be highly fragmented draft genome, we opted for a genome-free de novo transcriptome assembly,
as suggested [here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Genome-Guided-Trinity-Transcriptome-Assembly).


To assemble crema and vicia we have to input the preprocessed reads to Trinity,
which is run with defeault parameters. 


Let's assemble using the filtered reads with the lines:


```
sbatch scripts/slurm_assemble_crema
```


and 


```
sbatch scripts/slurm_assemble_vicia
```


PS: i had to modify ```SuperTranscripts/Trinity_gene_splice_modeler.py``` using ```#!/usr/bin/env python3.4```


---


Aseemblies were initially inspected using:


```
TrinityStats.pl assemblies/crema/crema.Trinity.fasta
```


which returns:


```
################################
## Counts of transcripts, etc.
################################
Total trinity 'genes':	128075
Total trinity transcripts:	222112
Percent GC: 39.96

########################################
Stats based on ALL transcript contigs:
########################################

	Contig N10: 11723
	Contig N20: 8688
	Contig N30: 6871
	Contig N40: 5534
	Contig N50: 4475

	Median contig length: 521
	Average contig: 1626.23
	Total assembled bases: 361205039


#####################################################
## Stats based on ONLY LONGEST ISOFORM per 'GENE':
#####################################################

	Contig N10: 8783
	Contig N20: 5870
	Contig N30: 4058
	Contig N40: 2551
	Contig N50: 1504

	Median contig length: 368
	Average contig: 789.89
	Total assembled bases: 101165185
```


and


```
TrinityStats.pl assemblies/vicia/vicia.Trinity.fasta
```


which returns:


```
################################
## Counts of transcripts, etc.
################################
Total trinity 'genes':	126565
Total trinity transcripts:	214540
Percent GC: 38.88

########################################
Stats based on ALL transcript contigs:
########################################

	Contig N10: 3651
	Contig N20: 2698
	Contig N30: 2125
	Contig N40: 1699
	Contig N50: 1321

	Median contig length: 445
	Average contig: 792.42
	Total assembled bases: 170005431


#####################################################
## Stats based on ONLY LONGEST ISOFORM per 'GENE':
#####################################################

	Contig N10: 3318
	Contig N20: 2393
	Contig N30: 1862
	Contig N40: 1409
	Contig N50: 1010

	Median contig length: 355
	Average contig: 644.21
	Total assembled bases: 81534436
```


Transcriptomes completeness was asessed also uning [gVolante](https://gvolante.riken.jp/analysis.html) online BUSCO implementation. 
Assemblies were processes as transcribed nucletoides respectively with BUSCO_v5 Hymenoptera and Fabales ortholog sets.


Crema results: 


```
C:97.1%[S:39.0%,D:58.1%],F:1.3%,M:1.6%

Number of sequences	222112
Total length (nt)	361205039
Longest sequence (nt)	53522
Shortest sequence (nt)	178
Mean sequence length (nt)	1626
Median sequence length (nt)	521
N50 sequence length (nt)	4475
L50 sequence count	23798
Number of sequences > 1K (nt)	75996 (34.2% of total number)
Number of sequences > 10K (nt)	4039 (1.8% of total number)
Number of sequences > 100K (nt)	0 (0.0% of total number)
Number of sequences > 1M (nt)	0 (0.0% of total number)
Number of sequences > 10M (nt)	0 (0.0% of total number)
Base composition (%)	A: 30.00
T: 30.04
G: 19.93
C: 20.03
N: 0.00
Other: 0.00
Number of gaps (>=5 N's)	
GC-content (%)	39.96
Number of non-ACGTN (nt)	0
```


Vicia results:


```
C:88.7%[S:46.9%,D:41.8%],F:1.9%,M:9.4%

Number of sequences	214540
Total length (nt)	170005431
Longest sequence (nt)	19074
Shortest sequence (nt)	179
Mean sequence length (nt)	792
Median sequence length (nt)	445
N50 sequence length (nt)	1321
L50 sequence count	36485
Number of sequences > 1K (nt)	50377 (23.5% of total number)
Number of sequences > 10K (nt)	40 (0.0% of total number)
Number of sequences > 100K (nt)	0 (0.0% of total number)
Number of sequences > 1M (nt)	0 (0.0% of total number)
Number of sequences > 10M (nt)	0 (0.0% of total number)
Base composition (%)	A: 30.54
T: 30.58
G: 19.23
C: 19.65
N: 0.00
Other: 0.00
Number of gaps (>=5 N's)
GC-content (%)	38.88
Number of non-ACGTN (nt)	0
```


As we can seee, the scores are rather high! There are quite a lot of multi-copy orthologs 
but it is somehow expected as we have kept all lowly expressed genes and multiple isoforms.
NB: vicia seem to have a lower transcript length compared to crema, 
but this does not seem to derive from a fragmente assembly as BUSCO partial genes are just 1.9%!


---


Transcriptome annotation is then carried out usins [Transdecoder](https://github.com/TransDecoder/TransDecoder/wiki) and:


- considering just the longest isoform per gene
- integrating homology searches as CDS retention criteria (Pfam and SwissProt)


Vicia trascriptome can be annotated using:


```
snakemake -s scripts/snakefile_annotate_cds_vicia --cluster 'sbatch --account=gen_red -p light -t 2800' 
--use-conda --cores 8 -p
```


Crema trascriptome can be annotated using:


```
snakemake -s scripts/snakefile_annotate_cds_crema --cluster 'sbatch --account=gen_red -p light -t 2800'
--use-conda --cores 8 -p
```


Both analyses will return a number of files:


```
...Trinity.fasta.transdecoder.bed
...Trinity.fasta.transdecoder.cds
...Trinity.fasta.transdecoder.gff3
....Trinity.fasta.transdecoder.pep
```


which we can move to their place by```mv crema.Trinity.fasta.transdecoder.* annotations/crema/``` and  ```mv vicia.Trinity.fasta.transdecoder.* annotations/vicia```.


---


Then contaminant contigs are identified.
In this step proteomes undergo homology serches against UniRef90 - which differently from UniProt includes taxonomy - and reurn all hits taxa ids.
The homology search is performed using blastp-fast and an evalue of 1e-7 with the parameters ```-max_target_seqs 50 -max_hsps 1``` to fasten the process.
Subsequently [Taxonkit](https://bioinf.shenwei.me/taxonkit/) will exctract each hit full lineage and
flag as contaminants all contigs which don not have at least 80% of the hits 
as metazoa or viridiplantae respectively for crema and vicia.


The commands are:


```
snakemake -s scripts/snakefile_filter_contaminants_transcripts_crema --cluster 'sbatch --account=gen_red 
-p light -t 2800' --use-conda --cores 8 -p
```


and


```
snakemake -s scripts/snakefile_filter_contaminants_transcripts_vicia --cluster 'sbatch --account=gen_red 
-p light -t 2800' --use-conda --cores 8 -p
```


then we can extract contaminants contigs using the following line to cross check them in online blast:


```
for i in $( cat contaminants/crema/crema.blastp.contaminants_contigs.lst); do 
sed -n -e "/$i/,/TRINITY/ p" contaminants/crema/crema.Trinity.fasta.transdecoder.pep | 
head -n -1 | awk '{print $1}'; done
```


As we can see, contaminant contigs are <10% - 821 contigs fro crema and 947 contigs for vicia.
This is expected, as a small amount of reads can generate a lot of contaminants contigs.
In our case this step is rather important to remve vicia contigs from crema assembly:
the species is too small to dissect the digestive tract and as such some plant material was most likely present
in the sample. 
Having identified contaminat contgis we will still map reads on them - to minimyze possible misalignments -
but remove them from counts tables down the line.


---


[main](https://github.com/for-giobbe/PAINT) / 
[0](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_0.md) / 
[1](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_1.md) / 
[2](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_2.md) / 
[3](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_3.md) / 
[4](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_4.md) / 
[5](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_5.md) / 
[6](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_6.md)
