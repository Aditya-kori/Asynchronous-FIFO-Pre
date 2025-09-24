class rd_drv extends uvm_driver#(fifo_tx);
virtual fifo_intrf vif;
	`uvm_component_utils(rd_drv)
	`NEW_COMP

	function void build();
		uvm_config_db#(virtual fifo_intrf)::get(this,"","VIF",vif);
	endfunction

	task run();
		forever begin
			seq_item_port.get_next_item(req);
			`uvm_info("DRV","inside run of driver",UVM_LOW)
			drive_tx(req);
			req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(fifo_tx tx);
		@(vif.rd_drv_cb);
		vif.rd_drv_cb.rd_en <= tx.rd_en;
		tx.rdata = vif.rd_drv_cb.rdata;
		tx.empty = vif.rd_drv_cb.empty;
		tx.underflow = vif.rd_drv_cb.underflow;
		@(vif.rd_drv_cb);
		vif.rd_drv_cb.rd_en <= 0;
	endtask
endclass
