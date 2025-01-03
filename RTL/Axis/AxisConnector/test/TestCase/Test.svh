class Test #(
    parameter DATA_WIDTH
) extends BaseTest;
    `uvm_component_param_utils(Test#(DATA_WIDTH))

    typedef uvm_component_registry#(Test#(DATA_WIDTH), $sformatf("Test#(%0d)",DATA_WIDTH)) TestCase;

    typedef Env #(DATA_WIDTH) Env;
    typedef AxisMasterPacketSeq#(DATA_WIDTH) MasterSeq;
    typedef AxisSlaveSeq SlaveSeq;
    typedef AxisMasterSeqr#(DATA_WIDTH) MasterSeqr;
    typedef AxisSlaveSeqr SlaveSeqr;

    local Env env;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = Env::type_id:create("env", this);
    endfunction

    virtual task main_phase(uvm_phase phase);
        MasterSeqr master_seqr = MasterSeqr::type_id::create("master_seqr", this);
        SlaveSeqr slave_seqr = SlaveSeqr::type_id::create("slave_seqr", this);
        MasterSeq master_seq = MasterSeq::type_id::create("master_seq", master_seqr);
        SlaveSeq slave_seq = SlaveSeqSeq::type_id::create("slave_seq", master_seqr);

        phase.raise_objection(this);
        fork
            slave_seq.start(slave_seqr);
        join_none
        master_seq.start(master_seqr);
        phase.drop_objection(this);
    endtask
endclass
