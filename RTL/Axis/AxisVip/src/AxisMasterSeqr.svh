class AxisMasterSeqr #(
    parameter DATA_WIDTH
) extends uvm_sequencer #(AxisMasterItem#(DATA_WIDTH));
    `uvm_component_param_utils(AxisMasterSeqr#(DATA_WIDTH))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
