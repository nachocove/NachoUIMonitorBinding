//
//  UIPageControl+NcUIPageControlMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/9/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UIPageControl+NcUIPageControlMonitor.h"
#import "NcSwizzle.h"

NSString *ncUIPageControlKey = @"ncUIPageControl";

@implementation UIPageControl (NcUIPageControlMonitor)

+ (void)setup:(UIPageControlCallback)callback
{
    objc_setAssociatedObject(ncUIPageControlKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UIPageControl")
              original:@selector(sendAction:to:forEvent:)
                   new:@selector(ncSendAction:to:forEvent:)];
}

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    UIPageControlCallback callback = objc_getAssociatedObject(ncUIPageControlKey, NULL);
    if (nil != callback) {
        callback(self.accessibilityLabel, self.currentPage);
    }
    [self ncSendAction:action to:target forEvent:event];
}

@end
