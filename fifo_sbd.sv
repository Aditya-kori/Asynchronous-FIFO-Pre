class fifo_sbd extends uvm_scoreboard;
fifo_tx tx;
bit [`WIDTH-1:0] dataQ[$];
bit [`WIDTH-1:0] exp_data;
uvm_analysis_imp#(fifo_tx, fifo_sbd) analysis_imp;
	`uvm_component_utils(fifo_sbd)
	`NEW_COMP
	
	function void build();
		analysis_imp = new("analysis_imp", this);
	endfunction 

	function void write(fifo_tx t);
	$cast(tx,t);
		if(tx.wr_en) begin
			dataQ.push_back(tx.wdata);
		end
		if(tx.rd_en) begin
			exp_data = dataQ.pop_front();
			if(exp_data == tx.rdata) num_matches++;
			else num_mis_matches++;
		end
	endfunction

endclass
