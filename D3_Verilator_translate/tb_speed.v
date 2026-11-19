`timescale 1ns/1ps

module tb_speed;
    reg clk = 0, rst_n = 0, en = 0;
    wire [3:0] cnt;
    wire carry;
    integer i;

    counter dut (.clk(clk), .rst_n(rst_n), .en(en), .cnt(cnt), .carry(carry));
    always #5 clk = ~clk;

    initial begin
        rst_n = 0; #20; rst_n = 1; en = 1;
        for (i = 0; i < 1000000; i = i + 1) @(posedge clk);
        $display("done cnt=%0d", cnt);
        $finish;
    end
endmodule