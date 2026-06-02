`timescale 1ns / 1ps

module hazard(
    // fetch stage
    output wire stallF,
    // decode stage
    input wire[4:0] rsD,
    input wire[4:0] rtD,
    input wire branchD,
    input wire jrD,
    output wire forwardaD,
    output wire forwardbD,
    output wire stallD,
    // execute stage
    input wire[4:0] rsE,
    input wire[4:0] rtE,
    input wire[4:0] writeregE,
    input wire regwriteE,
    input wire memtoregE,
    output reg[1:0] forwardaE,
    output reg[1:0] forwardbE,
    output wire flushE,
    // mem stage
    input wire[4:0] writeregM,
    input wire regwriteM,
    input wire memtoregM,
    // write back stage
    input wire[4:0] writeregW,
    input wire regwriteW
    );

    wire lwstallD;
    wire branchstallD;
    wire jrstallD;

    // Forwarding sources to D stage for branch equality and jr target.
    assign forwardaD = (rsD != 5'b0) && (rsD == writeregM) && regwriteM;
    assign forwardbD = (rtD != 5'b0) && (rtD == writeregM) && regwriteM;

    // Forwarding sources to E stage ALU.
    always @(*) begin
        forwardaE = 2'b00;
        forwardbE = 2'b00;

        if (rsE != 5'b0) begin
            if ((rsE == writeregM) && regwriteM) begin
                forwardaE = 2'b10;
            end else if ((rsE == writeregW) && regwriteW) begin
                forwardaE = 2'b01;
            end
        end

        if (rtE != 5'b0) begin
            if ((rtE == writeregM) && regwriteM) begin
                forwardbE = 2'b10;
            end else if ((rtE == writeregW) && regwriteW) begin
                forwardbE = 2'b01;
            end
        end
    end

    assign lwstallD = memtoregE && ((rtE == rsD) || (rtE == rtD));

    assign branchstallD = branchD &&
        ((regwriteE && ((writeregE == rsD) || (writeregE == rtD))) ||
         (memtoregM && ((writeregM == rsD) || (writeregM == rtD))));

    assign jrstallD = jrD &&
        ((regwriteE && (writeregE == rsD)) ||
         (memtoregM && (writeregM == rsD)));

    assign stallD = lwstallD || branchstallD || jrstallD;
    assign stallF = stallD;
    assign flushE = stallD;
endmodule
