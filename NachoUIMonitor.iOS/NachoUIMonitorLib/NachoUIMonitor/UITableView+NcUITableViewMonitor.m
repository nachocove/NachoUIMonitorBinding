//
//  UITableView+NcUITableViewMonitor.m
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/13/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableView+NcUITableViewMonitor.h"
#import "NcSwizzle.h"

NSString *ncUITableViewKey = @"ncUITableView";

@implementation UITableView (NcUITableViewMonitor)

+ (void)setup:(UITableViewCallback)callback
{
    objc_setAssociatedObject(ncUITableViewKey, NULL, callback, OBJC_ASSOCIATION_RETAIN);
    [NcSwizzle swizzle:objc_getClass("UITableView")
              original:@selector(setDelegate:)
                   new:@selector(ncSetDelegate:)];
}

- (void)ncSetDelegate:(id)delegate
{
    NcUITableViewDelegateProxy *newDelegate = [[NcUITableViewDelegateProxy alloc] initWithDelegate:delegate];
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

@implementation NcUITableViewDelegateProxy

- (void)makeCallback:(UITableView *)tableView operation:(NSString *)operation path:(NSIndexPath *)indexPath
{
    UITableViewCallback callback = objc_getAssociatedObject(ncUITableViewKey, NULL);
    if (nil != callback) {
        callback(tableView.accessibilityLabel,
                 [NSString stringWithFormat:@"%@ %@", operation, [indexPath stringFromPath]]);
    }
}

- (id)initWithDelegate:(id<UITableViewDelegate>)delegate
{
    self.realDelegate = delegate;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self.realDelegate respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self.realDelegate];
    }
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    if (nil == self.realDelegate) {
        return nil;
    }
    return [self.realDelegate methodSignatureForSelector:selector];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self makeCallback:tableView operation:@"SELECT" path:indexPath];
    if ([self.realDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.realDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self makeCallback:tableView operation:@"UNSELECT" path:indexPath];
    if ([self.realDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [self.realDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self makeCallback:tableView operation:@"EDIT_BEGIN" path:indexPath];
    if ([self.realDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [self.realDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self makeCallback:tableView operation:@"EDIT_END" path:indexPath];
    if ([self.realDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [self.realDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

// TODO - Do we need to handle other events?

@end

@implementation NSIndexPath(NcUITableViewMonitor)

- (NSString *)stringAtPosition:(NSUInteger)node
{
    return [NSString stringWithFormat:@"%lu", (unsigned long)[self indexAtPosition:node]];
}

- (NSString *)stringFromPath
{
    if (0 == self.length) {
        return @".";
    }
    NSString *path = [NSString stringWithFormat:@".%@", [self stringAtPosition:0]];
    for (NSUInteger node = 1; node < self.length; node++) {
        path = [path stringByAppendingPathExtension:[self stringAtPosition:node]];
    }
    return path;
}

@end