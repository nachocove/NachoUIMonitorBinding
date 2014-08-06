//
//  UIButton+NachoCoveMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/5/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import "objc/runtime.h"
#import "UIButton+NachoCoveMonitor.h"

NSString *ncUIButtonKey = @"ncUIButton";

@implementation UIButton (NcUIButtonMonitor)

// For debugging only
#if 0
+ (void)dump:(Class)cls method:(SEL)selector
{
    Method method = class_getInstanceMethod(cls, selector);
    NSLog(@"[%@ %@] %p", NSStringFromClass(cls), NSStringFromSelector(selector),
          method_getImplementation(method));
}
#endif

+ (void)setup:(UIButtonCallback)callback
{
    objc_setAssociatedObject(ncUIButtonKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    Class cls = objc_getClass("UIButton");
    
    // Dump the existing method
    //[UIButton dump:cls method:@selector(sendAction:to:forEvent:)];
    //[UIButton dump:cls method:@selector(ncSendAction:to:forEvent:)];
    
    // Add the method first
    Method origMethod = class_getInstanceMethod(cls, @selector(sendAction:to:forEvent:));
    Method newMethod = class_getInstanceMethod(cls, @selector(ncSendAction:to:forEvent:));
    IMP origFunction = method_getImplementation(origMethod);
    IMP newFunction = method_getImplementation(newMethod);
    
    if (nil == method_setImplementation(origMethod, newFunction)) {
        NSLog(@"fail to swizzle");
    }
    method_setImplementation(newMethod, origFunction);
}

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    UIButtonCallback callback = objc_getAssociatedObject(ncUIButtonKey, NULL);
    if (nil != callback) {
        callback(self.currentTitle);
    }
    [self ncSendAction:action to:target forEvent:event];
}

@end
