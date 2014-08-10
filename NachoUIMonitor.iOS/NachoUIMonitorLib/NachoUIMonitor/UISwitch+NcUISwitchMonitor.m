//
//  UISwitch+NcUISwitchMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/9/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UISwitch+NcUISwitchMonitor.h"
#import "NcSwizzle.h"

NSString *ncUISwitchKey = @"ncUISwitch";

@implementation UISwitch (NcUISwitchMonitor)

+ (void)setup:(UISwitchCallback)callback
{
    objc_setAssociatedObject(ncUISwitchKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UISwitch")
              original:@selector(sendAction:to:forEvent:)
                   new:@selector(ncSendAction:to:forEvent:)];
}

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    UISwitchCallback callback = objc_getAssociatedObject(ncUISwitchKey, NULL);
    if (nil != callback) {
        callback(self.accessibilityLabel, self.on ? @"ON" : @"OFF");
    }
    [self ncSendAction:action to:target forEvent:event];
}

@end
