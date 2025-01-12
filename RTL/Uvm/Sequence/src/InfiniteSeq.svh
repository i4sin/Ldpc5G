class InfiniteSeq #(
    type T,
    parameter string ITEM_NAME
) extends RepeatSeq #(T, ITEM_NAME);
    `uvm_object_param_utils(InfiniteSeq#(T, ITEM_NAME))

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    virtual task body();
        forever send_random_t();
    endtask
endclass
