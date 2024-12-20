class InitialResetSeq extends uvm_sequence #(ResetItem);
    `uvm_object_utils(InitialResetSeq)

    typedef ResetItem Item;

    function new(string name = "InitialResetSeq");
        super.new(name);
    endfunction

    virtual task body();
        Item item = Item::type_id::create("item", m_sequencer);
        start_item(item);
        finish_item(item);
    endtask
endclass
