/****************************************************************************
 * uvm_randomizer_factory.svh
 ****************************************************************************/

/**
 * Class: uvm_randomizer_factory
 * 
 * TODO: Add class documentation
 */
class uvm_randomizer_factory extends uvm_object;
	`uvm_object_utils(uvm_randomizer_factory)
	
	static uvm_randomizer	m_default;
	
	function uvm_randomizer get_randomizer(
		string		key,
		bit			per_thread);
		`uvm_fatal("uvm_rand", "uvm_randomizer_factory::get_randomizer unimplemented");
		return null;
	endfunction

endclass


