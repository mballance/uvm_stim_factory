/****************************************************************************
 * uvm_rand_factory.svh
 ****************************************************************************/

/**
 * Class: uvm_rand_factory
 * 
 * TODO: Add class documentation
 */
class uvm_rand_factory;
	
	class rand_typeinfo;
		// Map from 
		string			m_per_key_map[string];
	endclass
	
	static rand_typeinfo		m_typeinfo_map[uvm_object_wrapper];

	static uvm_randomizer		m_default_randomizer = null;
	static bit					per_thread_global[string];

	/**
	 * Function: do_randomize
	 * 
	 * Randomize the specified item
	 * 
	 * Parameters:
	 * - T item         - Object to randomize
	 * - string key     - Key identifying the callsite (optional)
	 * - int per_thread - Specifies whether this randomization should be per-thread.
	 *                    By default, this will be globally controlled
	 * 
	 * Returns:
	 *   1 if randomization succeeds, 0 otherwise
	 */
	static function bit do_randomize(
		uvm_object	item,
		string		key="",
		int			per_thread=-1,
		string		callsite="");
		rand_typeinfo ti;
		uvm_factory factory = uvm_factory::get();
//		string tname = item.get_type_name();
//		string randomizer_tname = {tname, "_randomizer"};
//		uvm_randomizer randomizer;
////		item.get_object_type();
		
		// Must determine how we're going to control this.
		// Probably need dedicated override methods to map between <obj_type>, <randomizer_type>
		// 
		// Perhaps registering the randomizers can do this implicitly
		// 

		factory.find_override_by_type(requested_type, full_inst_path)
		
		if (!m_typeinfo_map.exists(item.get_object_type())) begin
			ti = new();
			m_typeinfo_map[item.get_object_type()] = ti;
		end else begin
			ti = m_typeinfo_map[item.get_object_type()];
		end
	
			
		return item.randomize();
//		
//		if (per_thread == -1) begin
//			if (!per_thread_global.exists(tname)) begin
//				// Determine settings
//			end
//			per_thread = per_thread_global[tname];
//		end
//	
//		// - User can supply a per-type override (all types named 'X' use randomizer type 'Y')
//		// - User can supply a per-type and per-key override (all types named 'X' with a key 'Y' use randomizer type 'Z')
//		// - Once we know the type, we can check whether we have 
//		// - By default, plain randomization is used (use default instance)

		
	endfunction

endclass


