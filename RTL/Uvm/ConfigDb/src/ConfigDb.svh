class ConfigDb #(
    type T
);
    static function bit exists(uvm_component cntxt, string inst_name, string field_name);
        return (uvm_config_db#(T)::exists(cntxt, inst_name, field_name));
    endfunction

    static function void get(uvm_component cntxt, string inst_name, string field_name, ref T value);
        if (!uvm_config_db#(T)::get(cntxt, inst_name, field_name, value))
            `uvm_fatal({"NO ", field_name}, {"Couldn't get ", cntxt.get_full_name(), " inst_name:", inst_name})
    endfunction

    static function void set(uvm_component cntxt, string inst_name, string field_name, T value);
        uvm_config_db#(T)::set(cntxt, inst_name, field_name, value);
    endfunction
endclass
