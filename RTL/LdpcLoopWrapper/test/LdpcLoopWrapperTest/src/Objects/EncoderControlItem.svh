class EncoderControlItem #(
    parameter WIDTH
) extends AxisMasterItem#(WIDTH);
    `uvm_object_param_utils(EncoderControlItem#(WIDTH))

    local ControlCfg cfg;

    rand logic [1:0] max_schedule;
    rand logic [5:0] mb;
    rand logic [7:0] id;
    rand logic [14:0] reserved;
    rand logic [2:0] bg;
    rand logic [2:0] z_set;
    rand logic [2:0] z_j;

    constraint c_max_schedule {
        max_schedule == cfg.max_schedule;
    }
    constraint c_mb {
        mb == cfg.mb;
    }
    constraint c_bg {
        bg == cfg.bg;
    }
    constraint c_z_set {
        z_set == cfg.z_set;
    }
    constraint c_z_j {
        z_j == cfg.z_j;
    }

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

    virtual function void configure();
        ConfigDb#(ControlCfg)::get(m_sequencer, get_name(), "cfg", cfg);
    endfunction

    static function void set_cfg(string name, uvm_sequencer_base seqr, ControlCfg cfg);
        ConfigDb#(ControlCfg)::set(null, {seqr.get_full_name(), ".", name}, "cfg", cfg);
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
