#include <cstdio>
#include "Vcounter.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

static vluint64_t t = 0;
double sc_time_stamp() { return (double)t;}

int main(int argc, char**argv) {
    Verilated::commandArgs(argc, argv);

    Vcounter* dut = new Vcounter;
    VerilatedVcdC* vcd = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    dut->trace(vcd, 99);
    vcd->open("coumter.vcd");

    auto step = [&]() {
        dut->clk = 0; dut->eval(); vcd->dump(t); t += 5;
        dut->clk = 1; dut->eval(); vcd->dump(t); t += 5;
    };

    int errors = 0;

    dut->rst_n = 0;
    dut->en    = 0;
    step(); step();

    dut->rst_n = 1;
    for (int i = 1; i <= 1000000; i++) {
        dut->en = 1;
        step();
        int exp = i & 0xF;
        if ((int)dut->cnt != exp) {
            errors++;
            printf("FAIL @%d: cnt=%d exp=%d\n", i, (int)dut->cnt, exp);
        }
    } 

    dut->en = 0;
    step(); step(); step();
    if ((int)dut->cnt != 2) {errors++; printf("FAIL: hold, cnt=%d\n", (int)dut->cnt);}

    printf(errors ? "FAILED: %d errors\n" : "PASS: counter ok\n", errors);

    dut->final();
    vcd->close();
    delete dut;
    return 0;
}