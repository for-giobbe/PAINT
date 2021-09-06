# trascriptome assembly, annotation & filtering

---

To assemble crema trascriptome we can jus use the raw reads using Trinity and specifying the same Trimmomatic parameters
we used in the qc step. To assemble vicia insted we have to use the preprocessed reads and skip the Trimmomatic step within Trinity.
Trinity is run with defeault parameters. Let's assemble using the lines

```
sbatch scripts/slurm_assemble_crema
```

and 

```
sbatch scripts/slurm_assemble_crema
```
