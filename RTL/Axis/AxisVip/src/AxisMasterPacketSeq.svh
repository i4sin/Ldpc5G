class AxisMasterPacketSeq #(
    parameter DATA_WIDTH
) extends Seq #(AxisMasterItem#(DATA_WIDTH));
    `uvm_object_param_utils(AxisMasterPacketSeq#(DATA_WIDTH))

    typedef AxisMasterPacket#(DATA_WIDTH) Packet;

    local int unsigned packets_count;

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    virtual function void configure();
        ConfigDb#(int unsigned)::get(m_sequencer, "", "packets_count", packets_count);
    endfunction

    virtual task body();
        repeat (packets_count) send_packet();
    endtask

    local task send_packet();
        Packet packet = Packet::type_id::create("packet", m_sequencer);
        packet.set_sequencer(m_sequencer);
        assert(packet.randomize());
        packet.start(m_sequencer, this);
    endtask
endclass
