# evolutionary age and rates of ant-plant interaction genes


*environiment:* yaml.main


*aim:* gain evolutionary insight on the genes associated to crema - vicia interactions,using phylostratigraphy and dnds analyses.


---

For Crema we start by downloading a rapresentative set of insects cds.

```
for i in $(cat cds_insects.lst | awk -F "\t" '{print $4"-"$5}'); 
wgt=$(echo $i | awk -F "-" '{print $1}); 
cds=$(echo $i | awk -F "-" '{print $2}); 
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

And we also need to remove the contaminats we previously found:


```
grep -v -A 1 -f ../../contaminants/crema/crema.blastp.contaminants_genes.lst crema.fa > crema.ref.fa
```

After ```rm crema.Trinity.fasta.transdecoder.cds crema.fa``` we can launch the orthology inference using ```orthofinder -f -d ```


When the orthology inference is over:


---

Similarly for Vicia
