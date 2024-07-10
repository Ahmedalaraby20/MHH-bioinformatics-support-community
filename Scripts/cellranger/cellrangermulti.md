In case you have a more complectaed expermetn setup, e.g., includes VDJ, features(such as Hashtags, CITE-Seq, CRISPR) you might have to run 'cellranger multi' which can process multiple inputs all at once.
Aside from the Fastq files you will need two extra files. more information can be found [here](https://www.10xgenomics.com/support/software/cell-ranger/latest/analysis/running-pipelines/cr-3p-multi) 
- library.csv: which includes the location and the library type of your Fastq files
  [example](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/blob/main/assets/libs.csv)

- feature_ref.csv: which includes inforamtion regarding your features e.g., the handel sequence, the pattern, the thype of feature
  [example](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/blob/main/assets/feature_ref.csv)

Once these files are ready you will have to creat a new bash file, 

 ```bash
    #!/bin/bash
export PATH=/project/ag-foerster/cellranger-8.0.1:$PATH

base_dir="$(pwd)"
transcriptome_dir="/project/ag-foerster/references/refdata-gex-GRCh38-2024-A"




# Iterate over each subdirectory in the base directory
for folder in "$base_dir"/*/; do
    # Extract the folder name without the trailing slash
    folder_name=$(basename "$folder")
    
    # Run the cellranger count command
    cellranger count --id="${folder_name}_results" \
    		     --libraries="$folder"libs.csv\
                     --transcriptome="$transcriptome_dir" \
                     --feature-ref="$folder"feature_ref.csv \
                     --create-bam=true
done
```
