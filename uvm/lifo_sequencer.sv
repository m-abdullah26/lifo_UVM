class lifo_sequencer extends uvm_sequencer #(lifo_seq_item);

    `uvm_component_utils(lifo_sequencer)

    function new(
        string name = "lifo_sequencer",
        uvm_component parent = null
    );

        super.new(name, parent);

    endfunction

endclass