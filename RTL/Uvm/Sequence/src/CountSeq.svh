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
        ConfigDb#(int unsigned)::get(m_sequencer, "", "count", count);
    endfunction

    virtual task body();
        repeat (count) send_random_t();
    endtask
endclass
