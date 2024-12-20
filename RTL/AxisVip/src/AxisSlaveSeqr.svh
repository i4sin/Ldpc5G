class AxisSlaveSeqr extends uvm_sequencer #(AxisSlaveItem);
    `uvm_component_utils(AxisSlaveSeqr)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
