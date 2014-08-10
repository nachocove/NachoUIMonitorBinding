//
//  UISegmentedControl+NcUISegmentedControlMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/8/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UISegmentedControl+NcUISegmentedControlMonitor.h"
#import "NcSwizzle.h"

NSString *ncUISegmentedControlKey = @"ncUISegmentedControl";

@implementation UISegmentedControl (NcUISegmentedControlMonitor)

+ (void)setup:(UISegmentedControlCallback)callback
{
    objc_setAssociatedObject(ncUISegmentedControlKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UISegmentedControl")
              original:@selector(sendAction:to:forEvent:)
                   new:@selector(ncSendAction:to:forEvent:)];
}

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    UISegmentedControlCallback callback = objc_getAssociatedObject(ncUISegmentedControlKey, NULL);
    if (nil != callback) {
        callback(self.accessibilityLabel, [self selectedSegmentIndex]);
    }
    [self ncSendAction:action to:target forEvent:event];
}

@end
