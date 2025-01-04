class ResetItem extends uvm_sequence_item;
    `uvm_object_utils(ResetItem)

    int length = 3;

    function new(string name = "ResetItem");
        super.new(name);
    endfunction
endclass
