### Running a Cellranger Pipeline

In this guide, we will run a simple cellranger pipeline (`cellranger count`) to analyze single-cell RNA sequencing data.

#### Prerequisites

Before starting, ensure you have:
- Fastq files: These are obtained after sequencing your library. If you have BCL files, convert them using `cellranger mkfastq` before running `cellranger count`.

#### Running the Pipeline

```bash
# Download fastq files (if not already downloaded)
curl -O https://s3-us-west-2.amazonaws.com/10x.files/samples/cell-exp/6.1.2/10k_PBMC_3p_nextgem_Chromium_X_intron/10k_PBMC_3p_nextgem_Chromium_X_intron_fastqs.tar
```
#### Start an srun session with resource allocation
```bash
srun -p leinecpu --job-name="cellranger" -c8 --mem-per-cpu=10000M --pty --time=04:00:00 /bin/bash
```
#### Navigate to your project directory and set up cellranger
```bash
cd /project/ag-singlecellsummer2024
export PATH=$(pwd)/$(whoami)/cellranger-8.0.1/:$PATH  # Temporary option; for permanent setup, add to bashrc
```
#### Run cellranger count
```bash
cellranger count --id=$(whoami)_cellrangeroutputs --transcriptome=/project/ag-singlecellsummer2024/$(whoami)/cellranger-8.0.1/ref/refdata-gex-GRCh38-2020-A \
           --fastqs=/project/ag-singlecellsummer2024/cellrangerfastqfiles/10k_PBMC_3p_nextgem_Chromium_X_fastqs \
           --sample=10k_PBMC_3p_nextgem_Chromium_X \
           --create-bam=true \
           --localcores=8 \
           --localmem=64
```

# Check the output directory
```bash
cd $(whoami)_cellrangeroutputs
ls
```
