/****************************************************************************
 * uvm_rand_factory_macros.svh
 ****************************************************************************/
 
`define uvm_rand_factory_callsite \
    $sformatf("%0s:%0d", `__FILE__, `__LINE__)

`define uvm_infact_randomizer(cls, infact_cls) \
    class cls``_``infact_cls``_randomizer extends infact_uvm_randomizer_base #(cls, infact_cls); \
    	`uvm_object_utils(cls``_``infact_cls``_randomizer) \
    endclass

`define uvm_rand_randomize(obj) \
    if (!uvm_rand_factory::do_randomize(obj, , , `uvm_rand_factory_callsite)) begin \
    	`uvm_fatal("uvm_rand", \
    		$sformatf("Failed to randomize object type %0s", obj.get_object_type().get_type_name())); \
    end