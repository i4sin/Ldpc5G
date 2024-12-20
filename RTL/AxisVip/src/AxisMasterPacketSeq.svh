class AxisMasterPacketSeq #(
    parameter DATA_WIDTH
) extends uvm_sequence #(AxisMasterItem#(DATA_WIDTH));
    `uvm_object_utils(AxisMasterPacketSeq#(DATA_WIDTH))

    typedef AxisMasterItem#(DATA_WIDTH) Item;

    local int count;

    function new(string name = "AxisMasterPacketSeq");
        super.new(name);
    endfunction

    virtual task body();
        for (int i = 0; i < packet_length; i++) begin
            Item item = Item::type_id::create("item", m_sequencer);
            start_item(item);
            assert(item.randomize());
            if (i == packet_length - 1) item.tlast = 1;
            finish_item(item);
        end
    endtask
endclass