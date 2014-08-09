//
//  UIDatePicker+NcUIDatePickerMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/9/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIDatePickerCallback)(NSString *desc, NSString *date);

@interface UIDatePicker (NcUIDatePickerMonitor)

+ (void)setup:(UIDatePickerCallback)callback;

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;

@end
