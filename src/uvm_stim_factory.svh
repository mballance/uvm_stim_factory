/****************************************************************************
 * uvm_stim_factory.svh
 ****************************************************************************/

/**
 * Class: uvm_stim_factory
 * 
 * TODO: Add class documentation
 * 
 * Command-line arguments:
 * - Global
 * +uvm_stim_factory.per_thread=[0|1]
 * +uvm_stim_factory.per_key=[0|1]
 * 
 * - Per-type
 * +uvm_stim_factory.per_thread,<type>[,<key>]=[0|1]
 * +uvm_stim_factory.per_key,<type>=[0|1]
 *
 * - Factory specification
 * +uvm_stim_factory.set_factory=<obj_type>[,<key>],<factory_type>
 */
class uvm_stim_factory;
	typedef class type_info;
	typedef class key_info;
	
	static uvm_stim_factory		inst;
	bit							per_key = 1;
	bit							per_thread = 1;
	type_info					type2stimgen_map[uvm_object_wrapper];
	
	static function uvm_stim_factory get_inst();
		if (inst == null) begin
			inst = new();
			inst.init();
		end
		return inst;
	endfunction
	
	static function void set_per_key(bit v);
		get_inst().per_key = v;
	endfunction
	
	static function void set_per_thread(bit v);
		get_inst().per_thread = v;
	endfunction
	
	static function uvm_stim_factory::type_info get_info(
		uvm_object_wrapper		object_type,
		bit						create=1);
		type_info info = null;
		uvm_stim_factory f = get_inst();
		if (f.type2stimgen_map.exists(object_type)) begin
			info = f.type2stimgen_map[object_type];
		end else if (create) begin
			info = new(object_type);
			f.type2stimgen_map[object_type] = info;
		end
		return info;
	endfunction
	
	function void init();
		string args[$];
		uvm_cmdline_processor clp = uvm_cmdline_processor::get_inst();
		uvm_factory factory = uvm_factory::get();
		
		$display("uvm_stim_factory::do_init()");
		
		void'(clp.get_arg_matches("/^\\+uvm_stim_factory.stim_gen=/", args));
		foreach (args[i]) begin
			string arg = args[i].substr(27, args[i].len()-1);
			string split_val[$];
			
			$display("uvm_stim_factory.set_factory: %0s", arg);
			uvm_split_string(arg, ",", split_val);
			
			if (split_val.size() == 2 || split_val.size() == 3) begin
				uvm_object_wrapper obj_type = factory.find_by_name(split_val[0]);
				uvm_object_wrapper gen_type = factory.find_by_name(split_val[1]);
				
				if (obj_type == null || gen_type == null) begin
					if (obj_type == null) begin
						`uvm_fatal("uvm_stim_factory", $sformatf(
									"Failed to find object type %0s", split_val[0]));
					end
					if (gen_type == null) begin
						`uvm_fatal("uvm_stim_factory", $sformatf(
									"Failed to fine stim_gen type %0s", split_val[1]));
					end
				end else begin
					type_info info = get_info(obj_type);
					
					if (split_val.size() == 2) begin
						info.m_pertype_stimgen_type = gen_type;
					end else begin
						key_info k_info = info.get_key_info(split_val[2]);
						k_info.m_perkey_stimgen_type = gen_type;
					end
				end
			end else begin
				`uvm_fatal("uvm_stim_factory", $sformatf(
							"+uvm_stim_factory.set_factory requires 2 or 3 arguments ; received %0d (%0s)",
							split_val.size(), args[i]));
			end
			
			foreach (split_val[j]) begin
				$display("  split_val[%0d] = %0s", j, split_val[j]);
			end
		end
	endfunction

	typedef class type_info;
	typedef class key_info;
	
	class process_info;
		key_info				m_parent;
		process					m_p;
		int unsigned			m_pid;
		uvm_stim_gen			m_type2gen_map[uvm_object_wrapper];
		
		function new(key_info parent, process p, int unsigned pid);
			m_parent = parent;
			m_p = p;
			m_pid = pid;
		endfunction

		function uvm_stim_gen get_gen_by_name(string gen_name);
			uvm_factory factory = uvm_factory::get();
			uvm_object_wrapper t = factory.find_by_name(gen_name);
			uvm_stim_gen gen = null;
			
			if (t == null) begin
				`uvm_fatal("uvm_stim_factory", 
						$sformatf("Failed to find generator \"%0s\" for object-type %0s",
							gen_name, m_parent.m_parent.m_type.get_type_name()));
			end else begin
				gen = get_gen_by_type(t);
			end
			
			return gen;
		endfunction
		
		function uvm_stim_gen get_gen_by_type(uvm_object_wrapper gen_type);
			uvm_stim_gen gen = null;
			
			if (m_type2gen_map.exists(gen_type)) begin
				gen = m_type2gen_map[gen_type];
			end else begin
				uvm_object o;
				o = gen_type.create_object();
				if (!$cast(gen, o)) begin
					`uvm_fatal("uvm_stim_factory", 
							$sformatf("Failed to cast type %0s to uvm_stim_gen",
								o.get_object_type().get_type_name()));
				end else begin
					gen.init(m_parent.m_key, m_pid);
					m_type2gen_map[gen_type] = gen;
				end
			end
			
			return gen;
		endfunction
		
	endclass
	
	class key_info;
		type_info				m_parent;
		string					m_key;
		uvm_object_wrapper		m_perkey_stimgen_type;
		process_info			m_thread_map[process];
		
		function new(type_info parent, string key);
			m_parent = parent;
			m_key = key;
		endfunction
		
		function process_info get_process_info(process p);
			process_info info = null;
			
			if (m_thread_map.exists(p)) begin
				info = m_thread_map[p];
			end else begin
				info = new(this, p, m_thread_map.size());
				m_thread_map[p] = info;
			end
			
			return info;
		endfunction
	
		function uvm_stim_gen get_gen(process p);
			uvm_stim_gen gen = null;
		
			// Decide which type to use
			if (m_perkey_stimgen_type != null) begin
				process_info info = get_process_info(p);
				gen = info.get_gen_by_type(m_perkey_stimgen_type);
			end else if (m_parent.m_pertype_stimgen_type != null) begin
				process_info info = get_process_info(p);
				gen = info.get_gen_by_type(m_parent.m_pertype_stimgen_type);
			end
			
			return gen; 
		endfunction
		
		function uvm_stim_gen get_gen_by_name(
			string 					gen_name, 
			process 				p);
			process_info info = get_process_info(p);
			return info.get_gen_by_name(gen_name);
		endfunction
		
		function uvm_stim_gen get_gen_by_type(
			uvm_object_wrapper		gen_type,
			process					p);
			process_info info = get_process_info(p);
			return info.get_gen_by_type(gen_type);
		endfunction
		
	endclass
	
	class type_info;
		uvm_object_wrapper				m_type;
		uvm_object_wrapper				m_pertype_stimgen_type;
		key_info						key2info_map[string];
		
		function new(uvm_object_wrapper obj_t);
			m_type = obj_t;
		endfunction
		
		function uvm_stim_factory::key_info get_key_info(string key, bit create=1);
			key_info info = null;
			
			if (key2info_map.exists(key)) begin
				info = key2info_map[key];
			end else if (create) begin
				info = new(this, key);
				key2info_map[key] = info;
			end
			
			return info;
		endfunction
		
		function uvm_stim_gen get_gen(
			string			key,
			process			p);
			key_info info = get_key_info(key, 1);
			
			return info.get_gen(p);
		endfunction
		
		function uvm_stim_gen get_gen_by_name(
			string			gen_name,
			string			key,
			process			p);
			key_info info = get_key_info(key, 1);
			return info.get_gen_by_name(gen_name, p);
		endfunction
		
		function uvm_stim_gen get_gen_by_type(
			uvm_object_wrapper	gen_type,
			string				key,
			process				p);
			key_info info = get_key_info(key, 1);
			return info.get_gen_by_type(gen_type, p);
		endfunction
	endclass

endclass


