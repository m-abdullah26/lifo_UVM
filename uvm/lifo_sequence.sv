`ifndef LIFO_SEQUENCE_SV
`define LIFO_SEQUENCE_SV


// ============================================================
// Basic LIFO Sequence
// ============================================================

class lifo_sequence extends uvm_sequence #(lifo_seq_item);

    `uvm_object_utils(lifo_sequence)


    function new(
        string name = "lifo_sequence"
    );

        super.new(name);

    endfunction


    task body();

        lifo_seq_item req;


        // PUSH 8 entries

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 0;
            req.din  = i;

            finish_item(req);

        end


        // Attempt PUSH while FULL

        req =
            lifo_seq_item::type_id::create("req");

        start_item(req);

        req.push = 1;
        req.pop  = 0;
        req.din  = 16'hDEAD;

        finish_item(req);


        // POP all 8 entries

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 0;
            req.pop  = 1;
            req.din  = 0;

            finish_item(req);

        end


        // Attempt POP while EMPTY

        req =
            lifo_seq_item::type_id::create("req");

        start_item(req);

        req.push = 0;
        req.pop  = 1;
        req.din  = 0;

        finish_item(req);

    endtask

endclass



// ============================================================
// PUSH Sequence
// ============================================================

class lifo_push_sequence extends uvm_sequence #(lifo_seq_item);

    `uvm_object_utils(lifo_push_sequence)


    function new(
        string name = "lifo_push_sequence"
    );

        super.new(name);

    endfunction


    task body();

        lifo_seq_item req;


        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 0;
            req.din  = 16'h1000 + i;

            finish_item(req);

        end

    endtask

endclass



// ============================================================
// POP Sequence
// ============================================================

class lifo_pop_sequence extends uvm_sequence #(lifo_seq_item);

    `uvm_object_utils(lifo_pop_sequence)


    function new(
        string name = "lifo_pop_sequence"
    );

        super.new(name);

    endfunction


    task body();

        lifo_seq_item req;


        // First PUSH

        for (int i = 0; i < 4; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 0;
            req.din  = 16'h2000 + i;

            finish_item(req);

        end


        // Then POP

        for (int i = 0; i < 4; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 0;
            req.pop  = 1;
            req.din  = 0;

            finish_item(req);

        end

    endtask

endclass



// ============================================================
// FULL Sequence
// ============================================================

class lifo_full_sequence extends uvm_sequence #(lifo_seq_item);

    `uvm_object_utils(lifo_full_sequence)


    function new(
        string name = "lifo_full_sequence"
    );

        super.new(name);

    endfunction


    task body();

        lifo_seq_item req;


        // Fill stack

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 0;
            req.din  = 16'h3000 + i;

            finish_item(req);

        end


        // Additional writes while FULL

        repeat (3) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 0;
            req.din  = 16'hAAAA;

            finish_item(req);

        end


        // Drain stack

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 0;
            req.pop  = 1;
            req.din  = 0;

            finish_item(req);

        end

    endtask

endclass



// ============================================================
// EMPTY Sequence
// ============================================================

class lifo_empty_sequence extends uvm_sequence #(lifo_seq_item);

    `uvm_object_utils(lifo_empty_sequence)


    function new(
        string name = "lifo_empty_sequence"
    );

        super.new(name);

    endfunction


    task body();

        lifo_seq_item req;


        // POP while EMPTY

        repeat (3) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 0;
            req.pop  = 1;
            req.din  = 0;

            finish_item(req);

        end


        // PUSH one entry

        req =
            lifo_seq_item::type_id::create("req");

        start_item(req);

        req.push = 1;
        req.pop  = 0;
        req.din  = 16'hBBBB;

        finish_item(req);


        // POP valid entry

        req =
            lifo_seq_item::type_id::create("req");

        start_item(req);

        req.push = 0;
        req.pop  = 1;
        req.din  = 0;

        finish_item(req);


        // POP again while EMPTY

        req =
            lifo_seq_item::type_id::create("req");

        start_item(req);

        req.push = 0;
        req.pop  = 1;
        req.din  = 0;

        finish_item(req);

    endtask

endclass



// ============================================================
// PUSH/POP Sequence
// ============================================================

class lifo_push_pop_sequence extends uvm_sequence #(lifo_seq_item);

    `uvm_object_utils(lifo_push_pop_sequence)


    function new(
        string name = "lifo_push_pop_sequence"
    );

        super.new(name);

    endfunction


    task body();

        lifo_seq_item req;


        // PUSH

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 0;
            req.din  = 16'h4000 + i;

            finish_item(req);

        end


        // POP

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 0;
            req.pop  = 1;
            req.din  = 0;

            finish_item(req);

        end

    endtask

