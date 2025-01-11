class Test #(
    parameter CONTROL_WIDTH,
    parameter DATA_WIDTH
) extends BaseTest;
    `uvm_component_param_utils(Test#(CONTROL_WIDTH, DATA_WIDTH))

    typedef Env #(CONTROL_WIDTH, DATA_WIDTH) Env;
    typedef AxisMasterPacketSeq#(CONTROL_WIDTH) ControlMasterSeq;
    typedef AxisMasterPacketSeq#(DATA_WIDTH) DataMasterSeq;
    typedef AxisMasterSeqr#(CONTROL_WIDTH) ControlMasterSeqr;
    typedef AxisMasterSeqr#(DATA_WIDTH) DataMasterSeqr;

    local Env env;

    local const int unsigned PACKETS_COUNT = 512;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = Env::type_id::create("env", this);
        ConfigDb#(int unsigned)::set(this, "env.data_master_agent.seqr", "packets_count", PACKETS_COUNT);
        ConfigDb#(int unsigned)::set(this, "env.control_master_agent.seqr", "packets_count", PACKETS_COUNT);
    endfunction

    virtual task reset_phase(uvm_phase phase);
        ResetSeqr reset_seqr = env.get_reset_agent().get_seqr();
        InitialResetSeq reset_seq = InitialResetSeq::type_id::create("reset_seq", reset_seqr);
        phase.raise_objection(this);
        reset_seq.start(reset_seqr);
        phase.drop_objection(this);
    endtask

    virtual task main_phase(uvm_phase phase);
        ControlMasterSeqr control_master_seqr = env.get_control_master_agent().get_seqr();
        DataMasterSeqr data_master_seqr = env.get_data_master_agent().get_seqr();
        AxisSlaveSeqr control_slave_seqr = env.get_control_slave_agent().get_seqr();
        AxisSlaveSeqr data_slave_seqr = env.get_data_slave_agent().get_seqr();
        ControlMasterSeq control_master_seq = ControlMasterSeq::type_id::create("control_master_seq", data_master_seqr);
        DataMasterSeq data_master_seq = DataMasterSeq::type_id::create("data_master_seq", data_master_seqr);
        AxisSlaveSeq control_slave_seq = AxisSlaveSeq::type_id::create("control_slave_seq", data_master_seqr);
        AxisSlaveSeq data_slave_seq = AxisSlaveSeq::type_id::create("data_slave_seq", data_master_seqr);

        phase.raise_objection(this);
        fork
            control_slave_seq.start(control_slave_seqr);
            data_slave_seq.start(data_slave_seqr);
        join_none
        fork
            control_master_seq.start(control_master_seqr);
            data_master_seq.start(data_master_seqr);
        join
        phase.drop_objection(this);
    endtask
endclass
