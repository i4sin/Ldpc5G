class Env #(
    parameter CONTROL_STATUS_WIDTH,
    parameter DATA_WIDTH
) extends uvm_env;
    `uvm_component_param_utils(Env#(CONTROL_STATUS_WIDTH, DATA_WIDTH))

    typedef virtual ResetIf ResetVif;
    typedef virtual AxisIf#(CONTROL_STATUS_WIDTH) ControlStatusVif;
    typedef virtual AxisIf#(DATA_WIDTH) DataVif;

    typedef AxisMasterAgent#(CONTROL_STATUS_WIDTH) ControlStatusMasterAgent;
    typedef AxisMasterAgent#(DATA_WIDTH) DataMasterAgent;
    typedef AxisSlaveAgent#(CONTROL_STATUS_WIDTH) StatusSlaveAgent;
    typedef AxisSlaveAgent#(DATA_WIDTH) DataSlaveAgent;

    typedef AxisMasterSeqr#(CONTROL_STATUS_WIDTH) ControlStatusMasterSeqr;
    typedef AxisMasterSeqr#(DATA_WIDTH) DataMasterSeqr;

    typedef Scoreboard#(CONTROL_STATUS_WIDTH, DATA_WIDTH) Scoreboard;

    local ResetVif reset_vif;
    local ControlStatusVif s_axis_encoder_control_vif;
    local ControlStatusVif s_axis_decoder_control_vif;
    local ControlStatusVif m_axis_encoder_status_vif;
    local ControlStatusVif m_axis_decoder_status_vif;
    local DataVif s_axis_din_vif;
    local DataVif m_axis_dout_vif;

    local ResetAgent reset_agent;
    local ControlStatusMasterAgent encoder_control_master_agent;
    local ControlStatusMasterAgent decoder_control_master_agent;
    local DataMasterAgent data_master_agent;
    local StatusSlaveAgent encoder_status_slave_agent;
    local StatusSlaveAgent decoder_status_slave_agent;
    local DataSlaveAgent data_slave_agent;
    local Scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        reset_agent = ResetAgent::type_id::create("reset_agent", this);
        encoder_control_master_agent = ControlStatusMasterAgent::type_id::create("encoder_control_master_agent", this);
        decoder_control_master_agent = ControlStatusMasterAgent::type_id::create("decoder_control_master_agent", this);
        data_master_agent = DataMasterAgent::type_id::create("data_master_agent", this);
        encoder_status_slave_agent = StatusSlaveAgent::type_id::create("encoder_status_slave_agent", this);
        decoder_status_slave_agent = StatusSlaveAgent::type_id::create("decoder_status_slave_agent", this);
        data_slave_agent = DataSlaveAgent::type_id::create("data_slave_agent", this);
        scoreboard = Scoreboard::type_id::create("scoreboard", this);

        ConfigDb#(ResetVif)::get(this, "", "reset_vif", reset_vif);
        ConfigDb#(ControlStatusVif)::get(this, "", "s_axis_encoder_control_vif", s_axis_encoder_control_vif);
        ConfigDb#(ControlStatusVif)::get(this, "", "s_axis_decoder_control_vif", s_axis_decoder_control_vif);
        ConfigDb#(ControlStatusVif)::get(this, "", "m_axis_encoder_status_vif", m_axis_encoder_status_vif);
        ConfigDb#(ControlStatusVif)::get(this, "", "m_axis_decoder_status_vif", m_axis_decoder_status_vif);
        ConfigDb#(DataVif)::get(this, "", "s_axis_din_vif", s_axis_din_vif);
        ConfigDb#(DataVif)::get(this, "", "m_axis_dout_vif", m_axis_dout_vif);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        reset_agent.set_vif(reset_vif);
        encoder_control_master_agent.set_vif(s_axis_encoder_control_vif);
        decoder_control_master_agent.set_vif(s_axis_decoder_control_vif);
        data_master_agent.set_vif(s_axis_din_vif);
        encoder_status_slave_agent.set_vif(m_axis_encoder_status_vif);
        decoder_status_slave_agent.set_vif(m_axis_decoder_status_vif);
        data_slave_agent.set_vif(m_axis_dout_vif);
        encoder_control_master_agent.port.connect(scoreboard.encoder_control_export);
        decoder_control_master_agent.port.connect(scoreboard.decoder_control_export);
        data_master_agent.port.connect(scoreboard.input_data_export);
        encoder_status_slave_agent.port.connect(scoreboard.encoder_status_export);
        decoder_status_slave_agent.port.connect(scoreboard.decoder_status_export);
        data_slave_agent.port.connect(scoreboard.output_data_export);
    endfunction

    function ResetSeqr get_reset_seqr();
        return reset_agent.get_seqr();
    endfunction

    function ControlStatusMasterSeqr get_encoder_control_master_seqr();
        return encoder_control_master_agent.get_seqr();
    endfunction

    function ControlStatusMasterSeqr get_decoder_control_master_seqr();
        return decoder_control_master_agent.get_seqr();
    endfunction

    function DataMasterSeqr get_data_master_seqr();
        return data_master_agent.get_seqr();
    endfunction

    function AxisSlaveSeqr get_encoder_status_slave_seqr();
        return encoder_status_slave_agent.get_seqr();
    endfunction

    function AxisSlaveSeqr get_decoder_status_slave_seqr();
        return decoder_status_slave_agent.get_seqr();
    endfunction

    function AxisSlaveSeqr get_data_slave_seqr();
        return data_slave_agent.get_seqr();
    endfunction
endclass