class fifo_mon extends uvm_monitor;
fifo_tx wr_tx, rd_tx;
virtual fifo_intrf vif;
uvm_analysis_port#(fifo_tx) analysis_port;
	`uvm_component_utils(fifo_mon)
	`NEW_COMP
	
	function void build();
		uvm_config_db#(virtual fifo_intrf)::get(this,"","VIF",vif);
		analysis_port = new("analysis_port", this);
		wr_tx = new("wr_tx");
		rd_tx = new("rd_tx");
	endfunction

	task run();
	fork
		forever begin
			@(vif.wr_mon_cb);
			if(vif.wr_mon_cb.wr_en) begin
				wr_tx = new("wr_tx");
				wr_tx.wr_en = vif.wr_mon_cb.wr_en;
				wr_tx.wdata = vif.wr_mon_cb.wdata;
				wr_tx.full  = vif.wr_mon_cb.full;
				wr_tx.overflow = vif.wr_mon_cb.overflow;
				`uvm_info("MON","inside run_task of mon",UVM_LOW)
				wr_tx.print();
				analysis_port.write(wr_tx);
			end
		end
		forever begin
			@(vif.rd_mon_cb);
			if(vif.rd_mon_cb.rd_en) begin
				rd_tx = new("rd_tx");
				rd_tx.rd_en = vif.rd_mon_cb.rd_en;
			@(vif.rd_mon_cb);
				rd_tx.rdata = vif.rd_mon_cb.rdata;
				rd_tx.empty = vif.rd_mon_cb.empty;
				rd_tx.underflow = vif.rd_mon_cb.underflow;
				`uvm_info("MON","inside run_task of mon",UVM_LOW)
				rd_tx.print();
				analysis_port.write(rd_tx);
			end
		end
	join
	endtask
endclass
