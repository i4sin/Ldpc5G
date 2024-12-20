class AxisTransaction #(
    parameter DATA_WIDTH
) extends uvm_transaction;
    `uvm_object_utils(AxisTransaction#(DATA_WIDTH))

    logic [DATA_WIDTH-1:0] tdata;
    logic [DATA_WIDTH/8-1:0] tkeep;
    logic tlast;

    function new(string name = "AxisTransaction");
        super.new(name);
    endfunction
endclass
