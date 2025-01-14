class AnalysisCastMap #(
    type FROM_T,
    type TO_T
) extends AnalysisMap#(FROM_T, TO_T);
    `uvm_component_param_utils(AnalysisCastMap#(FROM_T, TO_T))

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void write(FROM_T from);
        TO_T to;
        if (!$cast(to, from)) `uvm_fatal("CAST MAP", "The types didn't match.")
        port.write(to);
    endfunction
endclass
