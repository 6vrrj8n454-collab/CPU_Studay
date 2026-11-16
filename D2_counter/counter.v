module counter #(
    parameter W = 4
) (
    input wire clk,
    input wire rst_n,
    input wire en,
    output reg [W-1:0] cnt,
    output wire carry
);
    assign carry = en && (cnt == {W{1'b1}});

    always @(posedge clk) begin
        if (!rst_n)  cnt <= {W{1'b0}};
        else if (en) cnt <= cnt + 1'b1;
    end
endmodule

