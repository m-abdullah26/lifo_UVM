`timescale 1ns/1ps

module lifo #(
    parameter DEPTH  = 8,
    parameter DWIDTH = 16
)(
    input  logic              clk,
    input  logic              rstn,

    input  logic              push,
    input  logic              pop,

    input  logic [DWIDTH-1:0] din,
    output logic [DWIDTH-1:0] dout,

    output logic              empty,
    output logic              full
);

    logic [DWIDTH-1:0] stack [0:DEPTH-1];

    logic [$clog2(DEPTH+1)-1:0] sp;

    assign empty = (sp == 0);
    assign full  = (sp == DEPTH);

    always_ff @(posedge clk) begin

        if (!rstn) begin

            sp   <= '0;
            dout <= '0;

        end

        else begin

            case ({push, pop})

                2'b10: begin
                    // PUSH
                    if (!full) begin
                        stack[sp] <= din;
                        sp        <= sp + 1'b1;
                    end
                end

                2'b01: begin
                    // POP
                    if (!empty) begin
                        sp   <= sp - 1'b1;
                        dout <= stack[sp - 1'b1];
                    end
                end

                2'b11: begin
                    // SIMULTANEOUS PUSH + POP
                    if (!empty && !full) begin
                        stack[sp - 1'b1] <= din;
                        dout             <= stack[sp - 1'b1];
                    end

                    else if (empty) begin
                        // Cannot pop from empty stack.
                        // Perform push only.
                        stack[sp] <= din;
                        sp        <= sp + 1'b1;
                    end

                    else if (full) begin
                        // Cannot push into full stack.
                        // Perform pop only.
                        sp   <= sp - 1'b1;
                        dout <= stack[sp - 1'b1];
                    end
                end

                default: begin
                    // IDLE
                end

            endcase
        end
    end

    initial begin
        $monitor(
            "[%0t] [LIFO] push=%0b din=0x%0h pop=%0b dout=0x%0h empty=%0b full=%0b",
            $time,
            push,
            din,
            pop,
            dout,
            empty,
            full
        );
    end

endmodule