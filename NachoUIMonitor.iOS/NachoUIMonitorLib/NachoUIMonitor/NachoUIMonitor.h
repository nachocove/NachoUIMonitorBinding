//
//  NachoUIMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/6/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButton+NachoCoveMonitor.h"
#import "UISegmentedControl+NcUISegmentedControlMonitor.h"
#import "UISwitch+NcUISwitchMonitor.h"
#import "UIDatePicker+NcUIDatePickerMonitor.h"
#import "UITextField+NcUITextFieldMonitor.h"
#import "UIPageControl+NcUIPageControlMonitor.h"
#import "UIAlertView+NcUIAlertViewMonitor.h"
#import "UIActionSheet+NcUIActionSheetMonitor.h"
#import "UITapGestureRecognizer+NcUITapGestureRecognizerMonitor.h"
#import "UITableView+NcUITableViewMonitor.h"

@interface NachoUIMonitor : NSObject

+ (void)setupUIButton:(UIButtonCallback)callback;
+ (void)setupUISegmentedControl:(UISegmentedControlCallback)callback;
+ (void)setupUISwitch:(UISwitchCallback)callback;
+ (void)setupUIDatePicker:(UIDatePickerCallback)callback;
+ (void)setupUITextField:(UITextFieldCallback)callback;
+ (void)setupUIPageControl:(UIPageControlCallback)callback;
+ (void)setupUIAlertView:(UIAlertViewCallback)callback;
+ (void)setupUIActionSheet:(UIActionSheetCallback)callback;
+ (void)setupUITapGestureRecognizer:(UITapGestureRecognizerCallback)callback;
+ (void)setupUITableView:(UITableViewCallback)callback;

@end
