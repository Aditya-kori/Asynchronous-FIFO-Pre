class wr_drv extends uvm_driver#(fifo_tx);
virtual fifo_intrf vif;
	`uvm_component_utils(wr_drv)
	`NEW_COMP

	function void build();
		uvm_config_db#(virtual fifo_intrf)::get(this,"","VIF",vif);
	endfunction

	task run();
	wait(vif.rst == 0)
		forever begin
			seq_item_port.get_next_item(req);
			`uvm_info("DRV","inside run of driver",UVM_LOW)
			drive_tx(req);
			req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(fifo_tx tx);
		@(vif.wr_drv_cb);
		vif.wr_drv_cb.wr_en <= tx.wr_en;
		vif.wr_drv_cb.wdata <= tx.wdata;
		@(vif.wr_drv_cb);
		tx.full = vif.wr_drv_cb.full;
		tx.overflow = vif.wr_drv_cb.overflow;
		@(vif.wr_drv_cb);
		vif.wr_drv_cb.wr_en <= 0;
		vif.wr_drv_cb.wdata <= 0;
	endtask
endclass
