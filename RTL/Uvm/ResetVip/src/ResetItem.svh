class ResetItem extends Item;
    `uvm_object_utils(ResetItem)

    int length = 3;

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction
endclass
