class lifo_coverage extends uvm_subscriber #(lifo_seq_item);

    `uvm_component_utils(lifo_coverage)

    lifo_seq_item item;

    // Reference occupancy
    int occupancy;


    // ============================================================
    // STATE ENCODING
    // ============================================================
    //
    // 0 = EMPTY
    // 1 = PARTIAL
    // 2 = FULL
    //
    int state;


    // ============================================================
    // INPUT COVERAGE
    // ============================================================

    covergroup input_cg;

        push_cp: coverpoint item.push {

            bins NO_PUSH = {0};
            bins PUSH    = {1};

        }


        pop_cp: coverpoint item.pop {

            bins NO_POP = {0};
            bins POP    = {1};

        }


        din_cp: coverpoint item.din {

            bins ZERO = {16'h0000};
            bins ONE  = {16'h0001};

            bins LOW_RANGE =
                {[16'h0002:16'h00FF]};

            bins MID_RANGE =
                {[16'h0100:16'h7FFF]};

            bins HIGH_RANGE =
                {[16'h8000:16'hFFFE]};

            bins FFFF =
                {16'hFFFF};

            bins AAAA =
                {16'hAAAA};

            bins FIVE_FIVE =
                {16'h5555};

            bins DEAD =
                {16'hDEAD};

            bins BEEF =
                {16'hBEEF};

        }


        push_pop_cross:
            cross push_cp, pop_cp;

    endgroup


    // ============================================================
    // OUTPUT COVERAGE
    // ============================================================

    covergroup output_cg;

        empty_cp: coverpoint item.empty {

            bins NOT_EMPTY = {0};
            bins EMPTY     = {1};

        }


        full_cp: coverpoint item.full {

            bins NOT_FULL = {0};
            bins FULL     = {1};

        }


        dout_cp: coverpoint item.dout {

            bins ZERO =
                {16'h0000};

            bins ONE =
                {16'h0001};

            bins AAAA =
                {16'hAAAA};

            bins FIVE_FIVE =
                {16'h5555};

            bins FFFF =
                {16'hFFFF};

            bins DEAD =
                {16'hDEAD};

            bins BEEF =
                {16'hBEEF};

            bins OTHER = default;

        }


        empty_full_cross:
            cross empty_cp, full_cp;

    endgroup


    // ============================================================
    // OCCUPANCY COVERAGE
    // ============================================================

    covergroup occupancy_cg;

        occupancy_cp: coverpoint occupancy {

            bins EMPTY_STATE =
                {0};

            bins ONE_ENTRY =
                {1};

            bins LOW =
                {[2:3]};

            bins MID =
                {[4:5]};

            bins HIGH =
                {[6:7]};

            bins FULL_STATE =
                {8};

        }

    endgroup


    // ============================================================
    // STATE / OPERATION COVERAGE
    // ============================================================

    covergroup state_cross_cg;

        operation_cp:
            coverpoint {item.push, item.pop} {

                bins IDLE =
                    {2'b00};

                bins PUSH =
                    {2'b10};

                bins POP =
                    {2'b01};

                bins PUSH_POP =
                    {2'b11};

            }


        state_cp:
            coverpoint state {

                bins EMPTY =
                    {0};

                bins PARTIAL =
                    {1};

                bins FULL =
                    {2};

            }


        operation_state_cross:
            cross operation_cp, state_cp;

    endgroup


    // ============================================================
    // BOUNDARY COVERAGE
    // ============================================================

    covergroup boundary_cg;

        full_push_cp:
            coverpoint {item.full, item.push} {

                bins FULL_PUSH =
                    {2'b11};

                bins NOT_FULL_PUSH =
                    {2'b01};

            }


        empty_pop_cp:
            coverpoint {item.empty, item.pop} {

                bins EMPTY_POP =
                    {2'b11};

                bins NOT_EMPTY_POP =
                    {2'b01};

            }

    endgroup


    // ============================================================
    // CONSTRUCTOR
    // ============================================================

    function new(
        string name = "lifo_coverage",
        uvm_component parent = null
    );

        super.new(name, parent);

        occupancy = 0;
        state     = 0;


        input_cg =
            new();

        output_cg =
            new();

        occupancy_cg =
            new();

        state_cross_cg =
            new();

        boundary_cg =
            new();

    endfunction


    // ============================================================
    // WRITE / SAMPLE
    // ============================================================

    function void write(lifo_seq_item t);

        item = t;


        // --------------------------------------------------------
        // Determine CURRENT state
        // --------------------------------------------------------

        if (item.empty)
            state = 0;

        else if (item.full)
            state = 2;

        else
            state = 1;


        // --------------------------------------------------------
        // Sample coverage
        // --------------------------------------------------------

        input_cg.sample();

        output_cg.sample();

        occupancy_cg.sample();

        state_cross_cg.sample();

        boundary_cg.sample();


        // --------------------------------------------------------
        // Update reference occupancy
        // --------------------------------------------------------

        if (item.push &&
            occupancy < 8)

            occupancy++;


        if (item.pop &&
            occupancy > 0)

            occupancy--;

    endfunction


    // ============================================================
    // REPORT PHASE
    // ============================================================

    function void report_phase(
        uvm_phase phase
    );

        real total_cov;


        total_cov =
            (
                input_cg.get_coverage() +
                output_cg.get_coverage() +
                occupancy_cg.get_coverage() +
                state_cross_cg.get_coverage() +
                boundary_cg.get_coverage()
            ) / 5.0;


        `uvm_info(
            "LIFO_COVERAGE",
            "============================================",
            UVM_NONE
        )


        `uvm_info(
            "LIFO_COVERAGE",
            $sformatf(
                "Input Coverage       = %.2f%%",
                input_cg.get_coverage()
            ),
            UVM_NONE
        )


        `uvm_info(
            "LIFO_COVERAGE",
            $sformatf(
                "Output Coverage      = %.2f%%",
                output_cg.get_coverage()
            ),
            UVM_NONE
        )


        `uvm_info(
            "LIFO_COVERAGE",
            $sformatf(
                "Occupancy Coverage   = %.2f%%",
                occupancy_cg.get_coverage()
            ),
            UVM_NONE
        )


        `uvm_info(
            "LIFO_COVERAGE",
            $sformatf(
                "State/Cross Coverage = %.2f%%",
                state_cross_cg.get_coverage()
            ),
            UVM_NONE
        )


        `uvm_info(
            "LIFO_COVERAGE",
            $sformatf(
                "Boundary Coverage    = %.2f%%",
                boundary_cg.get_coverage()
            ),
            UVM_NONE
        )


        `uvm_info(
            "LIFO_COVERAGE",
            $sformatf(
                "Overall Coverage     = %.2f%%",
                total_cov
            ),
            UVM_NONE
        )


        `uvm_info(
            "LIFO_COVERAGE",
            $sformatf(
                "Final Occupancy      = %0d",
                occupancy
            ),
            UVM_NONE
        )


        `uvm_info(
            "LIFO_COVERAGE",
            "============================================",
            UVM_NONE
        );

    endfunction

endclass