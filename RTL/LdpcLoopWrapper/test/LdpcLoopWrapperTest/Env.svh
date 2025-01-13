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
    typedef AxisSlaveAgent#(CONTROL_WIDTH) StatusSlaveAgent;
    typedef AxisSlaveAgent#(DATA_WIDTH) DataSlaveAgent;

    typedef AxisMasterSeqr#(CONTROL_WIDTH) ControlMasterSeqr;
    typedef AxisMasterSeqr#(DATA_WIDTH) DataMasterSeqr;

    typedef Scoreboard#(CONTROL_WIDTH, DATA_WIDTH) Scoreboard;

    local ResetVif reset_vif;
    local ControlVif s_axis_encoder_control_vif;
    local ControlVif m_axis_decoder_status_vif;
    local DataVif s_axis_data_vif;
    local DataVif m_axis_data_vif;

    local ResetAgent reset_agent;
    local ControlMasterAgent encoder_control_master_agent;
    local DataMasterAgent data_master_agent;
    local StatusSlaveAgent decoder_status_slave_agent;
    local DataSlaveAgent data_slave_agent;
    local Scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        reset_agent = ResetAgent::type_id::create("reset_agent", this);
        encoder_control_master_agent = ControlMasterAgent::type_id::create("encoder_control_master_agent", this);
        data_master_agent = DataMasterAgent::type_id::create("data_master_agent", this);
        decoder_status_slave_agent = StatusSlaveAgent::type_id::create("decoder_status_slave_agent", this);
        data_slave_agent = DataSlaveAgent::type_id::create("data_slave_agent", this);
        scoreboard = Scoreboard::type_id::create("scoreboard", this);

        ConfigDb#(ResetVif)::get(this, "", "reset_vif", reset_vif);
        ConfigDb#(ControlVif)::get(this, "", "s_axis_encoder_control_vif", s_axis_encoder_control_vif);
        ConfigDb#(ControlVif)::get(this, "", "m_axis_decoder_status_vif", m_axis_decoder_status_vif);
        ConfigDb#(DataVif)::get(this, "", "s_axis_data_vif", s_axis_data_vif);
        ConfigDb#(DataVif)::get(this, "", "m_axis_data_vif", m_axis_data_vif);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        reset_agent.set_vif(reset_vif);
        encoder_control_master_agent.set_vif(s_axis_encoder_control_vif);
        data_master_agent.set_vif(s_axis_data_vif);
        decoder_status_slave_agent.set_vif(m_axis_decoder_status_vif);
        data_slave_agent.set_vif(m_axis_data_vif);
        encoder_control_master_agent.analysis_port.connect(scoreboard.input_control_fifo.analysis_export);
        data_master_agent.analysis_port.connect(scoreboard.input_data_fifo.analysis_export);
        decoder_status_slave_agent.analysis_port.connect(scoreboard.output_control_fifo.analysis_export);
        data_slave_agent.analysis_port.connect(scoreboard.output_data_fifo.analysis_export);
    endfunction

    function ResetSeqr get_reset_seqr();
        return reset_agent.get_seqr();
    endfunction

    function ControlMasterSeqr get_encoder_control_master_seqr();
        return encoder_control_master_agent.get_seqr();
    endfunction

    function DataMasterSeqr get_data_master_seqr();
        return data_master_agent.get_seqr();
    endfunction

    function AxisSlaveSeqr get_decoder_status_slave_seqr();
        return decoder_status_slave_agent.get_seqr();
    endfunction

    function AxisSlaveSeqr get_data_slave_seqr();
        return data_slave_agent.get_seqr();
    endfunction
endclass