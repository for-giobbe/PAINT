# trascriptomes assembly & filtering

---

the rationale here is to carry out the assembly using the filtered reads and then 
find possible contaminants (virus, bacteria, _etc_) in order to subsequentlyexclude them from abundance tables,
Through this approach - suggested [here](https://groups.google.com/g/trinityrnaseq-users/c/P2Ry72h_puQ/m/LpJ8OLzuBAAJ) by Brian Haas - 
we mimize the possibility of reads misalignment while removing possible contaminats from the differential expression step.

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

Aseemplies were initially inspected using:

```TrinityStats.pl assemblies/crema/crema.Trinity.fasta```

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

```TrinityStats.pl assemblies/vicia/vicia.Trinity.fasta ```

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

We can collapse isoforms - as we are going to carry out gene-level DE analyses - using:

```
snakemake -s scripts/snakefile_annotate_cds --cluster 'sbatch --account=gen_red -p light -t 2800' --use-conda --cores 8 -p
```

Then contamint contigs are identified using:

```
```

As we can see this is a quite low number of contaminat contigs - which we will anyway remove from count tables down the line.

---

[back](https://github.com/for-giobbe/PAINT) to main

