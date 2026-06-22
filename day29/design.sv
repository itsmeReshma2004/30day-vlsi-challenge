module calculator(
input wire clk,
input wire rst,
input wire start,
input wire [3:0] data_in,
input wire [1:0] opcode,
output reg [4:0] result,
output reg done,
output reg [3:0] reg_a,
output reg [3:0] reg_b
);
parameter IDLE    = 3'd0;
parameter LOAD_A  = 3'd1;
parameter LOAD_B  = 3'd2;
parameter COMPUTE = 3'd3;
parameter DONE    = 3'd4;
parameter ADD = 2'b00;
parameter SUB = 2'b01;
parameter AND = 2'b10;
parameter OR  = 2'b11;
reg [2:0] state;
reg [2:0] next_state;
always @(posedge clk) begin
if(rst) begin
state  <= IDLE;
reg_a  <= 4'd0;
reg_b  <= 4'd0;
result <= 5'd0;
done   <= 1'b0;
end
else begin
done <= 1'b0;
case(state)
IDLE: begin
if(start) state <= LOAD_A;
end
LOAD_A: begin
reg_a <= data_in;
state <= LOAD_B;
end
LOAD_B: begin
reg_b <= data_in;
state <= COMPUTE;
end
COMPUTE: begin
case(opcode)
ADD: result <= {1'b0,reg_a} + {1'b0,reg_b};
SUB: result <= {1'b0,reg_a} - {1'b0,reg_b};
AND: result <= {1'b0,reg_a & reg_b};
OR:  result <= {1'b0,reg_a | reg_b};
default: result <= 5'd0;
endcase
state <= DONE;
end
DONE: begin
done  <= 1'b1;
state <= IDLE;
end
default: state <= IDLE;
endcase
end
end
endmodule
