//
//  UIAlertView+NcUIAlertViewMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/12/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UIAlertView+NcUIAlertViewMonitor.h"
#import "NcSwizzle.h"

NSString *ncUIAlertViewKey = @"ncUIAlertView";

@implementation UIAlertView (NcUIAlertViewMonitor)

+ (void)setup:(UIAlertViewCallback)callback
{
    objc_setAssociatedObject(ncUIAlertViewKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UIAlertView")
              original:@selector(setDelegate:)
                   new:@selector(ncSetDelegate:)];
}

- (void)ncSetDelegate:(id)delegate
{
    NcUIAlertViewDelegateProxy *newDelegate = [[NcUIAlertViewDelegateProxy alloc] initWithDelegate:delegate];
    objc_setAssociatedObject(self, NULL, newDelegate, OBJC_ASSOCIATION_RETAIN);
    [self ncSetDelegate:newDelegate];
}

- (void)dealloc
{
    if (nil != self.delegate) {
        objc_removeAssociatedObjects(self);
        [self ncSetDelegate:nil];
    }
}

@end

@implementation NcUIAlertViewDelegateProxy

- (id)initWithDelegate:(id)delegate
{
    self = [self init];
    self.realDelegate = delegate;
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertViewCallback callback = objc_getAssociatedObject(ncUIAlertViewKey, NULL);
    if (nil != callback) {
        callback(alertView.accessibilityLabel, buttonIndex);
    }
    
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        return;
    }
    [self.realDelegate alertView:alertView clickedButtonAtIndex:buttonIndex];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
        return;
    }
    [self.realDelegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        return;
    }
    [self.realDelegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(alertViewCancel:)]) {
        return;
    }
    [self.realDelegate alertViewCancel:alertView];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    if (nil == self.realDelegate) {
        return YES;
    }
    if (![self.realDelegate respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)]) {
        return YES;
    }
    return [self.realDelegate alertViewShouldEnableFirstOtherButton:alertView];
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(didPresentAlertView:)]) {
        return;
    }
    [self.realDelegate didPresentAlertView:alertView];
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(willPresentAlertView:)]) {
        return;
    }
    [self.realDelegate didPresentAlertView:alertView];
}

@end