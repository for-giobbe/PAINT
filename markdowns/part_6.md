# phylogenetic analyses


*environiment:* yaml.WGCNA / yaml.rates


*aim:* gain evolutionary insight on the genes associated to crema-vicia interactions, using phylogenetic and molecular evolution approaches.


---


To charachterize the p450 genes which present transcriptional differences in the ant following plant association, 
we initially gathered them relying on eggNOG-mapper and transdecoder annotations:


```
grep p450 enrichment/eggNOG_crema/crema_eggNOG-mapper_annotations.tsv | awk '{print $1}' | tr -d ">" > comparative_genomics/crema_p450/p450_eggNOG-mapper.lst
grep p450 annotations/crema/crema.Trinity.fasta.transdecoder.pep | awk '{print $1}' | tr -d ">" > comparative_genomics/crema_p450/p450_transdecoder.lst
```


and


```
for i in $(cat comparative_genomics/crema_p450/p450_eggNOG-mapper.lst comparative_genomics/crema_p450/p450_transdecoder.lst | sort -u); 
do 
sed -n -e "/$i/,/TRINITY/ p" annotations/crema/crema.Trinity.fasta.transdecoder.pep | head -n -1 | awk '{print $1}'; 
done > comparative_genomics/crema_p450/Crematogaster_scutellaris_p450.fa
```

Then all p450 protein sequences relative to the species _Apis mellifera_ and _Themnotorax curvispinusus_ were collected:


After merging them with crema p450s, the alignement has been carried out using mafft-gisni:


```
ginsi p450.fa > p450.aln
```


The alignment was then cleaned using timal:


```
trimal -in p450.aln -out p450_trim1.aln -gt 0.9 -cons 20
trimal -in p450_trim1.aln -out p450_trim2.aln -resoverlap 0.6 -seqoverlap 60
```


The filogenetic inference was perfromed using iqtree2:


```
iqtree2 -s p450_trim2.aln -B 1000 -T AUTO -m MFP -pers 0.2 -nstop 1000 -allnni -redo
```


The tree has to be slightly reformatted (removing the isoform notation) to be fed to following steps:

```
sed -i "s/_i[0-9]\.p[0-9]//g" comparative_genomics/crema_p450/p450_trim2.aln.treefile
```


Crema p450  expression file has been generate with the following code:


```
sh scripts/extract_exp_val_crema_treatm_contrast.sh
comparative_genomics/crema_p450/p450_Crematogaster_scutellaris.lst 
> comparative_genomics/crema_p450/p450_Crematogaster_scutellaris_exppression.tsv
```


Then R was used:


```
Rscript scripts/plot_crema_phy+exp.Rscript 
comparative_genomics/crema_p450/p450_trim2.aln.treefile 
comparative_genomics/crema_p450/annotation.tsv 
comparative_genomics/crema_p450/p450_Crematogaster_scutellaris_exppression.tsv 
0.01 0 comparative_genomics/crema_p450/p450.pdf
```

The arguments of this script are:

- a nwk tree file
- a tsv file for tip annotation (columns are: tip name, gene name, species)
- an expression table for crema genes 
- a p treshold for the differential expression to be plotted
- a logFC treshold for the differential expression to be plotted
- the name of the output figure


And here is the result:


