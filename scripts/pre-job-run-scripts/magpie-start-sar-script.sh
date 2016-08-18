#!/bin/sh

# This script starts sar sysstat collection tool and write sar PID to a file

mkdir -p "${SAR_LOCAL_DIR}/${SLURM_JOB_ID}"
HOST=`hostname`
nohup sar ${SAR_CMD_OPTS} -o "${SAR_LOCAL_DIR}/${SLURM_JOB_ID}/${HOST}.log" ${SAR_RECORD_INTERVAL} > /dev/null 2>&1 & echo $! > "${SAR_LOCAL_DIR}/${SLURM_JOB_ID}/${HOST}.pid"
