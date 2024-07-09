```bash
#make a new directory called Rstudio 
mkdir Rstudio
#go into the new directory
cd Rstudio
#pull your container in my case I will get the Bioconductor container and save it as name.sif
singularity pull bioconductor.sif docker://bioconductor/bioconductor_docker
