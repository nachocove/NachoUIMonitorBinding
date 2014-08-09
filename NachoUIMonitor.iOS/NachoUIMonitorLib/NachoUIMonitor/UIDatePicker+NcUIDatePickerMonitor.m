//
//  UIDatePicker+NcUIDatePickerMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/9/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UIDatePicker+NcUIDatePickerMonitor.h"
#import "NcSwizzle.h"

NSString *ncUIDatePickerKey = @"ncUIDatePicker";

@implementation UIDatePicker (NcUIDatePickerMonitor)

+ (void)setup:(UIDatePickerCallback)callback
{
    objc_setAssociatedObject(ncUIDatePickerKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UIDatePicker")
              original:@selector(sendAction:to:forEvent:)
                   new:@selector(ncSendAction:to:forEvent:)];
}

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    UIDatePickerCallback callback = objc_getAssociatedObject(ncUIDatePickerKey, NULL);
    if (nil != callback) {
        callback(self.accessibilityLabel, [NSString stringWithFormat:@"%@", self.date]);
    }
    [self ncSendAction:action to:target forEvent:event];
}

@end
