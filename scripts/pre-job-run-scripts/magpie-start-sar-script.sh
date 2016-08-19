#!/bin/sh

# This script starts sar sysstat collection tool and write sar PID to a file

mkdir -p "${SAR_LOCAL_DIR}/${SLURM_JOB_ID}"
HOST=`hostname`
nohup sar -A -o ${SAR_LOCAL_DIR}/${SLURM_JOB_ID}/${HOST}.log ${SAR_RECORD_INTERVAL} > /dev/null 2>&1 & echo $! > ${SAR_LOCAL_DIR}/${SLURM_JOB_ID}/${HOST}.pid

NOW=$(date +"%T")
SAR_PID=$(cat ${SAR_LOCAL_DIR}/${SLURM_JOB_ID}/${HOST}.pid

if ps -p $SAR_PID > /dev/null
then
   echo "sar process ${SAR_PID} is running on ${HOST}"
fi

echo "Started sar process (PID: ${SAR_PID})  on ${HOST} at ${NOW}"