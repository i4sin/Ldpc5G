class Test #(
    parameter CONTROL_WIDTH,
    parameter DATA_WIDTH
) extends BaseTest;
    `uvm_component_param_utils(Test#(CONTROL_WIDTH, DATA_WIDTH))

    localparam string CONTROL_PACKET_NAME = "control_packet";
    localparam string DATA_PACKET_NAME = "data_packet";

    typedef Env #(CONTROL_WIDTH, DATA_WIDTH) Env;
    typedef AxisMasterEncoderControlItem#(CONTROL_WIDTH) ControlPacket;
    typedef AxisMasterPacket#(DATA_WIDTH) DataPacket;
    typedef CountSeq#(ControlPacket, CONTROL_PACKET_NAME) ControlMasterSeq;
    typedef CountSeq#(DataPacket, DATA_PACKET_NAME) DataMasterSeq;
    typedef AxisMasterSeqr#(CONTROL_WIDTH) ControlMasterSeqr;
    typedef AxisMasterSeqr#(DATA_WIDTH) DataMasterSeqr;

    local Env env;

    local const int unsigned PACKETS_COUNT = 512;
    local const Range SIZE_WORDS_RANGE = Range::build_range("size_words_range", 16, 16);

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = Env::type_id::create("env", this);
    endfunction

    virtual task reset_phase(uvm_phase phase);
        ResetSeqr reset_seqr = env.get_reset_seqr();
        InitialResetSeq reset_seq = InitialResetSeq::type_id::create("reset_seq", reset_seqr);
        phase.raise_objection(this);
        reset_seq.start(reset_seqr);
        phase.drop_objection(this);
    endtask

    virtual task main_phase(uvm_phase phase);
        ControlMasterSeq control_master_seq = create_control_master_seq(env.get_control_master_seqr());
        DataMasterSeq data_master_seq = create_data_master_seq(env.get_data_master_seqr());
        AxisSlaveSeq control_slave_seq = AxisSlaveSeq::type_id::create("control_slave_seq", env.get_control_slave_seqr());
        AxisSlaveSeq data_slave_seq = AxisSlaveSeq::type_id::create("data_slave_seq", env.get_data_slave_seqr());

        phase.raise_objection(this);
        fork
            control_slave_seq.start(env.get_control_slave_seqr());
            data_slave_seq.start(env.get_data_slave_seqr());
        join_none
        fork
            control_master_seq.start(env.get_control_master_seqr());
            data_master_seq.start(env.get_data_master_seqr());
        join
        phase.drop_objection(this);
    endtask

    local function ControlMasterSeq create_control_master_seq(ControlMasterSeqr control_master_seqr);
        ControlMasterSeq control_master_seq = ControlMasterSeq::type_id::create("control_master_seq", control_master_seqr);
        ControlMasterSeq::set_count(control_master_seq.get_name(), control_master_seqr, PACKETS_COUNT);
        control_master_seq.set_sequencer(control_master_seqr);
        assert (control_master_seq.randomize());
        return control_master_seq;
    endfunction

    local function DataMasterSeq create_data_master_seq(DataMasterSeqr data_master_seqr);
        DataMasterSeq data_master_seq = DataMasterSeq::type_id::create("data_master_seq", data_master_seqr);
        DataMasterSeq::set_count(data_master_seq.get_name(), data_master_seqr, PACKETS_COUNT);
        DataPacket::set_size_words_range(DATA_PACKET_NAME, data_master_seqr, SIZE_WORDS_RANGE);
        data_master_seq.set_sequencer(data_master_seqr);
        assert (data_master_seq.randomize());
        return data_master_seq;
    endfunction
endclass
