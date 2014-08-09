//
//  UIButton+NachoCoveMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/5/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UIButton+NachoCoveMonitor.h"
#import "NcSwizzle.h"

NSString *ncUIButtonKey = @"ncUIButton";

#define  MYDEBUG (0)

@implementation UIButton (NcUIButtonMonitor)


+ (void)setup:(UIButtonCallback)callback
{
    objc_setAssociatedObject(ncUIButtonKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UIButton")
              original:@selector(sendAction:to:forEvent:)
                   new:@selector(ncSendAction:to:forEvent:)];
}

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    UIButtonCallback callback = objc_getAssociatedObject(ncUIButtonKey, NULL);
    if (nil != callback) {
        callback(self.accessibilityLabel);
    }
    [self ncSendAction:action to:target forEvent:event];
}

@end
