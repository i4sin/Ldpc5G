virtual class Item extends uvm_sequence_item;
    `uvm_object_utils(Item)

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    function void pre_randomize();
        configure();
    endfunction

    virtual function void configure();
    endfunction
endclass
