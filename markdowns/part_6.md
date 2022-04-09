# evolutionary age and rates of ant-plant interaction genes


*environiment:* yaml.main


*aim:* gain evolutionary insight on the genes associated to crema-vicia interactions, using phylostratigraphy and dnds analyses.


Here is an overview of the strata considered; in the figures anything above Eudicots and Hymenoptera
has been considered as "old". Of course the limitation (both technical and conceptual) of phylostratigrapy
are many, but they will not be discussed here. Just a disclaimer:
while the strata are the same number for crema and vicia, they can not obviously be compared.


| stratum 1 | stratum 2      | stratum 3   | stratum 4   | stratum 5    | stratum 6   | stratum 7     |
|-----------|----------------|-------------|-------------|--------------|-------------|---------------|
| sp        | Myrmicinae     | Formicoidea | Hymenoptera | Holometabola | Neoptera    | Paleoptera    |
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
1,2,12,13,14,15
comparative_genomics/phylostratigraphy_crema_AD.jpg
```


![Image description](https://github.com/for-giobbe/PAINT/blob/main/comparative_genomics/phylostratigraphy_crema_AD.jpg)


```
Rscript scripts/plot_phylostratigraphy_crema.Rscript 
comparative_genomics/phylostratigraphy_crema_CT.tsv 
18,20,31,32,33,34,38,39,4,41,43,44,6,9 
comparative_genomics/phylostratigraphy_crema_CT.jpg
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
	if [[ $copy == 1 ]]; then echo $line | awk '{print $1}'; 
	fi; 
done < crema/Orthogroups.txt
```


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
