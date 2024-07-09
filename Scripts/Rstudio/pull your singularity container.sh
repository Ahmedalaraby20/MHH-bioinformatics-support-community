#Before start using Rstudio you should download a container that has both R and Rstudio installed 
#There are plenty of options but if you want to work with Seurat or packages installed from Bioconductor I would strongly suggest using the Bioconductor container, 
#There is a lengthy explanation/tutorial which can be found at https://hub.docker.com/r/bioconductor/bioconductor_docker 
#In the HPC we are not allowed to use Docker for privacy concerns instead we use singularity (an alternative to Docker)
#use the next lines to (download) pull whichever container you want to use #in here I am pulling the latest version of the Bioconductor container
#Login to the HPC (see instructions to use HPC)
#make sure you are in the project directory 
#cd /project/your-ag-name/ #in my case /project/ag-georgiev/
#make a new directory called Rstudio 
mkdir Rstudio
#go into the new directory
cd Rstudio
#pull your container in my case I will get the Bioconductor container and save it as name.sif
singularity pull bioconductor.sif docker://bioconductor/bioconductor_docker
#Thats it 
