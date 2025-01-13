class AxisMasterDecoderControlItem #(
    parameter CONTROL_WIDTH
) extends AxisMasterItem#(CONTROL_WIDTH);
    `uvm_object_param_utils(AxisMasterDecoderControlItem#(CONTROL_WIDTH))

    rand logic [2:0] max_schedule;
    rand logic [5:0] mb;
    rand logic [7:0] id;
    rand logic [5:0] max_iterations;
    rand logic term_on_no_change;
    rand logic term_on_pass;
    rand logic include_parity_op;
    rand logic hard_op;
    rand logic reserved;
    rand logic [3:0] ms_offset;
    rand logic [2:0] bg;
    rand logic [2:0] z_set;
    rand logic [2:0] z_j;

    constraint c_tdata {
        tdata == {max_schedule, mb, id, max_iterations, term_on_no_change, term_on_pass, include_parity_op, hard_op, reserved, ms_offset, bg, z_set, z_j};
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
        printer.print_field("max_iterations", max_iterations, $bits(max_iterations), UVM_HEX);
        printer.print_field("term_on_no_change", term_on_no_change, $bits(term_on_no_change), UVM_HEX);
        printer.print_field("term_on_pass", term_on_pass, $bits(term_on_pass), UVM_HEX);
        printer.print_field("include_parity_op", include_parity_op, $bits(include_parity_op), UVM_HEX);
        printer.print_field("hard_op", hard_op, $bits(hard_op), UVM_HEX);
        printer.print_field("reserved", reserved, $bits(reserved), UVM_HEX);
        printer.print_field("ms_offset", ms_offset, $bits(ms_offset), UVM_HEX);
        printer.print_field("bg", bg, $bits(bg), UVM_HEX);
        printer.print_field("z_set", z_set, $bits(z_set), UVM_HEX);
        printer.print_field("z_j", z_j, $bits(z_j), UVM_HEX);
    endfunction
endclass
