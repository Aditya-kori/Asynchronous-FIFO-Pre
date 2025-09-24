class base_test extends uvm_test;
fifo_env env;
	`uvm_component_utils(base_test)
	`NEW_COMP
	
	function void build_phase(uvm_phase phase);
		env = fifo_env :: type_id :: create("env", this);
	endfunction

	function void end_of_elaboration();
		uvm_top.print_topology();
	endfunction

	function void report();
	`uvm_info("STATUS",$psprintf("match=%0d, mismatch=%0d",num_matches,num_mis_matches),UVM_LOW)
		if(num_mis_matches == 0 && num_matches != 0) `uvm_info("STATUS", "TEST PASSED",UVM_LOW)
		else `uvm_error("STATUS", "Test failed")
	endfunction
endclass

class wr_test extends base_test;
wr_seq w_seq;
	`uvm_component_utils(wr_test)
	`NEW_COMP

	task run_phase(uvm_phase phase);
	w_seq = new("w_seq");
		phase.raise_objection(this);
		w_seq.wr_count = 10;
		w_seq.start(env.w_agt.sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

class rd_test extends base_test;
rd_seq r_seq;
	`uvm_component_utils(rd_test)	
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//uvm_config_db#(uvm_object_wrapper)::set(this,"env.r_agt.sqr.run_phase","default_sequence",rd_seq::get_type());
		`uvm_info("RD_TEST","inside build of rd_test",UVM_LOW)
	endfunction

	task run_phase(uvm_phase phase);
	r_seq = new("r_seq");
		phase.raise_objection(this);
		r_seq.rd_count = 10;
		r_seq.start(env.w_agt.sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
	
endclass

class wr_rd_test extends base_test;
wr_seq w_seq;
rd_seq r_seq;
	`uvm_component_utils(wr_rd_test)
	`NEW_COMP

	task run_phase(uvm_phase phase);
		w_seq = new("w_seq");
		r_seq = new("r_seq");
		w_seq.wr_count = `DEPTH;
		r_seq.rd_count = `DEPTH;
		phase.raise_objection(this);
		w_seq.start(env.w_agt.sqr);
		r_seq.start(env.r_agt.sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

class overflow_test extends base_test;
wr_seq w_seq;
	`uvm_component_utils(overflow_test)
	`NEW_COMP

	task run_phase(uvm_phase phase);
		w_seq = new("w_seq");
		phase.raise_objection(this);
		w_seq.wr_count = `DEPTH+1;
		w_seq.start(env.w_agt.sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);

	endtask
endclass

class underflow_test extends base_test;
wr_seq w_seq;
rd_seq r_seq;
	`uvm_component_utils(underflow_test)
	`NEW_COMP

	task run_phase(uvm_phase phase);
		w_seq = new("w_seq");
		r_seq = new("r_seq");
		phase.raise_objection(this);
		w_seq.wr_count = `DEPTH;
		r_seq.rd_count = `DEPTH+1;
		w_seq.start(env.w_agt.sqr);
		r_seq.start(env.r_agt.sqr);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);

	endtask
endclass

class con_wr_rd_test extends base_test;
wr_seq w_seq;
rd_seq r_seq;
	`uvm_component_utils(con_wr_rd_test)
	`NEW_COMP

	task run_phase(uvm_phase phase);
		w_seq = new("w_seq");
		r_seq = new("r_seq");
		phase.raise_objection(this);
		w_seq.wr_count = `DEPTH;
		r_seq.rd_count = `DEPTH;
		fork
		#(fifo_common::wr_delay) w_seq.start(env.w_agt.sqr);
		#(fifo_common::rd_delay) r_seq.start(env.r_agt.sqr);
		join
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);

	endtask
endclass
