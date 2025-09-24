class wr_agent extends uvm_agent;
	wr_sqr sqr;
	wr_drv drv;
	`uvm_component_utils(wr_agent)
	`NEW_COMP

	function void build();
		sqr = wr_sqr :: type_id :: create("sqr", this);
		drv = wr_drv :: type_id :: create("drv", this);
	endfunction

	function void connect();
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction
endclass
