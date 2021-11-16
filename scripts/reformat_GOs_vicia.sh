for i in $(awk '{print $1}' enrichment/GO_vicia/GO_vicia_predictions.lst | sort -u);

	do
	
	GOs_BP=$(grep $i enrichment/GO_vicia/GO_vicia_predictions.lst | grep BP | awk '{print $3}'); 
	refGOs_BP=$(echo $GOs_BP | sed "s/ /, GO:/g"); 
	if ! [ -z "$refGOs_BP" ]
		then echo -e "$i\t$refGOs_BP" | sed "s/\t/\tGO:/";
		else echo -e $i	
	fi

	GOs_MF=$(grep $i enrichment/GO_vicia/GO_vicia_predictions.lst | grep MF | awk '{print $3}'); 
	refGOs_MF=$(echo $GOs_MF | sed "s/ /, GO:/g"); 
	if ! [ -z "$refGOs_MF" ]
		then echo -e "$i\t$refGOs_MF" | sed "s/\t/\tGO:/";
		else echo -e $i
	fi

	GOs_CC=$(grep $i enrichment/GO_vicia/GO_vicia_predictions.lst | grep CC | awk '{print $3}');
        refGOs_CC=$(echo $GOs_CC | sed "s/ /, GO:/g");
        if ! [ -z "$refGOs_CC" ]
                then echo -e "$i\t$refGOs_CC" | sed "s/\t/\tGO:/";
                else echo -e $i
        fi

done
