class CountSeq #(
    type T,
    parameter string ITEM_NAME
) extends RepeatSeq #(T, ITEM_NAME);
    `uvm_object_param_utils(CountSeq#(T, ITEM_NAME))

    local int unsigned count;

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    virtual function void configure();
        ConfigDb#(int unsigned)::get(m_sequencer, get_name(), "count", count);
    endfunction

    virtual task body();
        repeat (count) send_random_t();
    endtask

    static function void set_count(string name, uvm_sequencer_base seqr, int unsigned count);
        ConfigDb#(int unsigned)::set(null, {seqr.get_full_name(), ".", name}, "count", count);
    endfunction
endclass
