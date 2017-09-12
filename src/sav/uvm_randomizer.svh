/****************************************************************************
 * uvm_randomizer.svh
 ****************************************************************************/

/**
 * Class: uvm_randomizer
 * 
 * TODO: Add class documentation
 */
class uvm_randomizer #(type T=uvm_object) extends uvm_object;
	typedef uvm_randomizer #(T) this_t;
	`uvm_object_param_utils(this_t)
	
	// T::get_type() provides the object type
	// this_t::get_type() provides the randomizer type
	
	// Think we'll have to have different randomizers for 
	// parameterized and non-parameterized classes
	// Or, perhaps we can probe that
	
	// Think we can do both: register *actual* type with the factory,
	// while associating the simple name 
	//
	// User will want to override the randomizer either by name or
	// by type (depending on what makes sense)
	//
	// If the user creates a randomizer for a parameterized type, they
	// will 
	//
	// Not exactly type based afterall.
	// Users may want to do a type-based override. However, others may
	// wish to override for specific callsites or call keys
	//
	// So, resolution process is:
	// - look in the per-key map (maps string to type_object)
	//   - User should be able to refer to this object by name when it's simple
	//   - Or by type
	//
	// -> Basically won't fly for 
	// - call UVM to create a default object

	virtual function bit do_randomize(uvm_object item_o);
		// Default randomizer
		return item_o.randomize();
	endfunction

endclass
