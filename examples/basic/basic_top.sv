/****************************************************************************
 * basic_top.sv
 ****************************************************************************/
`include "uvm_macros.svh"
// `include "uvm_rand_factory_macros.svh"

/**
 * Module: basic_top
 * 
 * TODO: Add module documentation
 */
module basic_top;
	import uvm_pkg::*;
	import seq_item_pkg::*;
	import uvm_stim_factory_pkg::*;
	

	initial begin
		automatic seq_item s = seq_item::type_id::create();

		uvm_stim::do_gen(s);
		$display("a=%0d b=%0d c=%0d", s.a, s.b, s.c);

		for (int i=0; i<16; i++) begin
			fork
				begin
					uvm_stim::do_gen_by_name("seq_item_gen", s);
					$display("a=%0d b=%0d c=%0d", s.a, s.b, s.c);
				end
			join
		end
		
	end


endmodule


