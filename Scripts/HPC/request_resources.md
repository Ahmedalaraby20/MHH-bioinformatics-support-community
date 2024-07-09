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
![res1](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/raw/main/assets/res1.png)

Once the resources are allocated, navigate to the directory where your data is located and start your task.

Once you are done you can kill your job either by 
```bash
(base) [ahmedhas@leinewr009 Rstudio]$ exit
```
![res2](https://github.com/Ahmedalaraby20/MHH-bioinformatics-support-community/raw/main/assets/res2.png)

or by 
```bash
(base) [ahmedhas@leinelogin01 Rstudio]$ squeue 
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
            322094 interacti     bash granobst  R      47:36      1 leinevm003
            322090 interacti Elene-in loliashe  R      56:44      1 leinevm002
            322028 interacti interact verstrar  R    2:05:17      1 leinevm002
            321979 interacti interact depledgd  R    4:14:56      1 leinevm001
            321975 interacti interact s-erfuhr  R    5:24:10      1 leinevm001
            321974 interacti interact s-erfuhr  R    5:24:21      1 leinevm001
            321973 interacti interact s-erfuhr  R    5:24:34      1 leinevm001
            322055  leinecpu cp_hanse zubkemax  R    1:36:52      1 leinewr009
          322100_1  leinecpu DRAP3R-a verstrar  R       8:07      1 leinewr009
          322100_2  leinecpu DRAP3R-a verstrar  R       8:07      1 leinewr009
          322100_3  leinecpu DRAP3R-a verstrar  R       8:07      1 leinewr009
          322100_4  leinecpu DRAP3R-a verstrar  R       8:07      1 leinewr009
          322100_5  leinecpu DRAP3R-a verstrar  R       8:07      1 leinewr009
            322099 leinegpu_     bash eickemar  R       9:38      1 leinewr011
            322092 leinegpu_ dorado_m depledgd  R      55:30      1 leinewra100
            322095 leinegpu_      loo sanderlu  R      28:09      1 leinewr010
            322072 leinegpu_ pytorch_ schmidtj  R    1:19:29      1 leinewra100
            322093 leinegpu_ jupyter_ longsara  R      53:04      1 leinewr010
(base) [ahmedhas@leinelogin01 Rstudio]$ scancel JOBID
```

More information about srun can be found here  [Slurm Commands](https://slurm.schedmd.com/srun.html)

