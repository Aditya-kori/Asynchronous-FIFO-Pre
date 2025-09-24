class rd_agent extends uvm_agent;
	rd_sqr sqr;
	rd_drv drv;
	`uvm_component_utils(rd_agent)
	`NEW_COMP

	function void build();
		sqr = rd_sqr :: type_id :: create("sqr", this);
		drv = rd_drv :: type_id :: create("drv", this);
	endfunction

	function void connect();
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction
endclass
