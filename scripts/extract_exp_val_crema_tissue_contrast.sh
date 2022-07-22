echo -e "transcript\thomolog\tmean_AD\tmean_CT\tlogFC\tpadj\tmodule_AD\tmodule_CT";

for i in $(awk '{print $1}' $1 | awk -F "_i" 'NF{NF-=1};1');
        do
	homolog=$(grep $i $1 | awk '{print $2}' | head -1);
        exp=$(grep -w $i abundances/crema/crema_deseq2_gene/RSEM_crema.filtered.gene.counts.matrix.A_AD_vs_A_CT.DESeq2.DE_results | awk '{print $5"\t"$6"\t"$7"\t"$NF}'); if [ -z "$exp" ]; then exp="-\t-\t-\t-"; fi;
        module_AD=$(grep -w $i abundances/crema/crema_WGCNA_gene/*AD*lst | awk -F "_" '{print $5}'); if [ -z "$module_AD" ]; then module_AD="notGCN"; fi;
        module_CT=$(grep -w $i abundances/crema/crema_WGCNA_gene/*CT*lst | awk -F "_" '{print $5}'); if [ -z "$module_CT" ]; then module_CT="notGCN"; fi;
        echo -e "$i\t$homolog\t$exp\t$module_AD\t$module_CT";
        done

