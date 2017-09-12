/****************************************************************************
 * uvm_stim.svh
 ****************************************************************************/

/**
 * Class: uvm_stim
 * 
 * TODO: Add class documentation
 */
class uvm_stim;

	function new();

	endfunction
	
//	static function bit is_complete(
//	endfunction
	
	static function bit do_gen_by_name(
		string		gen_name,
		uvm_object	o,
		string		key="",
		int			per_thread=-1);
		uvm_stim_gen stim_gen = null;
		process p = process::self();
		uvm_stim_factory::type_info info;
		
		// TODO: must configure per-key and per-thread
		
		info = uvm_stim_factory::get_info(o.get_object_type());
		stim_gen = info.get_gen_by_name(gen_name, key, p);
		
		if (stim_gen != null) begin
			return stim_gen.do_gen(o);
		end else begin
			return 0;
		end
	endfunction
	
	static function bit do_gen_by_type(
		uvm_object_wrapper		gen_type,
		uvm_object				o,
		string					key="",
		int						per_thread=-1);
		uvm_stim_gen stim_gen = null;
		process p = process::self();
		uvm_stim_factory::type_info info;
		
		// TODO: must configure per-key and per-thread
		
		info = uvm_stim_factory::get_info(o.get_object_type());
		stim_gen = info.get_gen_by_type(gen_type, key, p);
		
		if (stim_gen != null) begin
			return stim_gen.do_gen(o);
		end else begin
			return 0;
		end		
	endfunction

	static function bit do_gen(
		uvm_object	o,
		string		key="",
		int			per_thread=-1);
		uvm_stim_factory::type_info info;
		uvm_stim_gen stim_gen = null;
		bit res_per_key = 1;
		bit res_per_thread = 1;
		process p = process::self();
		
		info = uvm_stim_factory::get_info(o.get_object_type());

		if (per_thread != -1) begin
			res_per_thread = !(per_thread == 0);
		end else begin
			// This call is deferring to type or key preferences
			if (key != "") begin
				// See if there's a key preference
			end else begin
			end
		end
		
		if (info != null) begin
			stim_gen = info.get_gen(key, p);
		end
		
		// Need to find generator type (uvm_object_wrapper)
		// - Determine whether we're doing key-specific for this type
		//   - 
		//   - Determine whether we're
		// - No:
		//   - Get default callsite info
		//

		if (stim_gen != null) begin
			return stim_gen.do_gen(o);
		end else begin
			return o.randomize();
		end
	endfunction


endclass


