virtual class Monitor #(
    type Vif,
    type Transaction
) extends uvm_monitor;
    `uvm_component_param_utils(Monitor#(Vif, Transaction))

    typedef uvm_analysis_port#(Transaction) AnalysisPort;

    AnalysisPort analysis_port;

    protected Vif vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    function void set_vif(Vif vif);
        this.vif = vif;
    endfunction

    virtual function void post_connect_phase(uvm_phase phase);
        assert (vif != null);
    endfunction
endclass
