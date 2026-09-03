`timescale 1ns/1ps

interface inf_lifo #(
    parameter DWIDTH = 16
)(
    input logic clk
);

    logic rstn;

    logic push;
    logic pop;

    logic [DWIDTH-1:0] din;
    logic [DWIDTH-1:0] dout;

    logic empty;
    logic full;

endinterface