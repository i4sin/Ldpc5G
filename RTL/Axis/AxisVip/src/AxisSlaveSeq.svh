class AxisSlaveSeq extends uvm_sequence #(AxisSlaveItem);
    `uvm_object_utils(AxisSlaveSeq)

    typedef AxisSlaveItem Item;

    function new(string name = "AxisSlaveSeq");
        super.new(name);
    endfunction

    virtual task body();
        forever begin
            Item item = Item::type_id::create("item", m_sequencer);
            start_item(item);
            assert(item.randomize());
            finish_item(item);
        end
    endtask
endclass
