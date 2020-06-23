//
//  YCYearMonthDatePicker.h
//  SpecDemo
//
//  Created by YC on 2020/6/22.
//  Copyright © 2020 zsai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DateComfirmBlock)(NSString *year, NSString *month);

@interface YCYearMonthDatePicker : UIView

/// 显示年月选择器
/// @param beginDateStr 开始日期 YYYY-MM
/// @param endDateStr 结束日期 YYYY-MM
- (void)showWithBeginDateStr:(NSString *)beginDateStr endDateStr:(NSString *)endDateStr;

/// 默认显示日期 yyyy-MM
@property (nonatomic, copy) NSString *defaultDateStr;

@property (nonatomic, copy) DateComfirmBlock dateComfirmBlock;

@end

NS_ASSUME_NONNULL_END
