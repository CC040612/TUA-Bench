# 首次端到端接入测试

- 任务：010-pivot-product-revenue
- 模型：openai/gpt-6-luna，经 Cockpit Plus 通道
- 配置：循环恢复开启，最多 10 轮，单次输出上限 2048 token
- 结果：官方 reward=0，无程序异常，实际执行 7 轮
- 输入 token：24576
- 输出 token：2444
- 缓存 token：0
- Harbor 报告 cost_usd=0.0036796；价格来源未核实，不视为 Plus 实际扣费
- 未记录循环恢复事件，不能据此判断改进效果

## 失败分析

官方 metric_spec 比较 Sheet2 的 Pivot Table 结构，
包含 col_fields、filter、row_fields 和 data_fields。
执行日志显示模型用 SUMIF 创建普通汇总表。
主要失败原因据此判断为未创建所要求的数据透视表；
尚未独立检查保存后的 XLSX 内部结构。

本次仅验证接入，不作为正式性能比较结论。
