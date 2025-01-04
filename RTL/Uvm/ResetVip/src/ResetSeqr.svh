class ResetSeqr extends uvm_sequencer #(ResetItem);
    `uvm_component_utils(ResetSeqr)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
