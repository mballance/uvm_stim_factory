/****************************************************************************
 * infact_uvm_randomizer_base.svh
 ****************************************************************************/

/**
 * Class: infact_uvm_randomizer_base
 * 
 * TODO: Add class documentation
 */
class infact_uvm_randomizer_base #(type T=uvm_object, type IF_T=int) extends uvm_randomizer;
	
	IF_T				infact_gen;

	virtual function bit do_randomize(uvm_object item_o);
		T item;
		$cast(item, item_o);
		
		infact_gen.ifc_fill(item);
		
		return 1;
	endfunction

endclass


