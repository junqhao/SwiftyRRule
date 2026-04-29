# SwiftyRRule

SwiftyRRule 是一个用于解析和生成 iCalendar RRule（重复规则）的 Swift 库，基于 JavaScript 的 rrule.js 实现。

灵感来源于 [RRuleSwift](https://github.com/teambition/RRuleSwift)。

## 特性

- ✅ 支持完整的 iCalendar RRule 标准
- ✅ 支持 Swift Package Manager
- ✅ 支持所有重复频率：每年、每月、每周、每日、每小时、每分钟、每秒
- ✅ 支持复杂的重复规则：按星期、按月份日期、按年份日期、按周数等
- ✅ 支持包含日期 (RDATE) 和排除日期 (EXDATE)
- ✅ 支持重复结束条件：按次数或按结束日期
- ✅ 支持 RRule 字符串与 `RecurrenceRule` 对象之间的相互转换
- ✅ 支持获取指定日期范围内的所有发生时间

## 安装

### Swift Package Manager

在 `Package.swift` 中添加依赖：

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SwiftyRRule.git", from: "1.0.0")
]
```

或在 Xcode 中：

1. 选择 **File** → **Add Package Dependencies...**
2. 输入仓库 URL: `https://github.com/yourusername/SwiftyRRule.git`
3. 点击 **Add Package**

## 使用示例

### 基本用法

```swift
import SwiftyRRule

// 创建一个每周重复的规则
var rule = RecurrenceRule(frequency: .weekly)
rule.byweekday = [.wednesday, .friday]
rule.byhour = [8]
rule.byminute = [20]
rule.startDate = Date()
rule.interval = 2

// 转换为 RRule 字符串
let rruleString = rule.toRRuleString()
// 输出: RRULE:FREQ=WEEKLY;INTERVAL=2;BYHOUR=8;BYMINUTE=20;BYDAY=WE,FR

// 获取所有发生时间
let dates = rule.allOccurrences(endless: 5)
```

### 从 RRule 字符串解析

```swift
let rruleString = "RRULE:FREQ=DAILY;INTERVAL=1;COUNT=10"
if let rule = RecurrenceRule(rruleString: rruleString) {
    let dates = rule.allOccurrences()
}
```

### 获取指定日期范围内的发生时间

```swift
let startDate = Date()
let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!

let occurrences = rule.occurrences(between: startDate, and: endDate)
```

### 复杂的重复规则

```swift
var rule = RecurrenceRule(frequency: .monthly)
rule.bymonthday = [1, 15]  // 每月 1 日和 15 日
rule.byhour = [9, 18]      // 上午 9 点和下午 6 点
rule.byminute = [0]
rule.recurrenceEnd = EKRecurrenceEnd(occurrenceCount: 20)  // 只重复 20 次

let dates = rule.allOccurrences()
```

### 包含和排除特定日期

```swift
var rule = RecurrenceRule(frequency: .daily)

// 添加包含日期
rule.rdate = InclusionDate(dates: [specialDate1, specialDate2])

// 添加排除日期
rule.exdate = ExclusionDate(dates: [holiday1, holiday2], component: .day)

let dates = rule.allOccurrences()
```

## RecurrenceRule 属性

| 属性 | 类型 | 说明 |
|------|------|------|
| `frequency` | `RecurrenceFrequency` | 重复频率（必需） |
| `interval` | `Int` | 重复间隔，默认为 1 |
| `firstDayOfWeek` | `EKWeekday` | 每周的第一天，默认为周一 |
| `startDate` | `Date` | 开始日期，默认为当前日期 |
| `recurrenceEnd` | `EKRecurrenceEnd?` | 重复结束条件 |
| `bysetpos` | `[Int]` | 按位置筛选 |
| `byyearday` | `[Int]` | 按年份日期（1-366 或 -1 到 -366）|
| `bymonth` | `[Int]` | 按月份（1-12）|
| `byweekno` | `[Int]` | 按周数（1-53 或 -1 到 -53）|
| `bymonthday` | `[Int]` | 按月份日期（1-31 或 -1 到 -31）|
| `byweekday` | `[EKWeekday]` | 按星期几 |
| `byhour` | `[Int]` | 按小时 |
| `byminute` | `[Int]` | 按分钟 |
| `bysecond` | `[Int]` | 按秒 |
| `rdate` | `InclusionDate?` | 包含日期 |
| `exdate` | `ExclusionDate?` | 排除日期 |

## RecurrenceFrequency

支持以下重复频率：

- `.yearly` - 每年
- `.monthly` - 每月
- `.weekly` - 每周
- `.daily` - 每日
- `.hourly` - 每小时
- `.minutely` - 每分钟
- `.secondly` - 每秒

## 方法

### RecurrenceRule

- `init(frequency: RecurrenceFrequency)` - 使用指定频率创建规则
- `init?(rruleString: String)` - 从 RRule 字符串解析
- `toRRuleString() -> String` - 转换为 RRule 字符串

### 获取发生时间

- `allOccurrences(endless: Int = 500) -> [Date]` - 获取所有发生时间
- `occurrences(between: Date, and: Date, endless: Int = 500) -> [Date]` - 获取指定日期范围内的发生时间

## 系统要求

- iOS 15.0+ / macOS 12.0+ / tvOS 15.0+ / watchOS 8.0+
- Swift 6.1+
- Xcode 16.0+

## 许可证

SwiftyRRule 基于 MIT 许可证开源。详见 [LICENSE](LICENSE) 文件。

## 致谢

- [rrule.js](https://github.com/jakubroztocil/rrule) - 底层的 JavaScript 重复规则库
- [RRuleSwift](https://github.com/teambition/RRuleSwift) - 灵感来源
