vlog top.sv \
+incdir+C:/uvm-1.2/uvm-1.2/src

vsim -novopt -suppress 12110 top \
-sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi 

add wave -position -insertpoint sim:/top/pif/*

run -all
