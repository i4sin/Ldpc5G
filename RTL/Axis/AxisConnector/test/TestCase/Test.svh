class Test #(
    parameter DATA_WIDTH
) extends BaseTest;
    `uvm_component_param_utils(Test#(DATA_WIDTH))

    localparam string PACKET_NAME = "packet";
    localparam string SLAVE_ITEM_NAME = "slave_item";

    typedef Env #(DATA_WIDTH) Env;
    typedef AxisMasterPacket#(DATA_WIDTH) Packet;
    typedef CountSeq#(Packet, PACKET_NAME) MasterSeq;
    typedef InfiniteSeq#(AxisSlaveItem, SLAVE_ITEM_NAME) SlaveSeq;
    typedef AxisMasterSeqr#(DATA_WIDTH) MasterSeqr;

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
        MasterSeq master_seq = create_master_seq(env.get_master_seqr());
        SlaveSeq slave_seq = SlaveSeq::type_id::create("slave_seq", env.get_slave_seqr());

        phase.raise_objection(this);
        fork
            slave_seq.start(env.get_slave_seqr());
        join_none
        master_seq.start(env.get_master_seqr());
        phase.drop_objection(this);
    endtask

    local function MasterSeq create_master_seq(MasterSeqr master_seqr);
        MasterSeq master_seq = MasterSeq::type_id::create("master_seq", master_seqr);
        MasterSeq::set_count(master_seq.get_name(), master_seqr, PACKETS_COUNT);
        Packet::set_size_words_range(PACKET_NAME, master_seqr, SIZE_WORDS_RANGE);
        master_seq.set_sequencer(master_seqr);
        assert (master_seq.randomize());
        return master_seq;
    endfunction
endclass
