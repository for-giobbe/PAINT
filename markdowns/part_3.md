# Differential Expression in vicia


*environiment:* yaml.DE

*aim:* retrieve crema genes which undergo expression changes after short-term and long-term EFN feeding.


---


To begin we need to quantitate transcript abundance using the script ```slurm_abundances_vicia``` which uses bowtie and RSEM.


The outputs need to be then moved from the main folder to the appropriate one usings  ```mv _rep*  abundances/vicia```.


After that we can proceed to build expression matrices by:


```
abundance_estimates_to_matrix.pl --est_method RSEM
--gene_trans_map assemblies/vicia/vicia.Trinity.fasta.gene_trans_map --name_sample_by_basedir 
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


Now we need to remove possible contaminants from the gene-counts matrix which we will use for differential expression:


Initially the contaminants list needs to be formatted:

```
awk -F "_" 'NF{NF-=1};1' contaminants/vicia/vicia.blastp.contaminants_contigs.lst | 
sed 's/ /_/g' > contaminants/vicia/vicia.blastp.contaminants_genes.lst
```


and then a raw-counts matrix without them is generated:


```
grep -v -f contaminants/vicia/vicia.blastp.contaminants_genes.lst 
abundances/vicia/RSEM_vicia.gene.counts.matrix > abundances/vicia/RSEM_vicia.filtered.gene.counts.matrix
```


The DE is performed using DESeq2:


```
run_DE_analysis.pl --matrix abundances/vicia/RSEM_vicia.filtered.gene.counts.matrix 
--samples_file samples_vicia.txt --method DESeq2 --output abundances/vicia/vicia_deseq_gene/
```


The resulting outputs consist in:


```
RSEM_vicia.gene.counts.matrix.n_vs_v.DESeq2.DE_results
RSEM_vicia.gene.counts.matrix.n_vs_v.DESeq2.DE_results.MA_n_Volcano.pdf
RSEM_vicia.gene.counts.matrix.n_vs_v.DESeq2.Rscript
RSEM_vicia.gene.counts.matrix.n_vs_v.DESeq2.count_matrix
```


Then genes which are upregulated (padj < 0.05 & logFC > +1.5) and downregulated (padj < 0.05 & logFC > -1.5) 
in the plants which lived alongside crema - _versus_ those which never had any contact with crema - 
can be retrieved using:


```
Rscript scripts/DE_genes.Rscript 0.05 1.5 
abundances/vicia/vicia_deseq_gene/RSEM_vicia.filtered.gene.counts.matrix.n_vs_v.DESeq2.DE_results 
abundances/vicia/vicia_deseq_gene/vicia_UP_genes.lst  
abundances/vicia/vicia_deseq_gene/vicia_DN_genes.lst 
images/vicia_DE.jpg
```


The Rscript takes as inputs:


- the adjusted p value to cosider a gene DE
- the logFC  to cosider a gene downregulated or upregulated - _i.e._ if 1.5 -> +1.5 and -1.5
- the DESeq2 results table
- upregulated genes output file
- downregulated genes output file


A total of 500 DE genes are found - of which 279 are downregulated and 221 upregulated.


![Image description](https://github.com/for-giobbe/PAINT/blob/main/images/vicia_DE.jpg)


In this volcano plot the x-axis represent -log(padj) and the y-axis represent the LogFC.


NB - in the analysis DESeq2 contast is ```contrast=c("conditions","n","v")``` and thus
LogFc values are multiplied by -1 in the ```DE_genes.Rscript```.


Gene which are upregulated or downregulated in vicia when the association witch vrema is enstablished can be respectively found in: 


- ```abundances/vicia/vicia_deseq_gene/vicia_DN_genes.lst```
- ```abundances/vicia/vicia_deseq_gene/vicia_DN_genes.lst```


---


[main](https://github.com/for-giobbe/PAINT) / 
[0](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_0.md) / 
[1](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_1.md) / 
[2](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_2.md) / 
[3](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_3.md) / 
[4](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_4.md) / 
[5](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_5.md) / 
[6](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_6.md)
