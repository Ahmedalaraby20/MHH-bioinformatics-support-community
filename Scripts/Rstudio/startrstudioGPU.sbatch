#!/bin/bash
#SBATCH --time=96:00:00
#SBATCH --signal=USR2
#SBATCH -p leinegpu_long
#SBATCH -c8
#SBATCH --mem-per-cpu=8G
#SBATCH --gres=gpu:1
#SBATCH --job-name="Rstudio"
username="$(whoami)"
base_dir="$(pwd)"
#SBATCH --error=${base_dir}/rstudio-%u.output
path_to_sif_file=$(ls ${base_dir}/*.sif | head -n 1)
mkdir -p "${base_dir}/${username}/pkg/4.4.0"
path_to_package_installation="${base_dir}/${username}/pkg/4.4.0"

# -------------------------------------------------------------


# ---------------    No Changes from here on    ---------------

# customize --output path as appropriate (to a directory readable only by the user!)
echo $path_to_sif_file
# Create temporary directory to be populated with directories to bind-mount in the container
# where writable file systems are necessary. Adjust path as appropriate for your computing environment.
workdir=$(python -c 'import tempfile; print(tempfile.mkdtemp())')

mkdir -p -m 700 ${workdir}/run ${workdir}/tmp ${workdir}/var/lib/rstudio-server
cat > ${workdir}/database.conf <<END
provider=sqlite
directory=/var/lib/rstudio-server
END

# Set OMP_NUM_THREADS to prevent OpenBLAS (and any other OpenMP-enhanced
# libraries used by R) from spawning more threads than the number of processors
# allocated to the job.
#
# Set R_LIBS_USER to a path specific to rocker/rstudio to avoid conflicts with
# personal libraries from any R installation in the host environment

cat > ${workdir}/rsession.sh <<END
#!/bin/sh
export OMP_NUM_THREADS=${SLURM_JOB_CPUS_PER_NODE}
export R_LIBS_USER=${path_to_package_installation}:/project/ag-georgiev/Rstudio/pkg/v4.4.0 	# TODO: Packages will be installed in this directory.
exec /usr/lib/rstudio-server/bin/rsession "\${@}"
END

chmod +x ${workdir}/rsession.sh

export SINGULARITY_BIND="${workdir}/run:/run,${workdir}/tmp:/tmp,${workdir}/database.conf:/etc/rstudio/database.conf,${workdir}/rsession.sh:/etc/rstudio/rsession.sh,${workdir}/var/lib/rstudio-server:/var/lib/rstudio-server"

# Do not suspend idle sessions.
# Alternative to setting session-timeout-minutes=0 in /etc/rstudio/rsession.conf
# https://github.com/rstudio/rstudio/blob/v1.4.1106/src/cpp/server/ServerSessionManager.cpp#L126
export SINGULARITYENV_RSTUDIO_SESSION_TIMEOUT=0

export SINGULARITYENV_USER=$(id -un)
export SINGULARITYENV_PASSWORD=$(openssl rand -base64 15)
# get unused socket per https://unix.stackexchange.com/a/132524
# tiny race condition between the python & singularity commands
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:

   ssh -N -L 8787:${HOSTNAME}:${PORT} ${SINGULARITYENV_USER}@leinelogin01.mh-hannover.local

   and point your web browser to http://localhost:8787

2. log in to RStudio Server using the following credentials:

   user: ${SINGULARITYENV_USER}
   password: ${SINGULARITYENV_PASSWORD}

When done using RStudio Server, terminate the job by:

1. Exit the RStudio Session ("power" button in the top right corner of the RStudio window)
2. Issue the following command on the login node:

      scancel -f ${SLURM_JOB_ID}
END

# TODO: change the path after "--cleanenv" to the location you stored the .sif file. Here it is /hpc/scratch/project/ag-fdm/R_TEST_NFS/rstudio_4.2.sif
singularity exec --nv --bind /project:/project --bind /hpc:/hpc --cleanenv ${path_to_sif_file} \
    /usr/lib/rstudio-server/bin/rserver --www-port ${PORT} \
            --auth-none=0 \
            --auth-pam-helper-path=pam-helper \
            --auth-stay-signed-in-days=30 \
            --auth-timeout-minutes=0 \
            --rsession-path=/etc/rstudio/rsession.sh \
            --server-user=$(whoami) #\
printf 'rserver exited' 1>&2

