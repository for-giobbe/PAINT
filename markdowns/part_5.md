# GO/KO annotation and enrichment analyses


---

GO annotation has been carried out using [PANNZER](http://ekhidna2.biocenter.helsinki.fi/sanspanz/)
using no filtering and defeault parameters. 
PANNZER assigned XXX and YYY GO-terms respectively to crema and vicia.


Subsequent enrichment analysis legeraged [topGO](https://bioconductor.org/packages/release/bioc/html/topGO.html)
using the Rscript ``` ```. It leverages a hierachy-aware algoryhm (weight01) with DE genes considered only if p < 0.01
in Fisher's Exact Test.


---


KO annotation has been carried out using [BlastKOALA](https://www.kegg.jp/blastkoala/)
leveraging the correct Taxonomy ID and the family_eukaryotes database.
BlastKOALA assigned XXX and YYY KO-terms respectively to crema and vicia.

Subsequent enrichment analysis legeraged [KEGGREST](https://www.bioconductor.org/packages/release/bioc/html/KEGGREST.html)

---


[prev](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_4.md) / [main](https://github.com/for-giobbe/PAINT) / [next](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_6.md)

