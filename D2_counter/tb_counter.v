`timescale 1ns/1ps

module tb_counter;
    localparam W = 4;

    reg clk     = 0;
    reg rst_n   = 0;
    reg en      = 0;
    wire [W-1:0] cnt;
    wire        carry;

    integer errors = 0;
    integer i;

    counter #(.W(W)) dut (
        .clk(clk), .rst_n(rst_n), .en(en),
        .cnt(cnt), .carry(carry)
    );

    always #5 clk = ~clk;

    task check(input [W-1:0] exp);
        begin
            if (cnt !== exp) begin
                errors = errors + 1;
                $display("FAIL @%0t: cnt=%0d exp=%0d", $time, cnt, exp);
            end
        end
    endtask

    initial begin
        $dumpfile("tb_counter.vcd");
        $dumpvars(0, tb_counter);

        rst_n = 0;
        repeat (2) @(posedge clk);
        #1 check(0);

        rst_n = 1;
        en    = 1;
        for (i = 0; i < 18; i = i + 1) begin
            @(posedge clk); #1;
            check((i + 1) % 16);
        end

        en = 0;
        repeat (3) @(posedge clk);
        #1 check(2);

        en = 1;
        @(posedge clk); #1;
        check(3);

        if (errors == 0) $display("PASS: counter sequence ok");
        else             $display("FAILED: %0d errors", errors);
        $finish;
    end
endmodule