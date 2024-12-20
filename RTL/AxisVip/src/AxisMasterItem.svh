class AxisMasterItem #(
    parameter DATA_WIDTH
) extends uvm_sequence_item;
    `uvm_object_utils(AxisMasterItem#(DATA_WIDTH))

    rand int delay;
    constraint c_delay {
        delay inside {[0:10]};
    }

    rand logic [DATA_WIDTH-1:0] tdata;
    rand logic [DATA_WIDTH/8-1:0] tkeep;
    rand logic tlast;

    function new(string name = "AxisMasterItem");
        super.new(name);
    endfunction
endclass