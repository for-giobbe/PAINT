# trascriptome assembly, annotation & filtering

---

As there is no crema genomes and the vicia one appears to be highly fragmented draft genome, we opted for a genome-free de novo transcriptome assembly.

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

We can then proceed to annotate the trascriptomes, using Transdecoder and leveraging both pfam and blast searches.

```
snakemake -s scripts/snakefile_annotate_cds --cluster 'sbatch --account=gen_red -p light -t 2800' --use-conda --cores 8 -p
```

---

[back](https://github.com/for-giobbe/PAINT) to main

