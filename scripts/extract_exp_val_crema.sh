echo transcript logFC_AB_AD padj_AB_AD logFC_AC_AD padj_AC_AD logFC_AD_AD padj_AD_AD logFC_AB_CT padj_AB_CT logFC_AC_CT padj_AC_CT logFC_AD_CT padj_AD_CT

for i in $(awk -F "_i" '{print $1}' $1 | grep "TRI" | tr -d ">");

do 
	expAB_AD=$(grep $i abundances/crema/crema_deseq2_gene/RSEM_crema.filtered.gene.counts.matrix.A_AD_vs_B_AD.DESeq2.DE_results | awk '{print $7" "$11}');
	if [[ -z $expAB_AD ]] ; then expAB_AD="NA NA";fi
	expAC_AD=$(grep $i abundances/crema/crema_deseq2_gene/RSEM_crema.filtered.gene.counts.matrix.A_AD_vs_C_AD.DESeq2.DE_results | awk '{print $7" "$11}');
	if [[ -z $expAC_AD ]]; then expAC_AD="NA NA";fi
	expAD_AD=$(grep $i abundances/crema/crema_deseq2_gene/RSEM_crema.filtered.gene.counts.matrix.A_AD_vs_D_AD.DESeq2.DE_results | awk '{print $7" "$11}'); 
	if [[ -z $expAD_AD ]]; then expAD_AD="NA NA";fi
	
	expAB_CT=$(grep $i abundances/crema/crema_deseq2_gene/RSEM_crema.filtered.gene.counts.matrix.A_CT_vs_B_CT.DESeq2.DE_results | awk '{print $7" "$11}');
	if [[ -z $expAB_CT ]]; then expAB_CT="NA NA";fi
	expAC_CT=$(grep $i abundances/crema/crema_deseq2_gene/RSEM_crema.filtered.gene.counts.matrix.A_CT_vs_C_CT.DESeq2.DE_results | awk '{print $7" "$11}');
	if [[ -z $expAC_CT ]]; then expAC_CT="NA NA";fi
	expAD_CT=$(grep $i abundances/crema/crema_deseq2_gene/RSEM_crema.filtered.gene.counts.matrix.A_CT_vs_D_CT.DESeq2.DE_results | awk '{print $7" "$11}'); 
	if [[ -z $expAD_CT ]]; then expAD_CT="NA NA";fi
	
	echo $i $expAB_AD $expAC_AD $expAD_AD $expAB_CT $expAC_CT $expAD_CT; 
	
done
