## preprocessing RNA-seq reads of vicia and crematogaster spp

Here we will remove adapters and lightly trim reads, then quality check them.

---

Let's start by renamink the RNA-seq libraries from how they where received from the sequencing facility to some more convenient names.

From the main folder, we can use the lines ```sh scripts/rename_vicia.sh reads/vicia_raw``` and ```sh scripts/rename_crema.sh reads/crema_raw``` respectively for the plant and the ant.

After the initial conversion, libraries filenames are organized in 4 relevant underscore-separated fields:

        1st filed	species
        2nd field	condition
        3rd field	sample id number
        4th field	tissue

For Vicia sp:

	1st     VI for Vicia
        2nd     N for "never visited" / V for "visited"
        3rd     sample id number
        4th     NP for "nectarium plantae"

for Crematogaster sp:

        1st     CR for Crematogaster
        2nd     A for "long-term:N; short-term:N" / B for "long-term:N; short-term:Y" / C for "long-term:Y; short-term:N" / D for "long-term:Y; short-term:Y"
        3rd     sample id number
        4th     AD for "abdomen" / CT for "head and thorax"

---

To check samples:

```ll reads/crema_ref/ | awk '{print $9}' |  awk -F "_" '{print $1"_"$2"_"$3"_"$4}'```
```ll reads/crema_ref/ | awk '{print $9}' |  awk -F "_" '{print $1"_"$2"_"$3"_"$4}'```

---

Next step is to execute the snakefile which will carry out 
-adapter removal / reads trimming (trimmomatic)
-rRNA removal (sortmerna)
-qc (fastqc).

```snakemake -s scripts/snakefile_preprocessing_reads_vicia --profile slurm --use-conda --cores 16 --profile slurm```

```snakemake -s scripts/snakefile_preprocessing_reads_crema --profile slurm --use-conda --cores 16 --profile slurm```

We can see that trimming removed a negligble portion of reads - an average of 0.00% per library. This is good as there are 
evidences that trimming is (not necessary)[10.1093/nargab/lqaa068] 
and may even (alter downstram expression analyses)[https://https://doi.org/10.1186/s12859-016-0956-2].

