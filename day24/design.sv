module uart_tx(
    input wire clk,
    input wire rst,
    input wire tx_start,
    input wire [7:0] tx_data,

    output reg tx_out,
    output reg tx_busy,
    output reg tx_done
);

parameter CLKS_PER_BIT = 10;

parameter IDLE  = 3'd0;
parameter START = 3'd1;
parameter DATA  = 3'd2;
parameter STOP  = 3'd3;

reg [2:0] state;
reg [7:0] clk_count;
reg [2:0] bit_index;
reg [7:0] tx_shift_reg;

always @(posedge clk) begin

    if(rst) begin
        state        <= IDLE;
        tx_out       <= 1'b1;
        tx_busy      <= 1'b0;
        tx_done      <= 1'b0;
        clk_count    <= 0;
        bit_index    <= 0;
        tx_shift_reg <= 0;
    end

    else begin

        tx_done <= 1'b0;

        case(state)

        //--------------------------------------------------
        // IDLE STATE
        //--------------------------------------------------
        IDLE: begin

            tx_out <= 1'b1;
            tx_busy <= 1'b0;

            clk_count <= 0;
            bit_index <= 0;

            if(tx_start) begin
                tx_shift_reg <= tx_data;
                tx_busy <= 1'b1;
                state <= START;
            end
        end

        //--------------------------------------------------
        // START BIT
        //--------------------------------------------------
        START: begin

            tx_out <= 1'b0;

            if(clk_count < CLKS_PER_BIT-1)
                clk_count <= clk_count + 1;
            else begin
                clk_count <= 0;
                state <= DATA;
            end
        end

        //--------------------------------------------------
        // DATA BITS
        //--------------------------------------------------
        DATA: begin

            tx_out <= tx_shift_reg[0];

            if(clk_count < CLKS_PER_BIT-1)
                clk_count <= clk_count + 1;
            else begin

                clk_count <= 0;
                tx_shift_reg <= tx_shift_reg >> 1;

                if(bit_index < 7)
                    bit_index <= bit_index + 1;
                else begin
                    bit_index <= 0;
                    state <= STOP;
                end
            end
        end

        //--------------------------------------------------
        // STOP BIT
        //--------------------------------------------------
        STOP: begin

            tx_out <= 1'b1;

            if(clk_count < CLKS_PER_BIT-1)
                clk_count <= clk_count + 1;
            else begin
                clk_count <= 0;
                tx_busy <= 1'b0;
                tx_done <= 1'b1;
                state <= IDLE;
            end
        end

        default: state <= IDLE;

        endcase
    end
end

endmodule
