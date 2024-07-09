# MHH HPC Resources Request

To perform tasks on the MHH HPC, you need to request a defined set of resources such as RAM, CPU cores, and GPU for a specific amount of time. 
The requested resources are allocated to you if available. 
Once allocated, you can start your job using tools like cellranger, Hisat2, or Rstudio. 
Keep in mind that your job will be terminated once your allocated time expires, even if it's not completed.

For more detailed information, visit the [MHH HPC Cluster System Cheat Sheet](https://gitlab.mh-hannover.local/wissenschaftliches-rechnen/mhh-hpc/-/wikis/Cluster-System-Cheat-Sheet). Access to this page is only available from within MHH.

## Starting a Job

To start a job, run the following command in the login terminal (you can use PuTTY on Windows or a terminal on Linux):

```bash
ssh username@login.cluster.mh-hannover.local
```
Once logged in, request resources and start your job using srun:

```bash
srun -p leinecpu --job-name="hisat2" -c6 --mem-per-cpu=8000M --pty --time=02:00:00 /bin/bash
```

Here, I've requested 6 CPU cores, each with 8GB of RAM from the leinecpu partition, for 2 hours to perform some Hisat2 annotation.
More information about srun can be found here  [Slurm Commands](https://slurm.schedmd.com/srun.html)

Once the resources are allocated, navigate to the directory where your data is located and start your task.
