# script to reformat PANNZER2 output for TopGO
# $1 - PANNZER2 predictions.lst input file
# $2 - output file

if [[ -f $2 ]]; then echo "annotation already exists"; exit; fi

for i in $(awk '{print $1}' $1 | sort -u);

	do
	
	GOs=$(grep $i $1 | awk '{print $3}'); 
	refGOs=$(echo $GOs | sed "s/ /, GO:/g"); 
	if ! [ -z "$refGOs" ]
		then echo -e "$i\t$refGOs" | sed "s/\t/\tGO:/" | sed 's/_i[0-9]*\.p[0-9]*//g' >> $2;
		else echo -e $i	 >> $2; 
	fi

done
