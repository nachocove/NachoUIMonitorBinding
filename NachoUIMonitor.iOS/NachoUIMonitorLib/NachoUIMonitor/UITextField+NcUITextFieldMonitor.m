//
//  UITextField+NcUITextFieldMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/9/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextField+NcUITextFieldMonitor.h"
#import "NcSwizzle.h"

NSString *ncUITextFieldKey = @"ncUITextField";

@implementation UITextField (NcUITextFieldMonitor)

+ (void)setup:(UITextFieldCallback)callback
{
    objc_setAssociatedObject(ncUITextFieldKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UITextField")
              original:@selector(sendAction:to:forEvent:)
                   new:@selector(ncSendAction:to:forEvent:)];
}

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    UITextFieldCallback callback = objc_getAssociatedObject(ncUITextFieldKey, NULL);
    if (nil != callback) {
        callback(self.accessibilityLabel);
    }
    [self ncSendAction:action to:target forEvent:event];
}

@end
