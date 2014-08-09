//
//  NcSwizzle.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/8/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import "objc/runtime.h"
#import "NcSwizzle.h"

@implementation NcSwizzle

#if MYDEBUG
// For debugging only
+ (void)dump:(Class)cls method:(SEL)selector
{
    Method method = class_getInstanceMethod(cls, selector);
    NSLog(@"[%@ %@] %p", NSStringFromClass(cls), NSStringFromSelector(selector),
          method_getImplementation(method));
}
#endif

+ (void)swizzle:(Class)cls original:(SEL)origSelector new:(SEL)newSelector
{
    // Dump the existing method
#if MYDEBUG
    [NcSwizzle dump:cls method:origSelector];
    [NcSwizzle dump:cls method:newSelector];
#endif
    
    Method origMethod = class_getInstanceMethod(cls, origSelector);
    Method newMethod = class_getInstanceMethod(cls, newSelector);
    IMP origFunction = method_getImplementation(origMethod);
    IMP newFunction = method_getImplementation(newMethod);
    
    // Add the method first
    class_addMethod(cls, origSelector, origFunction, method_getTypeEncoding(origMethod));
    origMethod = class_getInstanceMethod(cls, origSelector);
    
    if (nil == method_setImplementation(origMethod, newFunction)) {
        NSLog(@"fail to swizzle");
    }
    method_setImplementation(newMethod, origFunction);
    
#if MYDEBUG
    [NcSwizzle dump:cls method:@selector(sendAction:to:forEvent:)];
    [NcSwizzle dump:cls method:@selector(ncSendAction:to:forEvent:)];
#endif
}

@end


