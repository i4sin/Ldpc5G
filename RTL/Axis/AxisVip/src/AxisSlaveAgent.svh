class AxisSlaveAgent #(
    parameter DATA_WIDTH
) extends uvm_agent;
    `uvm_component_param_utils(AxisSlaveAgent#(DATA_WIDTH))

    typedef uvm_analysis_port#(AxisTransaction#(DATA_WIDTH)) AnalysisPort;
    typedef virtual AxisIf#(DATA_WIDTH) Vif;
    typedef AxisSlaveDriver #(DATA_WIDTH) Driver;
    typedef AxisMonitor#(DATA_WIDTH) Monitor;
    typedef AxisSlaveSeqr Seqr;

    AnalysisPort analysis_port;

    local Vif vif;
    local Driver driver;
    local Monitor monitor;
    local Seqr seqr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        driver = Driver::type_id::create("driver", this);
        monitor = Monitor::type_id::create("monitor", this);
        seqr = Seqr::type_id::create("seqr", this);
        ConfigDb#(Vif)::get(this, "", "vif", vif);
        ConfigDb#(Vif)::set(this, "driver", "vif", vif);
        ConfigDb#(Vif)::set(this, "monitor", "vif", vif);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(seqr.seq_item_export);
        monitor.analysis_port.connect(analysis_port);
    endfunction

    function Seqr get_seqr();
        return seqr;
    endfunction
endclass
