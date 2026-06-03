module barrel_shifter(
input wire [7:0] data_in,
input wire [2:0] shift_amt,
input wire direction,
input wire arith,
output reg [7:0] data_out
);
always @(*) begin
if(direction == 1'b0) begin
case(shift_amt)
3'd0: data_out = data_in;
3'd1: data_out = data_in << 1;
3'd2: data_out = data_in << 2;
3'd3: data_out = data_in << 3;
3'd4: data_out = data_in << 4;
3'd5: data_out = data_in << 5;
3'd6: data_out = data_in << 6;
3'd7: data_out = data_in << 7;
default: data_out = data_in;
endcase
end
else begin
if(arith == 1'b1) begin
case(shift_amt)
3'd0: data_out = data_in;
3'd1: data_out = {{1{data_in[7]}},data_in[7:1]};
3'd2: data_out = {{2{data_in[7]}},data_in[7:2]};
3'd3: data_out = {{3{data_in[7]}},data_in[7:3]};
3'd4: data_out = {{4{data_in[7]}},data_in[7:4]};
3'd5: data_out = {{5{data_in[7]}},data_in[7:5]};
3'd6: data_out = {{6{data_in[7]}},data_in[7:6]};
3'd7: data_out = {{7{data_in[7]}},data_in[7:7]};
default: data_out = data_in;
endcase
end
else begin
case(shift_amt)
3'd0: data_out = data_in;
3'd1: data_out = data_in >> 1;
3'd2: data_out = data_in >> 2;
3'd3: data_out = data_in >> 3;
3'd4: data_out = data_in >> 4;
3'd5: data_out = data_in >> 5;
3'd6: data_out = data_in >> 6;
3'd7: data_out = data_in >> 7;
default: data_out = data_in;
endcase
end
end
end
endmodule
