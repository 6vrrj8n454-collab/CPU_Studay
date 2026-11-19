# 今日目的
主要是将verilog的代码转换成C++，同时编写C++的测试平台，并比较两个测试平台的仿真速度。

## 速度比较图
### C++
<img width="1083" height="122" alt="{F9F67571-0102-4377-B4CA-233E880010B9}" src="https://github.com/user-attachments/assets/e2c0093c-d502-4b3f-a276-593544e4f704" />

### Verilog
<img width="1131" height="207" alt="{F325D25B-14BE-4704-82B4-95D681602029}" src="https://github.com/user-attachments/assets/2608ca85-3a78-4e20-8eae-b01b6d881336" />
可以看到C++的速度明显要快于Verilog。但两者的仿真的各有优势，写新模块、查 X、看语义用 iverilog；跑大规模回归、做 difftest、需要速度的时候用 Verilator。

