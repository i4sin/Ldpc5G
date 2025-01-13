class AxisMasterEncoderControlItem #(
    parameter CONTROL_WIDTH
) extends AxisMasterItem#(CONTROL_WIDTH);
    `uvm_object_param_utils(AxisMasterEncoderControlItem#(CONTROL_WIDTH))

    rand logic [2:0] max_schedule = MAX_SCHEDULE;
    rand logic [5:0] mb = MB;
    rand logic [7:0] id;
    rand logic [14:0] reserved;
    rand logic [2:0] bg = BG;
    rand logic [2:0] z_set = Z_SET;
    rand logic [2:0] z_j = Z_J;

    constraint c_tdata {
        tdata == {max_schedule, mb, id, reserved, bg, z_set, z_j};
    }
    
    constraint c_tlast {
        tlast == 1;
    }

    function new(string name = "");
        super.new(name);
        assert (name != "");
    endfunction

    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("max_schedule", max_schedule, $bits(max_schedule), UVM_HEX);
        printer.print_field("mb", mb, $bits(mb), UVM_HEX);
        printer.print_field("id", id, $bits(id), UVM_HEX);
        printer.print_field("reserved", reserved, $bits(reserved), UVM_HEX);
        printer.print_field("bg", bg, $bits(bg), UVM_HEX);
        printer.print_field("z_set", z_set, $bits(z_set), UVM_HEX);
        printer.print_field("z_j", z_j, $bits(z_j), UVM_HEX);
    endfunction
endclass
