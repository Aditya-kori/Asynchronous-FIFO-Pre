class fifo_env extends uvm_env;
fifo_mon mon;
fifo_cov cov;
fifo_sbd sbd;
wr_agent w_agt;
rd_agent r_agt;
	`uvm_component_utils(fifo_env)
	`NEW_COMP

	function void build();
		mon = fifo_mon :: type_id :: create("mon", this);
		cov = fifo_cov :: type_id :: create("cov", this);
		sbd = fifo_sbd :: type_id :: create("sbd", this);
		w_agt = wr_agent :: type_id :: create("w_agt", this);
		r_agt = rd_agent :: type_id :: create("r_agt", this);
	endfunction

	function void connect();
		mon.analysis_port.connect(cov.analysis_export);
		mon.analysis_port.connect(sbd.analysis_imp);
	endfunction
endclass
