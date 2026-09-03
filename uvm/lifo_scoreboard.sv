class lifo_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(lifo_scoreboard)


    uvm_analysis_imp #(lifo_seq_item, lifo_scoreboard)
        analysis_export;


    logic [15:0] expected_stack[$];


    int total_pushes;
    int total_pops;
    int errors;


    function new(
        string name = "lifo_scoreboard",
        uvm_component parent = null
    );

        super.new(name, parent);

        analysis_export =
            new("analysis_export", this);

        total_pushes = 0;
        total_pops   = 0;
        errors       = 0;

    endfunction


    function void write(lifo_seq_item item);

        bit valid_push;
        bit valid_pop;

        logic [15:0] expected_data;


        // Determine validity from PREVIOUS state

        valid_push =
            item.push &&
            (expected_stack.size() < 8);

        valid_pop =
            item.pop &&
            (expected_stack.size() > 0);


        // ---------------------------------------
        // POP checking
        // ---------------------------------------

        if (valid_pop) begin

            expected_data =
                expected_stack[$];

            expected_stack.pop_back();

            total_pops++;


            if (item.dout !== expected_data) begin

                `uvm_error(
                    "LIFO_MISMATCH",
                    $sformatf(
                        "READ FAIL: Expected=0x%04h Actual=0x%04h",
                        expected_data,
                        item.dout
                    )
                )

                errors++;

            end

            else begin

                `uvm_info(
                    "LIFO_MATCH",
                    $sformatf(
                        "POP PASS: Data=0x%04h",
                        item.dout
                    ),
                    UVM_LOW
                )

            end

        end


        // ---------------------------------------
        // PUSH checking
        // ---------------------------------------

        if (valid_push) begin

            expected_stack.push_back(item.din);

            total_pushes++;


            `uvm_info(
                "LIFO_PUSH",
                $sformatf(
                    "PUSH PASS: din=0x%04h stack_size=%0d",
                    item.din,
                    expected_stack.size()
                ),
                UVM_LOW
            )

        end

        else if (item.push) begin

            `uvm_info(
                "LIFO_PUSH",
                $sformatf(
                    "PUSH BLOCKED: LIFO full, din=0x%04h",
                    item.din
                ),
                UVM_LOW
            )

        end


        // ---------------------------------------
        // Empty checking
        // ---------------------------------------

        if (item.empty !==
            (expected_stack.size() == 0)) begin

            `uvm_error(
                "EMPTY_ERROR",
                $sformatf(
                    "EMPTY mismatch: Expected=%0b Actual=%0b Size=%0d",
                    (expected_stack.size() == 0),
                    item.empty,
                    expected_stack.size()
                )
            )

            errors++;

        end


        // ---------------------------------------
        // Full checking
        // ---------------------------------------

        if (item.full !==
            (expected_stack.size() == 8)) begin

            `uvm_error(
                "FULL_ERROR",
                $sformatf(
                    "FULL mismatch: Expected=%0b Actual=%0b Size=%0d",
                    (expected_stack.size() == 8),
                    item.full,
                    expected_stack.size()
                )
            )

            errors++;

        end

    endfunction


    function void report_phase(uvm_phase phase);

        super.report_phase(phase);


        `uvm_info(
            "LIFO_SCOREBOARD",
            "============================================",
            UVM_NONE
        )

        `uvm_info(
            "LIFO_SCOREBOARD",
            $sformatf(
                "Total PUSHes = %0d",
                total_pushes
            ),
            UVM_NONE
        )

        `uvm_info(
            "LIFO_SCOREBOARD",
            $sformatf(
                "Total POPs   = %0d",
                total_pops
            ),
            UVM_NONE
        )

        `uvm_info(
            "LIFO_SCOREBOARD",
            $sformatf(
                "Errors       = %0d",
                errors
            ),
            UVM_NONE
        )

        `uvm_info(
            "LIFO_SCOREBOARD",
            $sformatf(
                "Remaining Stack = %0d",
                expected_stack.size()
            ),
            UVM_NONE
        )


        if (errors == 0 &&
            expected_stack.size() == 0)

            `uvm_info(
                "LIFO_SCOREBOARD",
                "LIFO SCOREBOARD: PASS",
                UVM_NONE
            )

        else

            `uvm_error(
                "LIFO_SCOREBOARD",
                "LIFO SCOREBOARD: FAIL"
            )


        `uvm_info(
            "LIFO_SCOREBOARD",
            "============================================",
            UVM_NONE
        )

    endfunction

endclass