class ConfigDb #(
    type T
);
    function bit exists(uvm_component cntxt, string inst_name, string field_name);
        return (uvm_config_db#(T)::exists(cntxt, inst_name, field_name));
    endfunction

    function void get(uvm_component cntxt, string inst_name, string field_name, inout T value);
        if (!uvm_config_db#(T)::get(cntxt, inst_name, field_name, value))
            `uvm_fatal({"NO ", field_name}, {"Couldn't get ", cntxt, inst_name, field_name, "from config db!"})
    endfunction

    function void set(uvm_component cntxt, string inst_name, string field_name, T value);
        uvm_config_db#(T)::set(cntxt, inst_name, field_name, value);
    endfunction
endclass
