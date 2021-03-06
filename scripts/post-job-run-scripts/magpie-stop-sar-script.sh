#!/bin/sh

# This script read sar PID from a file and kill the sar process.

HOST=`hostname`

SAR_PID=$(cat ${SAR_LOCAL_DIR}/${SLURM_JOB_ID}/${HOST}.pid

if ps -p $SAR_PID > /dev/null
then
   echo "sar process ${SAR_PID} is running on ${HOST}"
fi

# Killing sar process
kill $(cat "${SAR_LOCAL_DIR}/${SLURM_JOB_ID}/${HOST}.pid")

# Create job directory in shared file system
mkdir -p "${SAR_SHARED_DIR}/${SLURM_JOB_ID}"

# Copy kafka master and server host list
if [ "${KAFKA_SETUP}" == "yes" ]; then
	if [ ! -f "${SAR_SHARED_DIR}/${SLURM_JOB_ID}/masters" ]; then
    cp  "${KAFKA_CONF_DIR}/masters" "${SAR_SHARED_DIR}/${SLURM_JOB_ID}/masters"
	fi

	if [ ! -f "${SAR_SHARED_DIR}/${SLURM_JOB_ID}/slaves" ]; then
    cp  "${KAFKA_CONF_DIR}/slaves" "${SAR_SHARED_DIR}/${SLURM_JOB_ID}/slaves"
	fi
fi

# Copying sar log back to shared filesystem
cp "${SAR_LOCAL_DIR}/${SLURM_JOB_ID}/${HOST}.log" "${SAR_SHARED_DIR}/${SLURM_JOB_ID}/${HOST}.log"

NOW=$(date +"%T")
echo "Killed sar and transfer logs to shared directory on ${HOST} at ${NOW}"