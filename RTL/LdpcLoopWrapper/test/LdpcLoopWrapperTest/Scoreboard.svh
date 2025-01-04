class Scoreboard #(
    parameter DATA_WIDTH
) extends uvm_scoreboard;
    `uvm_component_param_utils(Scoreboard#(DATA_WIDTH))

    typedef AxisTransaction#(DATA_WIDTH) Transaction;
    typedef uvm_tlm_analysis_fifo #(Transaction) AnalysisFifo;

    AnalysisFifo input_analysis_fifo;
    AnalysisFifo output_analysis_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        input_analysis_fifo = new("input_analysis_fifo", this);
        output_analysis_fifo = new("output_analysis_fifo", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            Transaction input_transaction;
            Transaction output_transaction;
            input_analysis_fifo.get(input_transaction);
            output_analysis_fifo.get(output_transaction);
        end
    endtask
endclass