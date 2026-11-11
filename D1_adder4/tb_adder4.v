`timescale 1ns/1ps

module tb_adder4;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;

    adder4 u_adder (
        .a(a), .b(b), .cin(cin),
        .sum(sum), .cout(cout)
    );

    integer i, j, k;
    integer errors = 0;

    initial begin
        $dumpfile("tb_adder4.vcd");
        $dumpvars(0, tb_adder4);

        for(i = 0; i < 16; i = i + 1)
            for(j = 0; j < 16; j = j + 1)
                for(k = 0; k < 2; k = k + 1) begin
                    a = i; b = j; cin = k;
                    #10;
                    if ({cout, sum} !== (a + b + cin)) begin
                        errors = errors + 1;
                        $display("FAIL a=%0d b=%0d cin=%0d got=%0d exp=%0d",
                        a, b, cin, {cout, sum}, a + b + cin);
                    end
                end

                if (errors == 0) $display("PASS : all 512 cases");
                else $display("FAILED : %0d errors", errors);
                $finish;
    end

endmodule