class AxisSlaveItem extends Item;
    `uvm_object_utils(AxisSlaveItem)

    rand int delay;
    constraint c_delay {
        delay inside {[0:10]};
    }

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("delay", delay, $bits(delay), UVM_DEC);
    endfunction
endclass
