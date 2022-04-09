# evolutionary age and rates of ant-plant interaction genes


*environiment:* yaml.main


*aim:* gain evolutionary insight on the genes associated to crema-vicia interactions, using phylostratigraphy and dnds analyses.

sp | Papilionoideae | Fabales     | Rosids      | Eudicotds	 | Angiosperms | Spermatophyte |


sp | Myrmicinae     | Formicoidea | Hymenoptera | Holometabola	 | Neoptera    | Paleoptera    |


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


After ```rm crema.Trinity.fasta.transdecoder.cds crema.fa``` we can launch the orthology inference using ```orthofinder -f -d ```


When the orthology inference is over phylostratigraphy tables can be obtained using:


```sh scripts/phylostratigraphy_crema.sh AD > comparative_genomics/phylostratigraphy_crema_AD.tsv``` for AD


```sh scripts/phylostratigraphy_crema.sh CT > comparative_genomics/phylostratigraphy_crema_CT.tsv``` for CT


Then the tables can be plotted in R, using as argument:

- the phylostratigraphy file
- the modules to be plotted (in addition to the total)
- the output plot name


```
Rscript plot_phylostratigraphy.Rscript.R phylostratigraphy_crema_AD.txt 1,2,12,13,14,15 AD.jpg
```

Then we can find the single copy genes in crema for dnds analyses. 
We are going to restrict our analyses to this subset, due to the difficulties in analyzing
multi-copy ones: for this it is not straightforward if one should consider the 
branch leading to the multicopy genes or the terminal branches only.
As we are interested in the bigger picture, I think that - if the genes underlying
the ant-plant interaction evolve at a faster rate than the average - we would 
be able to see this phenomenon anyway.


![Image description](https://github.com/for-giobbe/PAINT/blob/main/comparative_genomics/phylostratigraphy_crema_AD.jpg)


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


```sh scripts/phylostratigraphy_vicia.sh```


Then the tables can be plotted in R.


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