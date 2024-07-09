```bash
# Before starting with Rstudio, download a container that has both R and Rstudio installed.
# There are plenty of options, but if you want to work with Seurat or packages installed from Bioconductor, I would strongly suggest using the Bioconductor container.
# For a detailed tutorial, visit [Bioconductor Docker Hub](https://hub.docker.com/r/bioconductor/bioconductor_docker).

# In the HPC, Docker cannot be used due to privacy concerns; instead, we use Singularity, an alternative to Docker.

# Use the following lines to download/pull whichever container you want to use. Here, I am pulling the latest version of the Bioconductor container:

# Login to the HPC (refer to instructions for using HPC).
# Make sure you are in the project directory:
cd /project/your-ag-name/   # Replace 'your-ag-name' with your specific project name, e.g., /project/ag-georgiev/

# Create a new directory called 'Rstudio':
mkdir Rstudio

# Navigate into the new directory:
cd Rstudio

# Pull your container. In this case, I will get the Bioconductor container and save it as 'bioconductor.sif':
singularity pull bioconductor.sif docker://bioconductor/bioconductor_docker
