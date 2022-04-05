cd comparative_genomics

grep ">" ../annotations/vicia/vicia.Trinity.fasta.transdecoder.cds | awk -F "." '{print $1}' | sed "s/_i[0-9]*//" | tr -d ">" > vicia_genes.tmp

for transcript in $(cat vicia_genes.tmp);
	
	do if grep -q $transcript ../annotations/vicia/vicia.Trinity.fasta.transdecoder.pep

		then

		line=$(grep $transcript vicia/Orthogroups.txt)

			if echo $line | grep -q -e GCA_019776745; then 
				echo -e "$transcript\tSPE";

			elif echo $line | grep -q -e GCF_001865875 -e GCA_019845555 -e GCF_001605985 -e GCF_016808335 -e GCF_000313855; then
                                echo -e "$transcript\tANG";

			elif echo $line | grep -q -e GCF_000003745 -e GCF_004153795 -e GCF_000188115 -e GCA_003112345 -e GCA_008009225 -e GCF_001879475 -e GCA_022085475; then
                                echo -e "$transcript\tEUD";

                        elif echo $line | grep -q -e GCF_013401445 -e GCF_000001735 -e GCF_006381635 -e GCF_000493195 -e GCF_005239225 -e GCF_002906115 -e GCF_000346465; then
                                echo -e "$transcript\tROS";

                        elif echo $line | grep -q -e GCF_004799145 -e GCA_014851425; then
                                echo -e "$transcript\tFAB";

                        elif echo $line | grep -q -e GCF_003473485 -e GCF_000331145 -e GCF_000004515 -e GCF_020283565 -e GCF_001865875 -e GCF_000499845 -e GCA_003370565 -e GCA_004329165 -e GCF_003086295; then
                                echo -e "$transcript\tPAP";
			else 
				echo -e "$transcript\tspecies-specific";
			fi

	fi

done
