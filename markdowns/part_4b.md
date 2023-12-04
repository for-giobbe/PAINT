# coexpression analyses in crema


*environiment:* yaml.WGCNA


*aim:* retrieve genes expression changes associated to EFN feeding using a coexpression approach


---


Since in this experiment several conditions are present, a WGCNA approach is more suitable.
An approach in which the two tissue are analyzed separately is preferred, in order to exlude that
their strong transcriptional eterogeneity could generate spurious module-trait correlations.
Everyting can be seamlessly performed using separate commands for each tissue:


```
Rscript scripts/WGCNA_contrast2.Rscript 22 signed 50 0.3 0.6 pearson 
abundances/crema/RSEM_crema.filtered.gene.counts.matrix abundances/crema/crema_WGCNA_gene/crema_traits 
abundances/crema/crema_WGCNA_gene/ none 0.05 20 AD
```


and


```
Rscript scripts/WGCNA_contrast2.Rscript 14 signed 50 0.3 0.6 pearson
abundances/crema/RSEM_crema.filtered.gene.counts.matrix abundances/crema/crema_WGCNA_gene/crema_traits 
abundances/crema/crema_WGCNA_gene/ none 0.05 20 CT
```


15439 transcripts are analyzed for CT and here is the powers table:


```
   Power SFT.R.sq slope truncated.R.sq mean.k. median.k. max.k.
1      1   0.0809 13.70          0.983 7740.00   7740.00 8070.0
2      2   0.1110 -6.32          0.818 4190.00   4170.00 4650.0
3      3   0.4970 -7.33          0.863 2410.00   2380.00 3020.0
4      4   0.5850 -4.66          0.897 1470.00   1420.00 2100.0
5      5   0.6740 -3.45          0.922  931.00    887.00 1540.0
6      5   0.6740 -3.45          0.922  931.00    887.00 1540.0
7      6   0.7610 -2.86          0.949  615.00    571.00 1170.0
8      7   0.8080 -2.62          0.958  420.00    378.00  928.0
9      7   0.8080 -2.62          0.958  420.00    378.00  928.0
10     8   0.8340 -2.43          0.959  296.00    257.00  754.0
11     9   0.8460 -2.29          0.953  213.00    179.00  625.0
12     9   0.8460 -2.29          0.953  213.00    179.00  625.0
13    10   0.8660 -2.18          0.960  158.00    127.00  525.0
14    11   0.8820 -2.08          0.961  119.00     91.10  448.0
15    13   0.8960 -1.95          0.960   71.60     49.20  335.0
16    15   0.9080 -1.85          0.964   45.70     27.90  260.0
17    17   0.9150 -1.79          0.965   30.60     16.40  206.0
18    19   0.9230 -1.72          0.968   21.30     10.00  167.0
19    21   0.9360 -1.67          0.976   15.30      6.29  138.0
20    23   0.9340 -1.64          0.972   11.30      4.07  115.0
21    25   0.9390 -1.60          0.975    8.57      2.69   97.4
22    27   0.9350 -1.59          0.972    6.62      1.81   83.9
23    29   0.9370 -1.58          0.976    5.20      1.24   73.5
```


Here is a heatmap representing the trait-modules associations for CT:


