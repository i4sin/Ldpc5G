class Env #(
    parameter CONTROL_WIDTH,
    parameter DATA_WIDTH
) extends uvm_env;
    `uvm_component_param_utils(Env#(CONTROL_WIDTH, DATA_WIDTH))

    typedef virtual ResetIf ResetVif;
    typedef virtual AxisIf#(CONTROL_WIDTH) ControlVif;
    typedef virtual AxisIf#(DATA_WIDTH) DataVif;
    typedef AxisMasterAgent#(CONTROL_WIDTH) ControlMasterAgent;
    typedef AxisMasterAgent#(DATA_WIDTH) DataMasterAgent;
    typedef AxisSlaveAgent#(CONTROL_WIDTH) ControlSlaveAgent;
    typedef AxisSlaveAgent#(DATA_WIDTH) DataSlaveAgent;
    typedef Scoreboard#(CONTROL_WIDTH, DATA_WIDTH) Scoreboard;

    local ResetVif reset_vif;
    local ControlVif s_axis_control_vif;
    local ControlVif m_axis_control_vif;
    local DataVif s_axis_data_vif;
    local DataVif m_axis_data_vif;

    local ResetAgent reset_agent;
    local ControlMasterAgent control_master_agent;
    local DataMasterAgent data_master_agent;
    local ControlSlaveAgent control_slave_agent;
    local DataSlaveAgent data_slave_agent;
    local Scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        reset_agent = ResetAgent::type_id::create("reset_agent", this);
        control_master_agent = ControlMasterAgent::type_id::create("control_master_agent", this);
        data_master_agent = DataMasterAgent::type_id::create("data_master_agent", this);
        control_slave_agent = ControlSlaveAgent::type_id::create("control_slave_agent", this);
        data_slave_agent = DataSlaveAgent::type_id::create("data_slave_agent", this);
        scoreboard = Scoreboard::type_id::create("scoreboard", this);

        ConfigDb#(ResetVif)::get(this, "", "reset_vif", reset_vif);

        ConfigDb#(ControlVif)::get(this, "", "s_axis_control_vif", s_axis_control_vif);
        ConfigDb#(ControlVif)::get(this, "", "m_axis_control_vif", m_axis_control_vif);
        ConfigDb#(DataVif)::get(this, "", "s_axis_data_vif", s_axis_data_vif);
        ConfigDb#(DataVif)::get(this, "", "m_axis_data_vif", m_axis_data_vif);

        ConfigDb#(ResetVif)::set(this, "reset_agent", "vif", reset_vif);

        ConfigDb#(ControlVif)::set(this, "control_master_agent", "vif", s_axis_control_vif);
        ConfigDb#(ControlVif)::set(this, "control_slave_agent", "vif", m_axis_control_vif);
        ConfigDb#(DataVif)::set(this, "data_master_agent", "vif", s_axis_data_vif);
        ConfigDb#(DataVif)::set(this, "data_slave_agent", "vif", m_axis_data_vif);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        control_master_agent.analysis_port.connect(scoreboard.input_control_fifo.analysis_export);
        data_master_agent.analysis_port.connect(scoreboard.input_data_fifo.analysis_export);
        control_slave_agent.analysis_port.connect(scoreboard.output_control_fifo.analysis_export);
        data_slave_agent.analysis_port.connect(scoreboard.output_data_fifo.analysis_export);
    endfunction

    function ResetAgent get_reset_agent();
        return reset_agent;
    endfunction

    function ControlMasterAgent get_control_master_agent();
        return control_master_agent;
    endfunction

    function DataMasterAgent get_data_master_agent();
        return data_master_agent;
    endfunction

    function ControlSlaveAgent get_control_slave_agent();
        return control_slave_agent;
    endfunction

    function DataSlaveAgent get_data_slave_agent();
        return data_slave_agent;
    endfunction
endclass