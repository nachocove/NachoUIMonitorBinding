//
//  NachoUIMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/6/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import "NachoUIMonitor.h"

@implementation NachoUIMonitor

+ (void)setupUIButton:(UIButtonCallback)callback
{
    [UIButton setup:callback];
}

+ (void)setupUISegmentedControl:(UISegmentedControlCallback)callback
{
    [UISegmentedControl setup:callback];
}

+ (void)setupUISwitch:(UISwitchCallback)callback
{
    [UISwitch setup:callback];
}

+ (void)setupUIDatePicker:(UIDatePickerCallback)callback
{
    [UIDatePicker setup:callback];
}

+ (void)setupUITextField:(UITextFieldCallback)callback
{
    [UITextField setup:callback];
}

+ (void)setupUIPageControl:(UIPageControlCallback)callback
{
    [UIPageControl setup:callback];
}

+ (void)setupUIAlertView:(UIAlertViewCallback)callback
{
    [UIAlertView setup:callback];
}

+ (void)setupUIActionSheet:(UIActionSheetCallback)callback
{
    [UIActionSheet setup:callback];
}

@end