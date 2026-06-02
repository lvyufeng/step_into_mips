`timescale 1ns / 1ps

// Minimal CP0-like coprocessor for the lab_9 teaching pipeline.
//
// Implemented registers (selected by the rd field of mfc0/mtc0):
//   9  Count    free-running cycle counter (read), writable by mtc0
//   11 Compare  writable teaching register (Count==Compare IRQ is a future lab)
//   12 Status   bit0 IE (global interrupt enable), bit1 EXL (exception level)
//   13 Cause    bits[15:8] live hardware IRQ lines, bits[6:2] ExcCode
//   14 EPC      PC of the instruction that was interrupted
//
// Interrupt model: a hardware interrupt is accepted only when IE=1 and EXL=0.
// Entry sets EXL (masking nested interrupts) and saves EPC; eret clears EXL.
module cp0(
    input wire clk,
    input wire rst,
    // mfc0 read port (combinational)
    input wire[4:0] raddr,
    output reg[31:0] rdata,
    // mtc0 write port (commits as the instruction leaves the execute stage)
    input wire mtc0we,
    input wire[4:0] waddr,
    input wire[31:0] wdata,
    // live hardware interrupt request lines
    input wire[7:0] hwirq,
    // exception/interrupt entry
    input wire exc_take,
    input wire[31:0] exc_epc,
    // eret
    input wire eret,
    // status outputs to the pipeline
    output wire[31:0] epc,
    output wire irq_active
    );

    localparam CP0_COUNT   = 5'd9;
    localparam CP0_COMPARE = 5'd11;
    localparam CP0_STATUS  = 5'd12;
    localparam CP0_CAUSE   = 5'd13;
    localparam CP0_EPC     = 5'd14;

    reg[31:0] count_r;
    reg[31:0] compare_r;
    reg[31:0] status_r;
    reg[31:0] cause_r;
    reg[31:0] epc_r;

    wire ie  = status_r[0];
    wire exl = status_r[1];

    assign epc = epc_r;
    assign irq_active = (|hwirq) & ie & ~exl;

    always @(*) begin
        case (raddr)
            CP0_COUNT:   rdata = count_r;
            CP0_COMPARE: rdata = compare_r;
            CP0_STATUS:  rdata = status_r;
            CP0_CAUSE:   rdata = {cause_r[31:16], hwirq, cause_r[7:0]};
            CP0_EPC:     rdata = epc_r;
            default:     rdata = 32'b0;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count_r   <= 32'b0;
            compare_r <= 32'hffffffff;
            status_r  <= 32'b0; // IE=0, EXL=0
            cause_r   <= 32'b0;
            epc_r     <= 32'b0;
        end else begin
            count_r <= count_r + 32'd1;

            // software writes via mtc0
            if (mtc0we) begin
                case (waddr)
                    CP0_COUNT:   count_r   <= wdata;
                    CP0_COMPARE: compare_r <= wdata;
                    CP0_STATUS:  status_r  <= wdata;
                    CP0_CAUSE:   cause_r   <= wdata;
                    CP0_EPC:     epc_r     <= wdata;
                    default: ;
                endcase
            end

            // interrupt entry / eret take priority over mtc0 for EXL and EPC
            if (exc_take) begin
                epc_r        <= exc_epc;
                status_r[1]  <= 1'b1;    // set EXL
                cause_r[6:2] <= 5'd0;    // ExcCode = 0 (interrupt)
            end else if (eret) begin
                status_r[1]  <= 1'b0;    // clear EXL
            end
        end
    end
endmodule
