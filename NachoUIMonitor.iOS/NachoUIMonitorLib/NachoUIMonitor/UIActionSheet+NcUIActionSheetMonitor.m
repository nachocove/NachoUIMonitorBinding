//
//  UIActionSheet+NcUIActionSheetMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/12/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UIActionSheet+NcUIActionSheetMonitor.h"
#import "NcSwizzle.h"


NSString *ncUIActionSheetKey = @"ncUIActionSheet";

@implementation UIActionSheet (NcUIActionSheetMonitor)

+ (void)setup:(UIActionSheetCallback)callback
{
    objc_setAssociatedObject(ncUIActionSheetKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UIActionSheet")
              original:@selector(setDelegate:)
                   new:@selector(ncSetDelegate:)];
}

- (void)ncSetDelegate:(id)delegate
{
    NcUIActionSheetDelegateProxy *newDelegate = [[NcUIActionSheetDelegateProxy alloc] initWithDelegate:delegate];
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

@implementation NcUIActionSheetDelegateProxy

- (id)initWithDelegate:(id)delegate
{
    self = [self init];
    self.realDelegate = delegate;
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIActionSheetCallback callback = objc_getAssociatedObject(ncUIActionSheetKey, NULL);
    if (nil != callback) {
        callback(actionSheet.accessibilityLabel, buttonIndex);
    }
    
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        return;
    }
    [self.realDelegate actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
        return;
    }
    [self.realDelegate actionSheet:actionSheet didDismissWithButtonIndex:buttonIndex];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
        return;
    }
    [self.realDelegate actionSheet:actionSheet willDismissWithButtonIndex:buttonIndex];
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(actionSheetCancel:)]) {
        return;
    }
    [self.realDelegate actionSheetCancel:actionSheet];
}

- (BOOL)actionSheetShouldEnableFirstOtherButton:(UIActionSheet *)actionSheet
{
    if (nil == self.realDelegate) {
        return YES;
    }
    if (![self.realDelegate respondsToSelector:@selector(actionSheetShouldEnableFirstOtherButton:)]) {
        return YES;
    }
    return [self.realDelegate actionSheetShouldEnableFirstOtherButton:actionSheet];
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(didPresentActionSheet:)]) {
        return;
    }
    [self.realDelegate didPresentActionSheet:actionSheet];
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    if (nil == self.realDelegate) {
        return;
    }
    if (![self.realDelegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        return;
    }
    [self.realDelegate didPresentActionSheet:actionSheet];
}

@end