![Image description](https://github.com/for-giobbe/PAINT/blob/main/abundances/crema/crema_WGCNA_gene/CT_crema_WGCNA_custom_heatmap.jpg)


11239 transcripts are analyzed for AD and here is the powers table:


```
   Power SFT.R.sq slope truncated.R.sq mean.k. median.k. max.k.
1      1   0.0279  3.46          0.833 5650.00   5660.00 6000.0
2      2   0.3950 -8.80          0.876 3100.00   3070.00 3660.0
3      3   0.4670 -6.21          0.922 1820.00   1790.00 2450.0
4      4   0.5150 -4.71          0.944 1130.00   1110.00 1740.0
5      5   0.5280 -3.73          0.949  737.00    718.00 1300.0
6      5   0.5280 -3.73          0.949  737.00    718.00 1300.0
7      6   0.5500 -3.18          0.949  498.00    481.00  998.0
8      7   0.5690 -2.86          0.941  347.00    332.00  788.0
9      7   0.5690 -2.86          0.941  347.00    332.00  788.0
10     8   0.5770 -2.68          0.925  249.00    234.00  635.0
11     9   0.6180 -2.44          0.937  183.00    169.00  519.0
12     9   0.6180 -2.44          0.937  183.00    169.00  519.0
13    10   0.6390 -2.32          0.935  138.00    124.00  431.0
14    11   0.6930 -2.16          0.959  105.00     92.40  362.0
15    13   0.7800 -1.96          0.990   64.40     53.40  262.0
16    15   0.8320 -1.95          0.998   41.50     32.10  204.0
17    17   0.8560 -2.00          0.995   27.90     20.10  166.0
18    19   0.8730 -2.05          0.994   19.50     13.00  139.0
19    21   0.8890 -2.09          0.987   13.90      8.59  118.0
20    23   0.9070 -2.09          0.982   10.20      5.81  102.0
21    25   0.9210 -2.09          0.978    7.69      3.98   89.5
22    27   0.9180 -2.11          0.968    5.88      2.79   79.3
23    29   0.9300 -2.09          0.964    4.57      1.98   71.0
```


Here is a heatmap representing the trait-modules associations for AD:


![Image description](https://github.com/for-giobbe/PAINT/blob/main/abundances/crema/crema_WGCNA_gene/AD_crema_WGCNA_custom_heatmap.jpg)


In the figures only the modules which have (1) a significative (wether positive or negative) correlation to conditions A / B / C / D 
and (2) have a correlation of the opposite direction respectively between "control" (condition A) and "treatment" (conditions B,C,D).
Modules are named as increasing numbers with attached the total number of genes they consist of. 

**NB:** for DE analyses we used the raw gene-counts matrix as input, but WGCNA requires normalized counts;
the script here leverages [vst-normalized](https://www.rdocumentation.org/packages/DESeq2/versions/1.12.3/topics/varianceStabilizingTransformation) TPMs. 
Moreover - as suggested by authors [here](https://horvath.genetics.ucla.edu/html/CoexpressionNetwork/Rpackages/WGCNA/faq.html) -
we resticted the Gene Network inference to the transcripts which are consistently
expressed troughout all samples (at least 20 raw-counts in each samples).


Furthermore, the script includes several parameters:


- soft-thresholding power for network construction
- network type
- minimum module size for module detection
- dendrogram cut height for module merging
- minimum eigengene connectivity for a module not to be disbanded
- correlation used
- the counts
- the traits
- the output directory
- the pvalue correction for trait-modules corelation
- the adjusted pvalue cutoff
- the minimum number of raw-counts to retain a trascript
- the tissue


In our analyses networks have been inferred:

- as signed
- with a power of 22 for AD and 14 for CT
- with a minimum module size of 50
- with a dendrom cut height of 0.3 
- with a min. eigengene connectivity of 0.6
- leveraging peason correlation
- with no pvalue correction for module-trait correlation
- with a p value cutoff of 0.5
- considering only  transcripts with at least 20 counts across all tissue samples


The expression matrix is the [same](https://github.com/for-giobbe/PAINT/blob/main/abundances/crema/RSEM_crema.filtered.gene.counts.matrix) 
used for the preliminary DE analysis and here is the trait file:


```
sed 's/,/ /g' abundances/crema/crema_WGCNA_gene/crema_traits | sed "s/sample/n \tsample/g" | column -t
```


```
n   sample     AD_0  AD_S  AD_L  CT_0  CT_S  CT_L  A_AD  B_AD  C_AD  D_AD  A_CT  B_CT  C_CT  D_CT
01  A_AD_rep1  1     0     0     0     0     0     1     0     0     0     0     0     0     0
02  A_AD_rep2  1     0     0     0     0     0     1     0     0     0     0     0     0     0
03  A_AD_rep3  1     0     0     0     0     0     1     0     0     0     0     0     0     0
04  A_AD_rep4  1     0     0     0     0     0     1     0     0     0     0     0     0     0
05  A_AD_rep5  1     0     0     0     0     0     1     0     0     0     0     0     0     0
06  A_CT_rep1  0     0     0     1     0     0     0     0     0     0     1     0     0     0
07  A_CT_rep2  0     0     0     1     0     0     0     0     0     0     1     0     0     0
08  A_CT_rep3  0     0     0     1     0     0     0     0     0     0     1     0     0     0
09  A_CT_rep4  0     0     0     1     0     0     0     0     0     0     1     0     0     0
10  A_CT_rep5  0     0     0     1     0     0     0     0     0     0     1     0     0     0
11  B_AD_rep1  0     1     0     0     0     0     0     1     0     0     0     0     0     0
12  B_AD_rep2  0     1     0     0     0     0     0     1     0     0     0     0     0     0
13  B_AD_rep3  0     1     0     0     0     0     0     1     0     0     0     0     0     0
14  B_AD_rep4  0     1     0     0     0     0     0     1     0     0     0     0     0     0
15  B_AD_rep5  0     1     0     0     0     0     0     1     0     0     0     0     0     0
16  B_CT_rep1  0     0     0     0     1     0     0     0     0     0     0     1     0     0
17  B_CT_rep2  0     0     0     0     1     0     0     0     0     0     0     1     0     0
18  B_CT_rep3  0     0     0     0     1     0     0     0     0     0     0     1     0     0
19  B_CT_rep4  0     0     0     0     1     0     0     0     0     0     0     1     0     0
20  B_CT_rep5  0     0     0     0     1     0     0     0     0     0     0     1     0     0
21  C_AD_rep1  0     0     1     0     0     0     0     0     1     0     0     0     0     0
22  C_AD_rep2  0     0     1     0     0     0     0     0     1     0     0     0     0     0
23  C_AD_rep3  0     0     1     0     0     0     0     0     1     0     0     0     0     0
24  C_AD_rep4  0     0     1     0     0     0     0     0     1     0     0     0     0     0
25  C_AD_rep5  0     0     1     0     0     0     0     0     1     0     0     0     0     0
26  C_CT_rep1  0     0     0     0     0     1     0     0     0     0     0     0     1     0
27  C_CT_rep2  0     0     0     0     0     1     0     0     0     0     0     0     1     0
28  C_CT_rep3  0     0     0     0     0     1     0     0     0     0     0     0     1     0
29  C_CT_rep4  0     0     0     0     0     1     0     0     0     0     0     0     1     0
30  C_CT_rep5  0     0     0     0     0     1     0     0     0     0     0     0     1     0
31  D_AD_rep1  0     1     1     0     0     0     0     0     0     1     0     0     0     0
32  D_AD_rep2  0     1     1     0     0     0     0     0     0     1     0     0     0     0
33  D_AD_rep3  0     1     1     0     0     0     0     0     0     1     0     0     0     0
34  D_AD_rep4  0     1     1     0     0     0     0     0     0     1     0     0     0     0
35  D_AD_rep5  0     1     1     0     0     0     0     0     0     1     0     0     0     0
36  D_CT_rep1  0     0     0     0     1     1     0     0     0     1     0     0     0     1
37  D_CT_rep2  0     0     0     0     1     1     0     0     0     0     0     0     0     1
38  D_CT_rep3  0     0     0     0     1     1     0     0     0     0     0     0     0     1
39  D_CT_rep4  0     0     0     0     1     1     0     0     0     0     0     0     0     1
40  D_CT_rep5  0     0     0     0     1     1     0     0     0     0     0     0     0     1
```


Just a quick recap of the traits meaning:


- AD_A - never got in contact with vicia
- AD_B - got in contact with vicia only since 24h before experiment 
- AD_C - got in contact with vicia only until 24h before experiment
- AD_D - got in contact with vicia continuously
- CT_A - never got in contact with vicia
- CT_B - got in contact with vicia only since 24h before experiment
- CT_C - got in contact with vicia only until 24h before experiment
- CT_D - got in contact with vicia continuously


We also included an alternative trait coding, which can be leveraged using ```scripts/WGCNA_contrast2.Rscript```.


- AD_0 - abdomen / crema never got in contact with vicia
- AD_S - abdomen / crema got in contact with vicia in the 24h prior to the sacrifice
- AD_L - abdomen / crema got in contact with vicia continuously until 24h prior to the sacrifice 
- CT_0 - head + thorax / crema never got in contact with vicia
- CT_S - head + thorax / crema got in contact with vicia in the 24h prior to the sacrifice
- CT_L - head + thorax / crema got in contact with vicia continuously until 24h prior to the sacrifice


Additionally, the Rscript will generate:


- the top hub-genes for each module in ```hub_genes.lst```
- lists of genes present in each module


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