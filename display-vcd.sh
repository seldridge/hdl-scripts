#!/bin/bash

usage() {
	echo "Usage: display-vcd <vcd file>"
}

if [ "$#" -ne 1 ]; then
	usage
	exit 1
fi

VCD_FILE="$1"
HDL_SCRIPTS_DIR=~/dev/hdl-scripts

VCD_FILE_BASE=$(basename ${VCD_FILE})
MODULE_NAME="${VCD_FILE_BASE%.*}"
VCD_DIR=$(dirname ${VCD_FILE})
GTKW_TEMP_FILE=${VCD_DIR}/${MODULE_NAME}.gtkw.tmp
GTKW_FILE=${VCD_DIR}/${MODULE_NAME}.gtkw

gtkwave -S ${HDL_SCRIPTS_DIR}/addWavesRecursive.tcl ${VCD_FILE} -O ${GTKW_TEMP_FILE}
awk -f take-after-start-marker.awk ${GTKW_TEMP_FILE} > ${GTKW_FILE}
rm ${GTKW_TEMP_FILE}
gtkwave ${VCD_FILE} ${GTKW_FILE}

