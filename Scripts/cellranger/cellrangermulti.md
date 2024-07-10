In case you have a more complicated experiment setup, e.g., includes VDJ, features(such as Hashtags, CITE-Seq, CRISPR) you might have to run 'cellranger multi' which can process multiple inputs all at once.
Aside from the Fastq files you will need two extra files. More information can be found [here](https://www.10xgenomics.com/support/software/cell-ranger/latest/analysis/running-pipelines/cr-3p-multi) 
- library.csv: which includes the location and the library type of your Fastq files
  [example](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/blob/main/assets/libs.csv)

- feature_ref.csv: which includes information regarding your features e.g., the handle sequence, the pattern, the type of feature
  [example](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/blob/main/assets/feature_ref.csv)

Once these files are ready you will have to create a new bash file, 

 ```bash
#!/bin/bash
export PATH=path/to/cellranger:$PATH

base_dir="$(pwd)"
transcriptome_dir="path/to/reference"

for folder in "$base_dir"/*/; do
    folder_name=$(basename "$folder")
    
    cellranger count --id="${folder_name}_results" \
    		     --libraries="$folder"libs.csv\
                     --transcriptome="$transcriptome_dir" \
                     --feature-ref="$folder"feature_ref.csv \
                     --create-bam=true
done
```
You can modify the bash file to work in your directory 

