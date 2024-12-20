class AxisMasterSequencer #(
    parameter DATA_WIDTH
) extends uvm_sequencer #(AxisMasterItem#(DATA_WIDTH));
    `uvm_component_utils(AxisMasterSequencer#(DATA_WIDTH))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
