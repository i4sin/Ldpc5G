class Scoreboard #(
    parameter DATA_WIDTH
) extends uvm_scoreboard;
    `uvm_component_utils(Scoreboard#(DATA_WIDTH))

    typedef AxisTransaction#(DATA_WIDTH) Transaction;
    typedef uvm_tlm_analysis_fifo #(Transaction) AnalysisFifo;

    AnalysisFifo input_analysis_fifo;
    AnalysisFifo output_analysis_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        input_analysis_fifo = new("input_analysis_fifo", this);
        output_analysis_fifo = new("output_analysis_fifo", this);
    endfunction

    virtual function void run_phase(uvm_phase phase);
        forever begin
            Transaction input_transaction;
            Transaction output_transaction;
            input_analysis_fifo.get(input_transaction);
            output_analysis_fifo.get(output_transaction);
            check_matching(input_transaction, output_transaction);
        end
    endfunction

    local function void check_matching(Transaction input_transaction, Transaction output_transaction);
        if (!input_transaction.compare(output_transaction)) begin
            `uvm_error("SCOREBOARD", $sformatf("transactions don't match! \ninput_transaction: %s\noutput_transaction: %s\n", input_transaction.sprint(), output_transaction.sprint()))
        end
    endfunction
endclass