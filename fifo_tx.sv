class fifo_tx extends uvm_sequence_item;
	rand bit wr_en;
	rand bit rd_en;
	rand bit [`WIDTH-1:0]wdata;
		 bit [`WIDTH-1:0]rdata;
		 bit full,empty,overflow,underflow;

	`uvm_object_utils_begin(fifo_tx)
		`uvm_field_int(wr_en,UVM_ALL_ON | UVM_NOPACK)
		`uvm_field_int(rd_en,UVM_ALL_ON | UVM_NOPACK)
		`uvm_field_int(wdata,UVM_ALL_ON | UVM_NOPACK)
		`uvm_field_int(rdata,UVM_ALL_ON | UVM_NOPACK)
		`uvm_field_int(full,UVM_ALL_ON | UVM_NOPACK)
		`uvm_field_int(empty,UVM_ALL_ON | UVM_NOPACK)
		`uvm_field_int(overflow,UVM_ALL_ON | UVM_NOPACK)
		`uvm_field_int(underflow,UVM_ALL_ON | UVM_NOPACK)
	`uvm_object_utils_end
	`NEW_OBJ
endclass
