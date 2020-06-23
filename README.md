# YCYearMonthDatePicker

[![CI Status](https://img.shields.io/travis/杨超/YCYearMonthDatePicker.svg?style=flat)](https://travis-ci.org/杨超/YCYearMonthDatePicker)
[![Version](https://img.shields.io/cocoapods/v/YCYearMonthDatePicker.svg?style=flat)](https://cocoapods.org/pods/YCYearMonthDatePicker)
[![License](https://img.shields.io/cocoapods/l/YCYearMonthDatePicker.svg?style=flat)](https://cocoapods.org/pods/YCYearMonthDatePicker)
[![Platform](https://img.shields.io/cocoapods/p/YCYearMonthDatePicker.svg?style=flat)](https://cocoapods.org/pods/YCYearMonthDatePicker)

## introduce

年月选择器

一行代码完成基本需求

## How To Use

<img src="https://github.com/1552612373/YCYearMonthDatePicker/blob/master/demo.gif" width=200 alt="样式">

```
YCYearMonthDatePicker *picker = [YCYearMonthDatePicker new];
picker.dateComfirmBlock = ^(NSString * _Nonnull year, NSString * _Nonnull month) {
    
};
[picker showWithBeginDateStr:@"2020-01" endDateStr:@"2020-12"];
```


## Installation

YCYearMonthDatePicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YCYearMonthDatePicker'
```

## Author

杨超, 1552612373@qq.com

## License

YCYearMonthDatePicker is available under the MIT license. See the LICENSE file for more info.
