//
//  YCViewController.m
//  YCYearMonthDatePicker
//
//  Created by 杨超 on 06/23/2020.
//  Copyright (c) 2020 杨超. All rights reserved.
//

#import "YCViewController.h"
#import <YCYearMonthDatePicker/YCYearMonthDatePicker.h>

#import "YCCommon.h"

@interface YCViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation YCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = self.myTableView;

}

#pragma mark - action

- (void)cellClick0 {
    YCYearMonthDatePicker *picker = [YCYearMonthDatePicker new];
    picker.dateComfirmBlock = ^(NSString * _Nonnull year, NSString * _Nonnull month) {
        NSLog(@"year:%@\nmonth:%@",year,month);
    };
    [picker showWithBeginDateStr:@"2020-01" endDateStr:@"2020-12"];
}

- (void)cellClick1 {
    NSDate *maxmumDate = [NSDate date];
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
    [formatterMonth setDateFormat:@"MM"];
    NSString *currentYear = [yearFormatter stringFromDate:maxmumDate];
    NSString *currentMonth = [formatterMonth stringFromDate:maxmumDate];
    
    YCYearMonthDatePicker *picker = [YCYearMonthDatePicker new];
    picker.dateComfirmBlock = ^(NSString * _Nonnull year, NSString * _Nonnull month) {
        NSLog(@"year:%@\nmonth:%@",year,month);
    };
    picker.defaultDateStr = [NSString stringWithFormat:@"%@-%@",currentYear,currentMonth];
    [picker showWithBeginDateStr:@"2020-01" endDateStr:[NSString stringWithFormat:@"%@-%@",currentYear,currentMonth]];
}

- (void)cellClick2 {
    NSDate *maxmumDate = [NSDate date];
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
    [formatterMonth setDateFormat:@"MM"];
    NSString *currentYear = [yearFormatter stringFromDate:maxmumDate];
    NSString *currentMonth = [formatterMonth stringFromDate:maxmumDate];
    
    YCYearMonthDatePicker *picker = [YCYearMonthDatePicker new];
    picker.dateComfirmBlock = ^(NSString * _Nonnull year, NSString * _Nonnull month) {
        NSLog(@"year:%@\nmonth:%@",year,month);
    };
    [picker showWithBeginDateStr:[NSString stringWithFormat:@"%@-%@",currentYear,currentMonth] endDateStr:[NSString stringWithFormat:@"%@-12",@(currentYear.integerValue+10)]];
}

- (void)cellClick3 {
    YCYearMonthDatePicker *picker = [YCYearMonthDatePicker new];
    picker.dateComfirmBlock = ^(NSString * _Nonnull year, NSString * _Nonnull month) {
        NSLog(@"year:%@\nmonth:%@",year,month);
    };
    picker.defaultDateStr = @"2020-08";
    picker.cancelColor = [UIColor purpleColor];
    picker.sureColor = [UIColor orangeColor];
    [picker showWithBeginDateStr:@"2020-01" endDateStr:@"2020-12"];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: {
            [self cellClick0];
        }
            break;
            
        case 1: {
            [self cellClick1];
        }
            break;
            
        case 2: {
            [self cellClick2];
        }
            break;
            
        case 3: {
            [self cellClick3];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"例：固定值起始，固定值结束";
        }
            break;
            
        case 1: {
            cell.textLabel.text = @"例：固定值起始，当前月结束";
        }
            break;
            
        case 2: {
            cell.textLabel.text = @"例：当前月起始，十年后结束";
        }
            break;
            
        case 3: {
            cell.textLabel.text = @"例：默认选择指定月份";
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.numberOfLines = 0;
    testLabel.text = @"仅举几个例子，调用方式其实是一样的:\n[picker showWithBeginDateStr:xxx endDateStr:yyy];\n";
    return testLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

#pragma mark - Getters/Setters

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _myTableView.tableFooterView = [UIView new];
    }
    return _myTableView;
}

@end
