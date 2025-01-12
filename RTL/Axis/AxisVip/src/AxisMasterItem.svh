class AxisMasterItem #(
    parameter DATA_WIDTH
) extends Item;
    `uvm_object_param_utils(AxisMasterItem#(DATA_WIDTH))

    rand int delay;
    constraint c_delay {
        delay inside {[0:10]};
    }

    rand logic [DATA_WIDTH-1:0] tdata;
    rand logic [DATA_WIDTH/8-1:0] tkeep;
    rand logic tlast;

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("delay", delay, $bits(delay), UVM_DEC);
        printer.print_field("tdata", tdata, $bits(tdata), UVM_HEX);
        printer.print_field("tkeep", tkeep, $bits(tkeep), UVM_HEX);
        printer.print_field("tlast", tlast, $bits(tlast), UVM_HEX);
    endfunction
endclass
