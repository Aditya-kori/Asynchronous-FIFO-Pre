class fifo_cov extends uvm_subscriber#(fifo_tx);
fifo_tx tx;
event fifo_cg_e;
	`uvm_component_utils(fifo_cov)

	covergroup fifo_cg;
		WRITE: coverpoint tx.wr_en{
			bins WRITE = {1'b1};
			bins others = default;
		}
		READ: coverpoint tx.rd_en{
			bins READ = {1'b1};
			bins others = default;
		}
		FULL: coverpoint tx.full{
			bins full_i = {1'b1};
			bins N_full_i = {1'b0};
		}
		OVERFLOW : coverpoint tx.overflow{
			bins overflow_i = {1'b1};
			bins N_overflow_i = {1'b0};
		}
		EMPTY: coverpoint tx.empty{
			bins empty_i= {1'b1};
			bins N_empty= {1'b0};
		}
		UNDERFLOW: coverpoint tx.underflow{
			bins underflow_i= {1'b1};
			bins N_underflow_i= {1'b0};
		}
	endgroup
	
	function new(string name="", uvm_component parent);
		super.new(name,parent);
		fifo_cg = new();
	endfunction
	virtual function void write(fifo_tx t);
	//	tx = new t;
		$cast(tx,t);
		`uvm_info("COV","tx inside coverage",UVM_LOW)
		tx.print();
		fifo_cg.sample();
		//->fifo_cg_e;
	endfunction

endclass
