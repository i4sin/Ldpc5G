class Env #(
    parameter DATA_WIDTH
) extends uvm_env;
    `uvm_component_param_utils(Env#(DATA_WIDTH))

    typedef virtual ResetIf ResetVif;
    typedef virtual AxisIf#(DATA_WIDTH) Vif;
    typedef AxisMasterAgent#(DATA_WIDTH) MasterAgent;
    typedef AxisSlaveAgent#(DATA_WIDTH) SlaveAgent;
    typedef Scoreboard#(DATA_WIDTH) Scoreboard;

    local ResetVif reset_vif;
    local Vif s_axis_vif;
    local Vif m_axis_vif;
    local ResetAgent reset_agent;
    local MasterAgent master_agent;
    local SlaveAgent slave_agent;
    local Scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        reset_agent = ResetAgent::type_id::create("reset_agent", this);
        master_agent = MasterAgent::type_id::create("master_agent", this);
        slave_agent = SlaveAgent::type_id::create("slave_agent", this);
        scoreboard = Scoreboard::type_id::create("scoreboard", this);
        ConfigDb#(ResetVif)::get(this, "", "reset_vif", reset_vif);
        ConfigDb#(Vif)::get(this, "", "s_axis_vif", s_axis_vif);
        ConfigDb#(Vif)::get(this, "", "m_axis_vif", m_axis_vif);
        ConfigDb#(ResetVif)::set(this, "reset_agent", "vif", reset_vif);
        ConfigDb#(Vif)::set(this, "master_agent", "vif", s_axis_vif);
        ConfigDb#(Vif)::set(this, "slave_agent", "vif", m_axis_vif);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        master_agent.analysis_port.connect(scoreboard.input_analysis_fifo.analysis_export);
        slave_agent.analysis_port.connect(scoreboard.output_analysis_fifo.analysis_export);
    endfunction

    function ResetAgent get_reset_agent();
        return reset_agent;
    endfunction

    function MasterAgent get_master_agent();
        return master_agent;
    endfunction

    function SlaveAgent get_slave_agent();
        return slave_agent;
    endfunction
endclass