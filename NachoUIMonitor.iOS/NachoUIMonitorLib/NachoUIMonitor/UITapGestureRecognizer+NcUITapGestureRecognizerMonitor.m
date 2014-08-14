//
//  UITapGestureRecognizer+NcUITapGestureRecognizerMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/13/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UITapGestureRecognizer+NcUITapGestureRecognizerMonitor.h"
#import "NcSwizzle.h"

NSString *ncUITapGestureRecognizerKey = @"ncUITapGestureRecognizer";

@implementation UITapGestureRecognizer (NcUITapGestureRecognizerMonitor)

+ (void)setup:(UITapGestureRecognizerCallback)callback
{
    objc_setAssociatedObject(ncUITapGestureRecognizerKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UITapGestureRecognizer")
              original:@selector(addTarget:action:)
                   new:@selector(ncAddTarget:action:)];
}

- (id)ncInitWithTarget:(id)target action:(SEL)action
{
    [self ncAddTarget:self action:@selector(ncTapRecognized:)];
    return [self ncInitWithTarget:target action:action];
}

- (void)ncAddTarget:(id)target action:(SEL)action
{
    [self ncAddTarget:target action:action];
    // According to the documentation, this method is smart enough to ignore duplicate adds.
    [self ncAddTarget:self action:@selector(ncTapRecognized:)];
}

- (void)ncTapRecognized:(UIGestureRecognizer *)gestureRecognizer
{
    UITapGestureRecognizerCallback callback = objc_getAssociatedObject(ncUITapGestureRecognizerKey, NULL);
    if (nil == callback) {
        return;
    }
    
    unsigned int numTouches = [gestureRecognizer numberOfTouches];
    CGPoint point1 = { 0.0, 0.0 };
    CGPoint point2 = { 0.0, 0.0 };
    CGPoint point3 = { 0.0, 0.0 };
    if (0 < numTouches) {
        point1 = [gestureRecognizer locationOfTouch:0 inView:gestureRecognizer.view];
        if (1 < numTouches) {
            point2 = [gestureRecognizer locationOfTouch:1 inView:gestureRecognizer.view];
            if (2 < numTouches) {
                point3 = [gestureRecognizer locationOfTouch:2 inView:gestureRecognizer.view];
            }
        }
    }
    callback (gestureRecognizer.accessibilityLabel, numTouches, point1, point2, point3);
}

@end
