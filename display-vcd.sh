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
GTKW_FILE=${VCD_DIR}/${MODULE_NAME}.gtkw

gtkwave -S ${HDL_SCRIPTS_DIR}/addWavesRecursive.tcl ${VCD_FILE} > ${GTKW_FILE}
gtkwave ${VCD_FILE} ${GTKW_FILE}

