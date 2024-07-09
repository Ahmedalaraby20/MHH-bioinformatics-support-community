# Running Rstudio on MHH HPC

Rstudio server is not installed on the HPC due to privacy concerns. To run Rstudio, we use Singularity containers (check `pull_your_singularity_container`). Once the container is downloaded, you can request resources to start your Rstudio session.

Download either:
- [RstudioCPU](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/blob/main/Scripts/Rstudio/startrstudio.sbatch)
 or
- [RstudioGPU](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/blob/main/Scripts/Rstudio/startrstudioGPU.sbatch)

Copy it to the directory with the Singularity container.

## Steps to Start Rstudio Session

1. Login to the HPC, and navigate to the directory containing both the sbatch file and the Singularity container.
2. Run the following command:

    ```bash
    (base) [ahmedhas@leinelogin01 Rstudio]$ sbatch startrstudio.sbatch
    ```

3. You will get:

    ```bash
    Submitted batch job 322154
    ```

4. In the same directory, you will find a new file named `slurm-jobnumber.out`. In this case, it will be named `slurm-322154.out`.

The file contains instructions to start Rstudio:

```plaintext
1. SSH tunnel from your workstation using the following command:

   ssh -N -L 8787:leinewr009:41110 ahmedhas@leinelogin01.mh-hannover.local

   and point your web browser to http://localhost:8787

2. Log in to Rstudio Server using the following credentials:

   user: ahmedhas
   password: xxxxxxxxxx

When done using Rstudio Server, terminate the job by:

1. Exit the Rstudio Session ("power" button in the top right corner of the Rstudio window)
2. Issue the following command on the login node:

      scancel -f 322154
INFO:    Converting SIF file to temporary sandbox...
WARNING: underlay of /etc/rstudio/rsession.sh required more than 50 (137) bind mounts
```
5. Start a terminal and paste "ssh -N -L 8787:leinewr009:41110 ahmedhas@leinelogin01.mh-hannover.local"
6. Start your browser and paste "http://localhost:8787"
7. Fill in the username and the password to login
8. Once you are done end your session 

