class Test #(
    parameter DATA_WIDTH
) extends BaseTest;
    `uvm_component_param_utils(Test#(DATA_WIDTH))

    typedef Env #(DATA_WIDTH) Env;
    typedef AxisMasterPacketSeq#(DATA_WIDTH) MasterSeq;
    typedef AxisSlaveSeq SlaveSeq;
    typedef AxisMasterSeqr#(DATA_WIDTH) MasterSeqr;
    typedef AxisSlaveSeqr SlaveSeqr;

    local Env env;

    local const int unsigned PACKETS_COUNT = 512;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = Env::type_id::create("env", this);
        ConfigDb#(int unsigned)::set(this, "env.master_agent.seqr", "packets_count", PACKETS_COUNT);
    endfunction

    virtual task reset_phase(uvm_phase phase);
        ResetSeqr reset_seqr = env.get_reset_agent().get_seqr();
        InitialResetSeq reset_seq = InitialResetSeq::type_id::create("reset_seq", reset_seqr);
        phase.raise_objection(this);
        reset_seq.start(reset_seqr);
        phase.drop_objection(this);
    endtask

    virtual task main_phase(uvm_phase phase);
        MasterSeqr master_seqr = env.get_master_agent().get_seqr();
        SlaveSeqr slave_seqr = env.get_slave_agent().get_seqr();
        MasterSeq master_seq = MasterSeq::type_id::create("master_seq", master_seqr);
        SlaveSeq slave_seq = SlaveSeq::type_id::create("slave_seq", master_seqr);

        phase.raise_objection(this);
        fork
            slave_seq.start(slave_seqr);
        join_none
        master_seq.start(master_seqr);
        phase.drop_objection(this);
    endtask
endclass
