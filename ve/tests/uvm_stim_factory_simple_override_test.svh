
class uvm_stim_factory_simple_override_test extends uvm_stim_factory_test_base;
	
	`uvm_component_utils(uvm_stim_factory_simple_override_test)
	
	/****************************************************************
	 * Data Fields
	 ****************************************************************/
	
	/****************************************************************
	 * new()
	 ****************************************************************/
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction

	/****************************************************************
	 * run_phase()
	 ****************************************************************/
	task run_phase(uvm_phase phase);
		test_seq_item si1_1 = test_seq_item::type_id::create();
		test_seq_item2 si2_1 = test_seq_item2::type_id::create();
		
		phase.raise_objection(this, "Main");
		
		uvm_stim::do_gen(si1_1);
		if (si1_1.a != 1 && si1_1.b != 2 && si1_1.c != 3) begin
			`uvm_fatal(get_name(), $sformatf("Incorrect data: expect 1,2,3 ; receive %0d,%0d,%0d",
						si1_1.a, si1_1.b, si1_1.c));
		end
		uvm_stim::do_gen(si1_1);
		if (si1_1.a != 2 && si1_1.b != 3 && si1_1.c != 4) begin
			`uvm_fatal(get_name(), $sformatf("Incorrect data: expect 1,2,3 ; receive %0d,%0d,%0d",
						si1_1.a, si1_1.b, si1_1.c));
		end
	
		// Expect a new generator to be created on the same thread
		uvm_stim::do_gen(si1_1, "foobar");
		if (si1_1.a != 7 && si1_1.b != 8 && si1_1.c != 9) begin
			`uvm_fatal(get_name(), $sformatf("Incorrect data: expect 7,8,9 ; receive %0d,%0d,%0d",
						si1_1.a, si1_1.b, si1_1.c));
		end
		uvm_stim::do_gen(si1_1, "foobar");
		if (si1_1.a != 8 && si1_1.b != 9 && si1_1.c != 10) begin
			`uvm_fatal(get_name(), $sformatf("Incorrect data: expect 7,8,9 ; receive %0d,%0d,%0d",
						si1_1.a, si1_1.b, si1_1.c));
		end
		
		phase.drop_objection(this, "Main");
	endtask
	
endclass



