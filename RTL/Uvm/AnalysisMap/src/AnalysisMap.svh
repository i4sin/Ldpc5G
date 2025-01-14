virtual class AnalysisMap #(
    type FROM_T,
    type TO_T
) extends uvm_component;
    `uvm_component_param_utils(AnalysisMap#(FROM_T, TO_T))

    typedef AnalysisMap#(FROM_T, TO_T) AnalysisMap;
    typedef uvm_analysis_imp#(FROM_T, AnalysisMap) AnalysisImp;
    typedef uvm_analysis_port#(TO_T) AnalysisPort;

    AnalysisImp imp;
    AnalysisPort port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        imp = new("imp", this);
        port = new("port", this);
    endfunction

    pure virtual function void write(FROM_T from);
endclass
