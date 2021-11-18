# GO/KO annotation and enrichment analyses


---


environiment: yaml.main 


GO annotation has been carried out using [PANNZER](http://ekhidna2.biocenter.helsinki.fi/sanspanz/)
using no filtering and defeault parameters. 
PANNZER assigned 39826 and YYY GO-terms respectively to crema and vicia.


Subsequent enrichment analysis legerage [topGO](https://bioconductor.org/packages/release/bioc/html/topGO.html)
and for this purpose the PANNZER output needs to be reformatted using:


```
sh scripts/reformat_GOs.sh enrichment/GO_crema/GO_crema_predictions.lst enrichment/GO_crema/GO_crema_geneUniverse
```


and


```
sh scripts/reformat_GOs.sh enrichment/GO_vicia/GO_vicia_predictions.lst enrichment/GO_vicia/GO_vicia_geneUniverse
```


The the GO enrichment analysisis is performed using the following commands:

```
Rscript scripts/GO_enrichment.Rscript GO_crema_geneUniverse_BP . BP 5 weight fisher 0.05
```


and


```
Rscript scripts/GO_enrichment.Rscript GO_crema_geneUniverse_BP . BP 5 weight fisher 0.05
```


The Rscript has several positional arguments:


1. the gene universe
2. the input folder containing the genes subsets considered
3. the onyology considered (BP/MF/CC)
4. the minimum node size
5. the algorythm
6. the statistical test
7. the p value cutoff


For this project, a hierachy-aware algoryhm (weight) was used to find enriched BP terms 
and nodes are required to have at least 5 genes associated to be 
included. Terms are considered to be enriched only if p < 0.05
in Fisher's Exact Test.


---


KO annotation has been carried out using [BlastKOALA](https://www.kegg.jp/blastkoala/)
leveraging the correct Taxonomy ID and the family_eukaryotes database.
BlastKOALA assigned XXX and YYY KO-terms respectively to crema and vicia.


Subsequent enrichment analysis legeraged [KEGGREST](https://www.bioconductor.org/packages/release/bioc/html/KEGGREST.html)


---


[prev](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_4.md) / [main](https://github.com/for-giobbe/PAINT) / [next](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_6.md)

