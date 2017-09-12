/****************************************************************************
 * test_seq_item_gen1.svh
 ****************************************************************************/

/**
 * Class: test_seq_item_gen1
 * 
 * TODO: Add class documentation
 */
class test_seq_item_gen1 extends uvm_stim_gen;
	`uvm_object_utils(test_seq_item_gen1)

	int m_pid;
	string m_key;
	int m_call;


	/**
	 * Function: do_gen
	 *
	 * Override from class 
	 */
	virtual function bit do_gen(input uvm_object o);
		test_seq_item si;
		$cast(si, o);
		
		si.a = m_pid+1+m_key.len()+m_call;
		si.b = m_pid+2+m_key.len()+m_call;
		si.c = m_pid+3+m_key.len()+m_call;

		m_call++;
	endfunction

	/**
	 * Function: init
	 *
	 * Override from class 
	 */
	virtual function void init(input string key, input int unsigned pid);
		m_pid = pid;
		m_key = key;
	endfunction

	

endclass


