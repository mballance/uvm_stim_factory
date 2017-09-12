/****************************************************************************
 * seq_item_gen.svh
 ****************************************************************************/

/**
 * Class: seq_item_gen
 * 
 * TODO: Add class documentation
 */
class seq_item_gen extends uvm_stim_gen;
	`uvm_object_utils(seq_item_gen)
	int unsigned	m_pid;
//	`uvm_stim_gen_utils(seq_item_gen, seq_item)

	virtual function void init(string key, int unsigned pid);
		m_pid = pid;
	endfunction

	/**
	 * Function: do_gen
	 *
	 * Override from class 
	 */
	virtual function bit do_gen(input uvm_object o);
		seq_item i;
		$cast(i, o);
		
		i.a = m_pid+1;
		i.b = m_pid+2;
		i.c = m_pid+3;

		return 1;
	endfunction

	
endclass


