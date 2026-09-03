class lifo_seq_item extends uvm_sequence_item;

    rand bit                  push;
    rand bit                  pop;
    rand logic [15:0]         din;

         logic [15:0]         dout;
         logic                empty;
         logic                full;

    `uvm_object_utils_begin(lifo_seq_item)

        `uvm_field_int(push,  UVM_ALL_ON)
        `uvm_field_int(pop,   UVM_ALL_ON)
        `uvm_field_int(din,   UVM_ALL_ON)

        `uvm_field_int(dout,  UVM_ALL_ON)
        `uvm_field_int(empty, UVM_ALL_ON)
        `uvm_field_int(full,  UVM_ALL_ON)

    `uvm_object_utils_end


    function new(string name = "lifo_seq_item");

        super.new(name);

    endfunction

endclass