class AxisTransaction #(
    parameter DATA_WIDTH
) extends uvm_transaction;
    `uvm_object_param_utils(AxisTransaction#(DATA_WIDTH))

    typedef AxisMasterItem#(DATA_WIDTH) Item;

    logic [DATA_WIDTH-1:0] tdata;
    logic [DATA_WIDTH/8-1:0] tkeep;
    logic tlast;

    function new(string name = "AxisTransaction");
        super.new(name);
    endfunction

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        bit result;
        Item item;
        assert ($cast(item, rhs));
        result = super.do_compare(rhs, comparer) & tdata == item.tdata;
        result = result & item.tkeep == tkeep;
        result = result & item.tlast == tlast;
        return result;
    endfunction
endclass