![Image description](https://github.com/for-giobbe/PAINT/blob/main/comparative_genomics/crema_p450/p450.jpg)


NB: we flipped the contrast so that genes which are upregolated in the "treatments" have positive logFC.


As we can see, p450s expression profile are charachterized by a large number of changes, but with modest intensity.


---


Here is an overview of the strata considered; in the figures anything above Eudicots and Hymenoptera
has been considered as "old". Of course the limitation (both technical and conceptual) of phylostratigrapy
are many, but they will not be discussed here. Just a disclaimer:
while the strata are the same number for crema and vicia, they can not obviously be compared.


sp / Myrmicinae / Formicoidea / Hymenoptera / Holometabola / Neoptera / Paleoptera


sp / Papilionoideae / Fabales / Rosids / Eudicots / Angiosperms / Spermatophyte



| stratum 1 | stratum 2      | stratum 3   | stratum 4   | stratum 5    | stratum 6   | stratum 7     |
|-----------|----------------|-------------|-------------|--------------|-------------|---------------|
| sp        | Myrmicinae     | Formicoidea | Hymenoptera | Holometabola | Neoptera    | Paleoptera    |


| stratum 1 | stratum 2      | stratum 3   | stratum 4   | stratum 5    | stratum 6   | stratum 7     |
|-----------|----------------|-------------|-------------|--------------|-------------|---------------|
| sp        | Papilionoideae | Fabales     | Rosids      | Eudicots     | Angiosperms | Spermatophyte |


---


For Crema we start by downloading a rapresentative set of insects cds.


```
for i in $(cat cds_insect.lst | awk -F "\t" '{print $4"%"$5}'); 
do 
wgt=$(echo $i | awk -F "%" '{print $1}'); 
cds=$(echo $i | awk -F "%" '{print $2}'); 
wget -O comparative_genomics/crema/$cds.fa.gz $wgt; 
done;
```


Then after ```gunzip *``` we can reformat everything using:


```
for i in G*; do awk '{print $1}' $i | sed "s/lcl|/${i::-5}-/g" > ${i::-5}.ref.fa; done
```


We then need to reformat crema cds:


```
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' crema.Trinity.fasta.transdecoder.cds | awk '{print $1}' | sed "s/>/>crema-/g" > crema.fa
```


And we also need to remove the contaminants we previously found:


```
grep -v -A 1 -f ../../contaminants/crema/crema.blastp.contaminants_genes.lst crema.fa > crema.ref.fa
```


After ```rm crema.Trinity.fasta.transdecoder.cds crema.fa``` we can translate everything into amminoacids using:


```
for i in *fa; do transeq -sequence $i -outseq ${i::-7}.aa.ref.fa; done
```


Then, after having sorted amminoacids and nucleotides in different folders,
we can launch the orthology inference using ```orthofinder -f aa```


When the orthology inference is over phylostratigraphy tables can be obtained using:


```sh scripts/phylostratigraphy_crema.sh AD > comparative_genomics/phylostratigraphy_crema_AD.tsv``` for AD


and


```sh scripts/phylostratigraphy_crema.sh CT > comparative_genomics/phylostratigraphy_crema_CT.tsv``` for CT


Tables can be plotted with an Rscript, using as arguments:


- the phylostratigraphy file
- the modules to be plotted (in addition to the total)
- the output plot name


```
Rscript scripts/plot_phylostratigraphy_crema.Rscript
comparative_genomics/phylostratigraphy_crema_AD.tsv 
1,10,12,14,3,9
comparative_genomics/phylostratigraphy_crema_AD.jpg
comparative_genomics/phylostratigraphy_crema_AD_summary.tsv
```


![Image description](https://github.com/for-giobbe/PAINT/blob/main/comparative_genomics/phylostratigraphy_crema_AD.jpg)


```
Rscript scripts/plot_phylostratigraphy_crema.Rscript 
comparative_genomics/phylostratigraphy_crema_CT.tsv 
12,13,14,15,16,18,21,23,3,31,36,39,41,7
comparative_genomics/phylostratigraphy_crema_CT.jpg
comparative_genomics/phylostratigraphy_crema_CT_summary.tsv
```


![Image description](https://github.com/for-giobbe/PAINT/blob/main/comparative_genomics/phylostratigraphy_crema_CT.jpg)


Then we can find the single copy genes in crema for dnds analyses. 
We are going to restrict our analyses to this subset, due to the difficulties in analyzing
multi-copy genes: for these it is not straightforward if one should consider the 
speciation branch leading to the multicopy genes or the terminal branches only.
As we are interested in the bigger picture, I think that - if the genes underlying
the ant-plant interaction evolve at a faster rate than the average - we would 
be able to see such a signal anyway. Here are all orthogroups in which crema has a single-copy gene.


```
while read line; 
	do 
	copy=$(echo $line | grep -o "crema" | wc -w); 
	if [[ $copy == 1 ]]; 
		then total=$(echo $line | wc -w); 
		if [[ $total -gt 5 ]]; 
			then echo $line | awk -F ":" '{print $1}';
			fi; 
		fi; 
	done < crema/Orthogroups.txt > crema/SingleCopyOrthogroups.txt
```


This resulted in 5789 genes: of those XXX are in coexpression modules associated to the interaction.


Prior to dnds inference, we need to retrotranslate the orthogroups from amminoacids to nucleotides, 
then to align them.

---


Similarly, for Vicia we start by downloading a rapresentative set of plants cds.


```
for i in $(cat cds_plants.lst | awk -F "\t" '{print $4"%"$5}'); 
do 
wgt=$(echo $i | awk -F "%" '{print $1}'); 
cds=$(echo $i | awk -F "%" '{print $2}'); 
wget -O comparative_genomics/vicia/$cds.fa.gz $wgt; 
done;
```


Then after ```gunzip *``` we can reformat everything using:


```
for i in G*; do awk '{print $1}' $i | sed "s/lcl|/${i::-5}-/g" > ${i::-5}.ref.fa; done
```


We then need to reformat vicia cds:


```
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' vicia.Trinity.fasta.transdecoder.cds | awk '{print $1}' | sed "s/>/>vicia-/g" > vicia.fa
```


And we also need to remove the contaminants we previously found:


```
grep -v -A 1 -f ../../contaminants/vicia/vicia.blastp.contaminants_genes.lst vicia.fa > vicia.ref.fa
```


After ```rm crema.Trinity.fasta.transdecoder.cds crema.fa``` we can launch the orthology inference using ```orthofinder -f -d ```

When the orthology inference is over phylostratigraphy tables can be obtained using:


```sh scripts/phylostratigraphy_vicia.sh > comparative_genomics/phylostratigraphy_vicia.tsv ```


Then the tables can be plotted in R.


```
Rscript scripts/plot_phylostratigraphy_vicia.Rscript
comparative_genomics/phylostratigraphy_vicia.tsv
comparative_genomics/phylostratigraphy_vicia.jpg
```


![Image description](https://github.com/for-giobbe/PAINT/blob/main/comparative_genomics/phylostratigraphy_vicia.jpg)


---


[main](https://github.com/for-giobbe/PAINT) /
[0](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_0.md) /
[1](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_1.md) /
[2](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_2.md) /
[3](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_3.md) /
[4](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_4.md) /
[5](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_5.md) /
[6](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_6.md) /
[7](https://github.com/for-giobbe/PAINT/blob/main/markdowns/part_7.md)
