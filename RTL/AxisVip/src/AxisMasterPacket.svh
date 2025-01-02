class AxisMasterPacket #(
    parameter DATA_WIDTH
) extends uvm_sequence #(AxisMasterItem#(DATA_WIDTH));
    `uvm_object_param_utils(AxisMasterPacket#(DATA_WIDTH))

    typedef AxisMasterItem#(DATA_WIDTH) Item;

    rand int packet_length;
    constraint c_packet_length {
        packet_length inside {[1:100]};
    }

    function new(string name = "AxisMasterPacket");
        super.new(name);
    endfunction

    virtual task body();
        for (int i = 0; i < packet_length; i++) begin
            Item item = Item::type_id::create("item", m_sequencer);
            start_item(item);
            assert(item.randomize()) with {
                item.tlast = (i == packet_length - 1);
            };
            finish_item(item);
        end
    endtask
endclass
