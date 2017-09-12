#!/bin/sh

vlib work
vlog -sv \
	+incdir+../../src \
	../../src/uvm_stim_factory_pkg.sv \
	seq_item_pkg.sv \
	basic_top.sv

vlog -sv \
	+incdir+../../src \
	seq_item_gen_pkg.sv 

vopt -o basic_top_opt basic_top seq_item_gen_pkg

