# 4位计数器的设计说明

## 设计思路及难点讲解
我设计了一个简单的八位计数器，其中当cnt计数记满时，carrry输出为真，用来说明已经产生高位截断。当复位信号来临的时候，将cnt复位为0000，如果没有来临，且en使能信号为真的时候，cnt开始随时间上升沿的来临计数。

## Testbench的难点
测试模块中，第一个复位模块@(posedge clk); #1;中（#1）的目的是为了避开时钟竞争窗口。后续循环语句中采用check((i + 1) % 16);可以很好的避免了当期望值超过了15，来到16、17的情况，造成不符合四位计数器的硬件要求，从而造成测试报错。

## 仿真与综合结果

### 仿真图
<img width="1909" height="1068" alt="{2DCE28F1-C929-4108-92C0-5685F51B2DF3}" src="https://github.com/user-attachments/assets/43bfddeb-15d9-4202-8de0-30acf03eafec" />
<img width="1127" height="774" alt="{B8122CBB-937B-4C60-A208-6A7337D0BBC6}" src="https://github.com/user-attachments/assets/d6de62cd-2e20-4830-af64-3461a60931b3" />

### 图片分析
我们可以看到在cnt计数到15的时候，carry开始变化为真。如图：
<img width="1680" height="184" alt="{80630907-6FA9-48CC-817D-AD5D2E42BB2E}" src="https://github.com/user-attachments/assets/2229e20f-5793-40c2-97e1-f5e7946bf0a7" />
但由于carry采用的是assign语句，所以carry 比 cnt 归零早一拍。
