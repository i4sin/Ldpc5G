class AxisMasterAgent #(
    parameter DATA_WIDTH
) extends uvm_agent;
    `uvm_component_param_utils(AxisMasterAgent#(DATA_WIDTH))

    typedef uvm_analysis_port#(AxisTransaction#(DATA_WIDTH)) AnalysisPort;
    typedef virtual AxisIf#(DATA_WIDTH) Vif;
    typedef AxisMasterDriver#(DATA_WIDTH) Driver;
    typedef AxisMonitor#(DATA_WIDTH) Monitor;
    typedef AxisMasterSeqr#(DATA_WIDTH) Seqr;

    AnalysisPort port;

    local Driver driver;
    local Monitor monitor;
    local Seqr seqr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        port = new("port", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        driver = Driver::type_id::create("driver", this);
        monitor = Monitor::type_id::create("monitor", this);
        seqr = Seqr::type_id::create("seqr", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(seqr.seq_item_export);
        monitor.port.connect(port);
    endfunction

    function void set_vif(Vif vif);
        driver.set_vif(vif);
        monitor.set_vif(vif);
    endfunction

    function Seqr get_seqr();
        return seqr;
    endfunction
endclass
