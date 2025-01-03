class Env #(
    parameter DATA_WIDTH
) extends uvm_env;
    `uvm_component_utils(Env#(DATA_WIDTH))

    typedef AxisMasterAgent#(DATA_WIDTH) MasterAgent;
    typedef AxisSlaveAgent#(DATA_WIDTH) SlaveAgent;
    typedef Scoreboard#(DATA_WIDTH) Scoreboard;

    local MasterAgent master_agent;
    local SlaveAgent slave_agent;
    local Scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        master_agent = MasterAgent::type_id::create("master_agent", this);
        slave_agent = SlaveAgent::type_id::create("slave_agent", this);
        scoreboard = Scoreboard::type_id::create("scoreboard", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        master_agent.analysis_port.connect(scoreboard.input_analysis_fifo.analysis_export);
        slave_agent.analysis_port.connect(scoreboard.output_analysis_fifo.analysis_export);
    endfunction
endclass