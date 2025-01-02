class AxisMasterPacketSeq #(
    parameter DATA_WIDTH
) extends uvm_sequence #(AxisMasterItem#(DATA_WIDTH));
    `uvm_object_param_utils(AxisMasterPacketSeq#(DATA_WIDTH))

    typedef AxisMasterPacket#(DATA_WIDTH) Packet;

    local int packets_count;

    function new(string name = "AxisMasterPacketSeq");
        super.new(name);
    endfunction

    virtual task body();
        get_packets_count();
        repeat (packets_count) send_packet();
    endtask

    local function void get_packets_count();
        ConfigDb#(int)::get(m_sequencer, "", "packets_count", packets_count);
    endfunction

    local function void send_packet();
        Packet packet = Packet::type_id::create("packet", m_sequencer);
        assert(packet.randomize());
        packet.start(m_sequencer, this);
    endfunction
endclass
