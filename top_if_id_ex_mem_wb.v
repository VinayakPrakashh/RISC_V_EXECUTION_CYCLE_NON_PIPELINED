`timescale 1ns / 1ps
module top_if_id_ex_mem_wb(
    clk,rst);
input clk,rst;
wire [31:0] PC_NEXT;
wire [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR,ID_EX_PC;
wire [31:0] PC_MEM,IR_MEM;
wire [31:0] IF_ID_IR,IF_ID_NPC;
wire [4:0] EX_RW_addr,EX_RD1_addr;
wire [31:0] EX_WR1,EX_RD1,EX_RD2,MEM_WB_ALU_OUT,MEM_WB_PC,MEM_WB_IR;

wire [31:0] EX_MEM_ALU_OUT,EX_MEM_IR,EX_MEM_PC;
instruction_mem1 instruction_memory6(
    .A(PC_MEM),
    .RD(IR_MEM)
);

instruction_fetch instruction_fetch1(
    .PC_NEXT(PC_NEXT),
    .clk(clk),
    .rst(rst),
    .IF_ID_IR(IF_ID_IR),
    .IF_ID_NPC(IF_ID_NPC),
    .PC(PC_MEM),
    .IR_MEM(IR_MEM)
);
reg_file rg(.WE(EX_WE),.RE(EX_RE),.RW_addr(EX_RW_addr),.RD1_addr(EX_RD1_addr),.RD1(EX_RD1),.RD2(EX_RD2),.WR1(EX_WR1));
instruction_decode instruction_decode1(
    .IF_ID_IR(IF_ID_IR),
    .IF_ID_NPC(IF_ID_NPC),
    .ID_EX_A(ID_EX_A),
    .ID_EX_B(ID_EX_B),
    .ID_EX_IMM(ID_EX_IMM),
    .ID_EX_NPC(ID_EX_NPC),
    .ID_EX_IR(ID_EX_IR),
    .WE(EX_WE),
    .RE(EX_RE),
    .RW_addr(EX_RW_addr),
    .RD1_addr(EX_RD1_addr),
    .WR1(EX_WR1),
    .RD1(EX_RD1),
    .RD2(EX_RD2),
    .PC(PC_MEM),
    .ID_EX_PC(ID_EX_PC)

);
instruction_execution instruction_execution1(
    .ID_EX_A(ID_EX_A),
    .ID_EX_B(ID_EX_B),
    .ID_EX_IMM(ID_EX_IMM),
    .ID_EX_NPC(ID_EX_NPC),
    .ID_EX_IR(ID_EX_IR),
    .EX_MEM_ALU_OUT(EX_MEM_ALU_OUT),
    .EX_MEM_IR(EX_MEM_IR),
    .EX_MEM_PC(EX_MEM_PC),
    .ID_EX_PC(ID_EX_PC)
);
Memory_access memory_access1(
    .EX_MEM_PC(EX_MEM_PC),
    .EX_MEM_IR(EX_MEM_IR),
    .EX_MEM_ALU_OUT(EX_MEM_ALU_OUT),
    .MEM_WB_PC(MEM_WB_PC),
    .MEM_WB_IR(MEM_WB_IR),
    .MEM_WB_ALU_OUT(MEM_WB_ALU_OUT));
write_back write_back1(
    .MEM_WB_PC(MEM_WB_PC),
    .MEM_WB_IR(MEM_WB_IR),
    .MEM_WB_ALU_OUT(MEM_WB_ALU_OUT),
    .WB_IF_PC(PC_NEXT)
);
endmodule