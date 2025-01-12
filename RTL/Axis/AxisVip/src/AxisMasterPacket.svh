class AxisMasterPacket #(
    parameter DATA_WIDTH
) extends Seq #(AxisMasterItem#(DATA_WIDTH));
    `uvm_object_param_utils(AxisMasterPacket#(DATA_WIDTH))

    typedef AxisMasterItem#(DATA_WIDTH) Item;

    local Range size_words_range;

    rand int packet_length;
    constraint c_packet_length {
        packet_length inside {[size_words_range.get_min():size_words_range.get_max()]};
    }

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    virtual function void configure();
        ConfigDb#(Range)::get(m_sequencer, get_name(), "size_words_range", size_words_range);
    endfunction

    virtual task body();
        for (int i = 0; i < packet_length; i++) begin
            Item item = Item::type_id::create("item", m_sequencer);
            start_item(item);
            assert(item.randomize() with {
                tlast == (i == packet_length - 1);
            });
            finish_item(item);
        end
    endtask

    static function void set_size_words_range(string name, uvm_sequencer_base seqr, Range size_words_range);
        ConfigDb#(Range)::set(null, {seqr.get_full_name(), ".", name}, size_words_range.get_name(), size_words_range);
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("packet_length", packet_length, $bits(packet_length), UVM_DEC);
        printer.print_object("size_words_range", size_words_range);
    endfunction
endclass
