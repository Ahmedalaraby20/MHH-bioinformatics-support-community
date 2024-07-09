# Running Cellranger on MHH HPC

Cellranger is a set of analysis pipelines that perform sample demultiplexing, barcode processing, single cell 3' and 5' gene counting, V(D)J transcript sequence assembly and annotation, and Feature Barcode analysis from single cell data. More information can be found [here](https://www.10xgenomics.com/support/software/cell-ranger/latest).

Cellranger contains several pipelines including:

- **mkfastq**: This pipeline is used to demultiplex Illumina runs into fastq files, an alternative solution to BCL Convert/bcl2fastq.
- **count**: This counts gene expression and/or feature barcode reads from a single sample and GEM well.
- **vdj**: Assembles single-cell VDJ receptor sequences from 10x Immune Profiling libraries.
- **multi**: Analyzes multiplexed data or combined gene expression/immune profiling/feature barcode data.

Depending on your experiment setup, it might be better to use one pipeline over the other.
![Picture here]

Cellranger is available in binary form (very nice and does not require admin rights for installation).

## Downloading Cellranger

To download Cellranger, login to the HPC and navigate to your group directory. In our case, we will go to:

```bash
(base) [ahmedhas@leinelogin01 Rstudio]$ cd /project/ag-singlecellsummer2024/
```

Make a directory with your username:
```bash
(base) [ahmedhas@leinelogin01 ag-singlecellsummer2024]$ mkdir $(whoami)
(base) [ahmedhas@leinelogin01 ag-singlecellsummer2024]$ cd $(whoami)
```

Start an srun session:

```bash
srun -p leinecpu --job-name="cellranger" -c6 --mem-per-cpu=8000M --pty --time=02:00:00 /bin/bash
```

Download Cellranger:
```bash
wget -O cellranger-8.0.1.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-8.0.1.tar.gz?Expires=1720582383&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA&Signature=O73rFYh9Y~mpFWq4a5tXsVW27y3kOpkS2kLgW-D4w427-vdKojsiNz7jnE-tHeTwqxljcH7ZbNjsSUkFZUpygKlcFNK6TkkcXXWhWtdGUGEJfj~prgOyDMYEVn~7gw0vJdidD8~s78rFElFTZLxw3Sz6ipvEzYrnhudeKK5euzD-UZBAjquOUOJyHRmJeVZNmJjE3QaP9YAgEwgTyIKWy7Mgcr3GwzC6pfU2WuKySGlNUuzZf61mfYWAhRi2a1k2ZyhG~gFq6~dTSRHDniwIBGahZke96CusKTESU-jNhZrtEh7cyneRicgrrib9mtCks5s3KQEQal6~LwCwMo8-7A__"
```

Untar Cellranger:
```bash
tar -xvf cellranger-8.0.1.tar.gz
cd cellranger-8.0.1
export PATH=$(pwd):$PATH  # this is a temporary option; for a permanent solution, copy this into the bashrc file in your home directory
```

## Downloading and Untarring References
Human GEX
```bash
mkdir ref
cd ref
wget "https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2024-A.tar.gz"
tar -xvf refdata-gex-GRCh38-2024-A.tar.gz
```
Mouse GEX
```bash
wget "https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCm39-2024-A.tar.gz"
tar -xvf refdata-gex-GRCm39-2024-A.tar.gz
```
Human VDJ
```bash
wget "https://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCh38-alts-ensembl-7.1.0.tar.gz"
tar -xvf refdata-cellranger-vdj-GRCh38-alts-ensembl-7.1.0.tar.gz
```
Mouse VDJ
```bash
wget "https://cf.10xgenomics.com/supp/cell-vdj/refdata-cellranger-vdj-GRCm38-alts-ensembl-7.0.0.tar.gz"
tar -xvf refdata-cellranger-vdj-GRCm38-alts-ensembl-7.0.0.tar.gz
```
