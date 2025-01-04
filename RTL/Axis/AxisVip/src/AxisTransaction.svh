class AxisTransaction #(
    parameter DATA_WIDTH
) extends uvm_transaction;
    `uvm_object_param_utils(AxisTransaction#(DATA_WIDTH))

    typedef AxisTransaction#(DATA_WIDTH) Transaction;

    logic [DATA_WIDTH-1:0] tdata;
    logic [DATA_WIDTH/8-1:0] tkeep;
    logic tlast;

    function new(string name = "AxisTransaction");
        super.new(name);
    endfunction

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        bit result;
        Transaction transaction;
        assert ($cast(transaction, rhs));
        result = super.do_compare(rhs, comparer) & tdata == transaction.tdata;
        result = result & transaction.tkeep == tkeep;
        result = result & transaction.tlast == tlast;
        return result;
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("tdata", tdata, $bits(tdata), UVM_HEX);
        printer.print_field("tkeep", tkeep, $bits(tkeep), UVM_HEX);
        printer.print_field("tlast", tlast, $bits(tlast), UVM_HEX);
    endfunction
endclass
