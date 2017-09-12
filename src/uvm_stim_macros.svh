

`define uvm_stim_gen_utils(T, OT) \
`uvm_object_utils(T) \
typedef OT _``OT``_object_t; \
static bit _stim_gen_init = uvm_stim_factory::register_stimgen_type( \
  _``OT``_object_t::get_type(), \
  get_type());
  
    