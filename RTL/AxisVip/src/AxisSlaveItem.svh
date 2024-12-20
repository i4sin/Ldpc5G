class AxisSlaveItem extends uvm_sequence_item;
    `uvm_object_utils(AxisSlaveItem)

    rand int delay;
    constraint c_delay {
        delay inside {[0:10]};
    }

    function new(string name = "AxisSlaveItem");
        super.new(name);
    endfunction
endclass
