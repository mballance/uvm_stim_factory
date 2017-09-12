/****************************************************************************
 * uvm_stim_gen.svh
 ****************************************************************************/

/**
 * Class: uvm_stim_gen
 * 
 * TODO: Add class documentation
 */
class uvm_stim_gen extends uvm_object;
	`uvm_object_utils(uvm_stim_gen)
	
	// Per-type defaults for stimulus-generation strategy
//	static int				per_callsite = -1;
//	static int				per_thread = -1;
//	static uvm_object_wrapper	type_w = T::get_type();
	
//	function new(string name="uvm_stim_gen");
//		$display("new: %0s", object_t::get_type().get_type_name());
//	endfunction

//	static function void set_per_callsite(int v);
//		per_callsite = v;
//	endfunction
//	
//	static function void set_per_thread(int v);
//		per_thread = v;
//	endfunction

	virtual function void init(
		string 			key,
		int unsigned	pid);
	endfunction
	/*
	 */
	virtual function bit is_complete();
		return 0;
	endfunction

	// Base implementation
	virtual function bit do_gen(uvm_object o);
		return 0; 
	endfunction

endclass