endclass



// ============================================================
// Simultaneous PUSH/POP
// ============================================================

class lifo_simultaneous_sequence extends uvm_sequence #(lifo_seq_item);

    `uvm_object_utils(lifo_simultaneous_sequence)


    function new(
        string name = "lifo_simultaneous_sequence"
    );

        super.new(name);

    endfunction


    task body();

        lifo_seq_item req;


        // Create initial stack contents

        for (int i = 0; i < 4; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 0;
            req.din  = 16'h5000 + i;

            finish_item(req);

        end


        // Simultaneous PUSH + POP

        for (int i = 0; i < 4; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 1;
            req.din  = 16'h6000 + i;

            finish_item(req);

        end


        // Drain

        for (int i = 0; i < 4; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 0;
            req.pop  = 1;
            req.din  = 0;

            finish_item(req);

        end

    endtask

endclass



// ============================================================
// Boundary Sequence
// ============================================================

class lifo_boundary_sequence extends uvm_sequence #(lifo_seq_item);

    `uvm_object_utils(lifo_boundary_sequence)


    function new(
        string name = "lifo_boundary_sequence"
    );

        super.new(name);

    endfunction


    task body();

        lifo_seq_item req;


        // Empty POP

        req =
            lifo_seq_item::type_id::create("req");

        start_item(req);

        req.push = 0;
        req.pop  = 1;
        req.din  = 0;

        finish_item(req);


        // One PUSH

        req =
            lifo_seq_item::type_id::create("req");

        start_item(req);

        req.push = 1;
        req.pop  = 0;
        req.din  = 16'h7000;

        finish_item(req);


        // POP back to EMPTY

        req =
            lifo_seq_item::type_id::create("req");

        start_item(req);

        req.push = 0;
        req.pop  = 1;
        req.din  = 0;

        finish_item(req);


        // Fill to FULL

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 0;
            req.din  = 16'h7001 + i;

            finish_item(req);

        end


        // Push while FULL

        req =
            lifo_seq_item::type_id::create("req");

        start_item(req);

        req.push = 1;
        req.pop  = 0;
        req.din  = 16'hFFFF;

        finish_item(req);


        // Drain

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 0;
            req.pop  = 1;
            req.din  = 0;

            finish_item(req);

        end

    endtask

endclass



// ============================================================
// DATA Pattern Sequence
// ============================================================

class lifo_data_sequence extends uvm_sequence #(lifo_seq_item);

    `uvm_object_utils(lifo_data_sequence)


    function new(
        string name = "lifo_data_sequence"
    );

        super.new(name);

    endfunction


    task body();

        lifo_seq_item req;


        logic [15:0] data_patterns [0:7];


        data_patterns[0] = 16'h0000;
        data_patterns[1] = 16'h0001;
        data_patterns[2] = 16'hAAAA;
        data_patterns[3] = 16'h5555;
        data_patterns[4] = 16'hFFFF;
        data_patterns[5] = 16'h1234;
        data_patterns[6] = 16'hDEAD;
        data_patterns[7] = 16'hBEEF;


        // PUSH patterns

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 1;
            req.pop  = 0;
            req.din  = data_patterns[i];

            finish_item(req);

        end


        // POP patterns

        for (int i = 0; i < 8; i++) begin

            req =
                lifo_seq_item::type_id::create("req");

            start_item(req);

            req.push = 0;
            req.pop  = 1;
            req.din  = 0;

            finish_item(req);

        end

    endtask

endclass


`endif