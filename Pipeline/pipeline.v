module pipeline #(parameter WIDTH = 32, DEPTH = 1) (
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] d,
    output wire [WIDTH-1:0] q
);

wire [WIDTH-1:0] flop [DEPTH:0];
assign flop[0] = d;

genvar n;
generate
    for (n = 1; n <= DEPTH; n = n + 1) begin
        dff #(.WIDTH(WIDTH)) stage (
            .clk(clk),
            .rst(rst),
            .d(flop[n-1]),
            .q(flop[n])
        );
    end
endgenerate 

assign q = flop[DEPTH];

endmodule

module dff #(parameter WIDTH = 8) (
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 0;
        end 
        else begin
            q <= d;
        end
    end

endmodule
