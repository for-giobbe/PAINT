# script to identify contaminat contigs
# $1 is blastp output 
# $2 is contaminants contigs list
# $3 is the taxonomy to which all the blast hits must derive (e.g. Pancrustacea or Viridiplantae)

for i in $(awk -F "\t" '{print $1}' $1 | sort -u);

        do

	a=$(grep $i $1 | awk -F "\t" '{print $(NF-1)" "$NF}' | sort -g | head -500 | awk '{print $NF}');

        echo $a | sed "s/ /\n/g" | sed "s/;/\n/g" > $1"tmp.taxon.lst";

 	cat $1"tmp.taxon.lst"

        taxonkit lineage $1"tmp.taxon.lst"  --data-dir dbs/taxdump > $1"tmp.lineage.lst" ;

	cat $1"tmp.lineage.lst"

        tot=$(wc -l $1"tmp.lineage.lst" | awk '{print $1}');

	if ! [[ $(grep -c $3 $1"tmp.lineage.lst") -ge tot ]] 
	        then echo $i >> $2;
        fi;

done
