## gene Differential Expression analysis in Vicia

In this step we will carry out qc of the two species RNA-seq libraries and preprocess them.

---

To begin we need to quantitate transcript abundance using the script ```slurm_abundances_vicia``` which uses bowtie and RSEM.


After that we can proceed to build expression matrices by:

```
abundance_estimates_to_matrix.pl --est_method RSEM  --gene_trans_map assemblies/vicia/vicia.Trinity.fasta.gene_trans_map 
--name_sample_by_basedir 
abundances/vicia/v_rep1/RSEM.isoforms.results 
abundances/vicia/v_rep2/RSEM.isoforms.results 
abundances/vicia/v_rep3/RSEM.isoforms.results 
abundances/vicia/v_rep4/RSEM.isoforms.results 
abundances/vicia/v_rep5/RSEM.isoforms.results 
abundances/vicia/n_rep1/RSEM.isoforms.results 
abundances/vicia/n_rep2/RSEM.isoforms.results 
abundances/vicia/n_rep3/RSEM.isoforms.results 
abundances/vicia/n_rep4/RSEM.isoforms.results 
abundances/vicia/n_rep5/RSEM.isoforms.results 
--out_prefix RSEM_vicia
```

after moving the outputs to the right place with ```mv RSEM_vicia.* abundances/vicia/``` we can take a look at the outputs:

```
RSEM_vicia.gene.TMM.EXPR.matrix
RSEM_vicia.gene.TPM.not_cross_norm
RSEM_vicia.gene.TPM.not_cross_norm.TMM_info.txt
RSEM_vicia.gene.TPM.not_cross_norm.runTMM.R
RSEM_vicia.gene.counts.matrix
RSEM_vicia.isoform.TMM.EXPR.matrix
RSEM_vicia.isoform.TPM.not_cross_norm
RSEM_vicia.isoform.TPM.not_cross_norm.TMM_info.txt
RSEM_vicia.isoform.TPM.not_cross_norm.runTMM.R
RSEM_vicia.isoform.counts.matrix
```


---

[back](https://github.com/for-giobbe/PAINT) to main
