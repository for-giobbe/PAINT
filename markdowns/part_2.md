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
which is run with defeault parameters. Let's assemble using the lines:

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

and then we can exclude lowly expressed transcripts:

```filter_low_expr_transcripts.pl```

---

Then we need to identify contaminants and remove them from the abundance tables: 

---

We can then proceed to annotate the trascriptomes, using Transdecoder and leveraging both pfam and blast searches.

```
snakemake -s scripts/snakefile_annotate_cds --cluster 'sbatch --account=gen_red -p light -t 2800' --use-conda --cores 8 -p
```

---

[back](https://github.com/for-giobbe/PAINT) to main

