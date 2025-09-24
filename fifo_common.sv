`define WIDTH 16
`define DEPTH 16
`define NEW_COMP\
function new(string name = "", uvm_component parent);\
	super.new(name,parent);\
endfunction
`define NEW_OBJ\
function new(string name = "");\
	super.new(name);\
endfunction

int num_matches;
int num_mis_matches;

class fifo_common;
static rand bit[2:0] wr_delay;
static rand bit[2:0] rd_delay;
endclass
