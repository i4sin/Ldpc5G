class AxisMonitor #(
    parameter DATA_WIDTH
) extends uvm_monitor;
    `uvm_component_param_utils(AxisMonitor#(DATA_WIDTH))

    typedef uvm_analysis_port#(AxisTransaction#(DATA_WIDTH)) AnalysisPort;
    typedef virtual AxisIf#(DATA_WIDTH) Vif;
    typedef AxisMasterTransaction#(DATA_WIDTH) Transaction;

    AnalysisPort analysis_port;

    local Vif vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        ConfigDb#(Vif)::get(this, "", "vif", vif);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.aclk);
            if (vif.transfer()) capture_transaction();
        end
    endtask

    virtual function void capture_transaction();
        Transaction transaction = Transaction::type_id::create("transaction", this);
        transaction.tdata = vif.tdata;
        transaction.tkeep = vif.tkeep;
        transaction.tlast = vif.tlast;
        analysis_port.write(transaction);
    endfunction
endclass
