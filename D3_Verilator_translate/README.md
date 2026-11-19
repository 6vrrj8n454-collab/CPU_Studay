# 今日目的
主要是将verilog的代码转换成C++，同时编写C++的测试平台，并比较两个测试平台的仿真速度。同时写了一个seg7来练习case语句。

## 常见问题
1.case语句的中要注意写好default，防止出现latch。
reg 只表示“在过程块里被赋值”，在 always @(*) 里仍然是组合逻辑。

## 重要代码
verilator --cc counter.v --exe sim_main.cpp --build -Wall -O3 --trace --top-module counter（将Verilog 代码和 C++ 测试台结合起来，一键生成并编译出一个能在 Linux 下直接运行的高速仿真可执行文件）。

## 速度比较图
### C++
<img width="1083" height="122" alt="{F9F67571-0102-4377-B4CA-233E880010B9}" src="https://github.com/user-attachments/assets/e2c0093c-d502-4b3f-a276-593544e4f704" />

### Verilog
<img width="1131" height="207" alt="{F325D25B-14BE-4704-82B4-95D681602029}" src="https://github.com/user-attachments/assets/2608ca85-3a78-4e20-8eae-b01b6d881336" />
可以看到C++的速度明显要快于Verilog。但两者的仿真的各有优势，写新模块、查 X、看语义用 iverilog；跑大规模回归、做 difftest、需要速度的时候用 Verilator。

## 仿真结果图
<img width="1920" height="1040" alt="{9F1F7D10-5272-4525-9E2C-45FC8725002C}" src="https://github.com/user-attachments/assets/32b7a198-8678-476f-8e2d-a6d562f81090" />
<img width="1913" height="1023" alt="{133689AF-40CB-487D-A883-6F126EBCEB1F}" src="https://github.com/user-attachments/assets/e9abe620-7dd7-44d2-a175-92add6a243a2" />
<img width="1919" height="1080" alt="{B804C15D-8AA5-4906-AA56-9C2E1CA968ED}" src="https://github.com/user-attachments/assets/cf486047-57d4-4e96-a75b-5c4fc0930f5b" />
