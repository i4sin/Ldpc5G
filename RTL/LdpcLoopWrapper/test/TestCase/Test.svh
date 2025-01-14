import LDPC_IP_CONTROL_PKG::*;

class Test #(
    parameter CONTROL_STATUS_WIDTH,
    parameter DATA_WIDTH
) extends BaseTest;
    `uvm_component_param_utils(Test#(CONTROL_STATUS_WIDTH, DATA_WIDTH))

    localparam string ENCODER_CONTROL_ITEM_NAME = "encoder_control_item";
    localparam string DECODER_CONTROL_ITEM_NAME = "decoder_control_item";
    localparam string DATA_PACKET_NAME = "data_packet";

    typedef Env #(CONTROL_STATUS_WIDTH, DATA_WIDTH) Env;
    typedef EncoderControlItem#(CONTROL_STATUS_WIDTH) ControlItem;
    typedef AxisMasterPacket#(DATA_WIDTH) DataPacket;
    typedef CountSeq#(ControlItem, ENCODER_CONTROL_ITEM_NAME) EncoderControlMasterSeq;
    typedef CountSeq#(ControlItem, DECODER_CONTROL_ITEM_NAME) DecoderControlMasterSeq;
    typedef CountSeq#(DataPacket, DATA_PACKET_NAME) DataMasterSeq;
    typedef AxisMasterSeqr#(CONTROL_STATUS_WIDTH) ControlMasterSeqr;
    typedef AxisMasterSeqr#(DATA_WIDTH) DataMasterSeqr;

    local Env env;
    local ControlCfg encoder_control_cfg;
    local ControlCfg decoder_control_cfg;

    local const int unsigned PACKETS_COUNT = 512;
    local const Range SIZE_WORDS_RANGE = Range::build_range("size_words_range", 16, 16);

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = Env::type_id::create("env", this);
        encoder_control_cfg = ControlCfg::type_id::create("encoder_control_cfg", this);
        decoder_control_cfg = ControlCfg::type_id::create("decoder_control_cfg", this);
    endfunction

    virtual task reset_phase(uvm_phase phase);
        ResetSeqr reset_seqr = env.get_reset_seqr();
        InitialResetSeq reset_seq = InitialResetSeq::type_id::create("reset_seq", reset_seqr);
        phase.raise_objection(this);
        reset_seq.start(reset_seqr);
        phase.drop_objection(this);
    endtask

    virtual task main_phase(uvm_phase phase);
        EncoderControlMasterSeq encoder_control_master_seq = create_encoder_control_master_seq(env.get_encoder_control_master_seqr());
        DecoderControlMasterSeq decoder_control_master_seq = create_decoder_control_master_seq(env.get_decoder_control_master_seqr());
        DataMasterSeq data_master_seq = create_data_master_seq(env.get_data_master_seqr());
        AxisSlaveSeq encoder_status_slave_seq = AxisSlaveSeq::type_id::create("encoder_status_slave_seq", env.get_decoder_status_slave_seqr());
        AxisSlaveSeq decoder_status_slave_seq = AxisSlaveSeq::type_id::create("decoder_status_slave_seq", env.get_decoder_status_slave_seqr());
        AxisSlaveSeq data_slave_seq = AxisSlaveSeq::type_id::create("data_slave_seq", env.get_data_slave_seqr());

        phase.raise_objection(this);
        fork
            encoder_status_slave_seq.start(env.get_encoder_status_slave_seqr());
            decoder_status_slave_seq.start(env.get_decoder_status_slave_seqr());
            data_slave_seq.start(env.get_data_slave_seqr());
        join_none
        fork
            encoder_control_master_seq.start(env.get_encoder_control_master_seqr());
            decoder_control_master_seq.start(env.get_decoder_control_master_seqr());
            data_master_seq.start(env.get_data_master_seqr());
        join
        phase.drop_objection(this);
    endtask

    local function EncoderControlMasterSeq create_encoder_control_master_seq(ControlMasterSeqr encoder_control_master_seqr);
        EncoderControlMasterSeq encoder_control_master_seq = EncoderControlMasterSeq::type_id::create("encoder_control_master_seq", encoder_control_master_seqr);
        EncoderControlMasterSeq::set_count(encoder_control_master_seq.get_name(), encoder_control_master_seqr, PACKETS_COUNT);
        encoder_control_master_seq.set_sequencer(encoder_control_master_seqr);
        assert (encoder_control_master_seq.randomize());
        set_encoder_control_cfg(encoder_control_master_seqr);
        return encoder_control_master_seq;
    endfunction

    local function DecoderControlMasterSeq create_decoder_control_master_seq(ControlMasterSeqr decoder_control_master_seqr);
        DecoderControlMasterSeq decoder_control_master_seq = DecoderControlMasterSeq::type_id::create("decoder_control_master_seq", decoder_control_master_seqr);
        DecoderControlMasterSeq::set_count(decoder_control_master_seq.get_name(), decoder_control_master_seqr, PACKETS_COUNT);
        decoder_control_master_seq.set_sequencer(decoder_control_master_seqr);
        assert (decoder_control_master_seq.randomize());
        set_decoder_control_cfg(decoder_control_master_seqr);
        return decoder_control_master_seq;
    endfunction

    local function DataMasterSeq create_data_master_seq(DataMasterSeqr data_master_seqr);
        DataMasterSeq data_master_seq = DataMasterSeq::type_id::create("data_master_seq", data_master_seqr);
        DataMasterSeq::set_count(data_master_seq.get_name(), data_master_seqr, PACKETS_COUNT);
        DataPacket::set_size_words_range(DATA_PACKET_NAME, data_master_seqr, SIZE_WORDS_RANGE);
        data_master_seq.set_sequencer(data_master_seqr);
        assert (data_master_seq.randomize());
        return data_master_seq;
    endfunction

    local function void set_encoder_control_cfg(ControlMasterSeqr encoder_control_master_seqr);
        assert (encoder_control_cfg.randomize() with {
            max_schedule == MAX_SCHEDULE;
            mb == MB;
            max_iterations == MAX_ITERATIONS;
            term_on_no_change == TERM_ON_NO_CHANGE;
            term_on_pass == TERM_ON_PASS;
            include_parity_op == INCLUDE_PARITY_OP;
            hard_op == HARD_OP;
            ms_offset == MS_OFFSET;
            bg == BG;
            z_set == Z_SET;
            z_j == Z_J;
        });
        ControlItem::set_cfg(ENCODER_CONTROL_ITEM_NAME, encoder_control_master_seqr, encoder_control_cfg);
    endfunction

    local function void set_decoder_control_cfg(ControlMasterSeqr decoder_control_master_seqr);
        assert (decoder_control_cfg.randomize() with {
            max_schedule == MAX_SCHEDULE;
            mb == MB;
            max_iterations == MAX_ITERATIONS;
            term_on_no_change == TERM_ON_NO_CHANGE;
            term_on_pass == TERM_ON_PASS;
            include_parity_op == INCLUDE_PARITY_OP;
            hard_op == HARD_OP;
            ms_offset == MS_OFFSET;
            bg == BG;
            z_set == Z_SET;
            z_j == Z_J;
        });
        ControlItem::set_cfg(DECODER_CONTROL_ITEM_NAME, decoder_control_master_seqr, decoder_control_cfg);
    endfunction
endclass
