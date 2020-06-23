//
//  YCYearMonthDatePicker.m
//  SpecDemo
//
//  Created by YC on 2020/6/22.
//  Copyright © 2020 zsai. All rights reserved.
//

#define YCScreenHeight                               [UIScreen mainScreen].bounds.size.height
#define YCScreenWidth                                [UIScreen mainScreen].bounds.size.width

#import "YCYearMonthDatePicker.h"

@interface YCYearMonthDatePicker ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) UIView *lineView;

/// 最大年
@property (nonatomic, assign) NSInteger maxYear;

/// 最小年
@property (nonatomic, assign) NSInteger minYear;

/// 最大月
@property (nonatomic, assign) NSInteger maxMonth;

/// 最小月
@property (nonatomic, assign) NSInteger minMonth;

/// 当前选择的年
@property (nonatomic, assign) NSInteger currentYear;

/// 当前选择的月
@property (nonatomic, assign) NSInteger currentMonth;

@end

@implementation YCYearMonthDatePicker

- (instancetype)init {
    if (self = [super init]) {
        [self initViews];
    }
    return self;
}

#pragma mark - 初始化视图

- (void)initViews {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    self.frame = CGRectMake(0, 0, YCScreenWidth, YCScreenHeight);
    self.bgView.frame = CGRectMake(0, YCScreenHeight, YCScreenWidth, 300);
    [self addSubview:self.bgView];
    
    [self.bgView addSubview:self.pickerView];
    [self.bgView addSubview:self.sureButton];
    [self.bgView addSubview:self.cancelButton];
    [self.bgView addSubview:self.lineView];
    
    self.sureButton.frame = CGRectMake(YCScreenWidth-80, 0, 80, 60);
    self.cancelButton.frame = CGRectMake(0, 0, 80, 60);
    self.pickerView.frame = CGRectMake(0, 40, YCScreenWidth, 300);
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.sureButton.frame), YCScreenWidth, 0.5);
}

// 点击了取消
- (void)closeClick {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0, YCScreenHeight, YCScreenWidth, 300);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 点击了确认
- (void)sureClick {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0, YCScreenHeight, YCScreenWidth, 300);
    } completion:^(BOOL finished) {
        self.dateComfirmBlock?self.dateComfirmBlock([NSString stringWithFormat:@"%ld",self.currentYear], [NSString stringWithFormat:@"%02ld",self.currentMonth]):nil;
        [self removeFromSuperview];
    }];
}

/// 显示年月选择器
/// @param beginDateStr 开始日期 YYYY-MM
/// @param endDateStr 结束日期 YYYY-MM
- (void)showWithBeginDateStr:(NSString *)beginDateStr endDateStr:(NSString *)endDateStr {
    NSArray *beginArr = [beginDateStr componentsSeparatedByString:@"-"];
    NSArray *endArr = [endDateStr componentsSeparatedByString:@"-"];
    self.minYear = [beginArr[0] integerValue];
    self.minMonth = [beginArr[1] integerValue];
    self.maxYear = [endArr[0] integerValue];
    self.maxMonth = [endArr[1] integerValue];
    
    if (self.defaultDateStr) {
        // 默认选择
        NSArray *defaultArr = [self.defaultDateStr componentsSeparatedByString:@"-"];
        NSInteger defaultYear = [defaultArr[0] integerValue];
        NSInteger defaultMonth = [defaultArr[1] integerValue];
        [self.pickerView selectRow:(defaultYear-self.minYear) inComponent:0 animated:NO];
        [self.pickerView selectRow:(defaultMonth-1) inComponent:1 animated:NO];
    }
    
    [self.pickerView reloadAllComponents];
    [self show];
}

- (void)show {
    UIWindow *keyWindow;
    if (@available(iOS 13, *)) {
        keyWindow = [UIApplication sharedApplication].windows[0];
    } else {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0, YCScreenHeight-300, YCScreenWidth, 300);
    }];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.maxYear-self.minYear+1;
    } else {
        if (self.maxYear == self.minYear) {
            // 仅有当年
            return self.maxMonth-self.minMonth+1;
        }
        if (self.currentYear == self.minYear) {
            // 最小年
            return 12-self.minMonth+1;
        } else if (self.currentYear == self.maxYear) {
            // 最大年
            return self.maxMonth;
        } else {
            return 12;
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        self.currentYear = self.minYear+row;
        [pickerView reloadComponent:1];
        return [NSString stringWithFormat:@"%ld%@",self.currentYear, NSLocalizedString(@"年", nil)];
    } else {
        if (self.currentYear == self.minYear) {
            // 最小年份
            self.currentMonth = row+self.minMonth;
            return [NSString stringWithFormat:@"%ld%@",self.currentMonth, NSLocalizedString(@"月", nil)];
        } else {
            // 其他年份
            self.currentMonth = row+1;
            return [NSString stringWithFormat:@"%ld%@",self.currentMonth, NSLocalizedString(@"月", nil)];
        }
    }
}

#pragma mark - Getters/Setters

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_sureButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (void)setDefaultDateStr:(NSString *)defaultDateStr {
    _defaultDateStr = defaultDateStr;
    if (self.maxYear) {
        NSArray *defaultArr = [defaultDateStr componentsSeparatedByString:@"-"];
        NSInteger defaultYear = [defaultArr[0] integerValue];
        NSInteger defaultMonth = [defaultArr[1] integerValue];
        [self.pickerView selectRow:(defaultYear-self.minYear) inComponent:0 animated:NO];
        [self.pickerView selectRow:(defaultMonth-1) inComponent:1 animated:NO];
    }
}

- (void)setCancelColor:(UIColor *)cancelColor {
    _cancelColor = cancelColor;
    [self.cancelButton setTitleColor:cancelColor forState:UIControlStateNormal];
}

- (void)setSureColor:(UIColor *)sureColor {
    _sureColor = sureColor;
    [self.sureButton setTitleColor:sureColor forState:UIControlStateNormal];
}

@end
