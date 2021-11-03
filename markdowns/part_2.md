# trascriptome assembly & filtering

---

the rationale here is that
we assembled and mapped reads on every transcripts - but then excluded those of contaminants origin from abundance tables,
so that	they won't mess	up with	downstream gene expression analyses. Yet through this approach we
minimized the possibility of reads misalignment.

---

As there is no crema genomes and the vicia one appears to be highly fragmented draft genome, we opted for a genome-free de novo transcriptome assembly,
as suggested [here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Genome-Guided-Trinity-Transcriptome-Assembly).


To assemble crema and vicia we have to input the preprocessed reads to Trinity,
which is run with defeault parameters. 

Let's assemble using the lines:

```
sbatch scripts/slurm_assemble_crema
```

and 

```
sbatch scripts/slurm_assemble_vicia
```

PS: i had to modify ```SuperTranscripts/Trinity_gene_splice_modeler.py``` using ```#!/usr/bin/env python3.4```

---

We can then proceed to map reads on the raw assemblies with the scripts:

```scripts/slurm_abundances_vicia``` and ```scripts/slurm_abundances_crema```

---

We assesed transcriptomes completeness uning gVolante online BUSCO implementation. Assemblies were processes as transcribed nucletoides respectively with BUSCO_v5 Hymenoptera and Fabales ortholog sets.


Vicia reults: 

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

As we can seee, the scores are rather high! There are quite a lot of multi-copy orthologs but it is somehow expected as we have kept all lowly expressed genes and multiple isoforms.

---

[back](https://github.com/for-giobbe/PAINT) to main

