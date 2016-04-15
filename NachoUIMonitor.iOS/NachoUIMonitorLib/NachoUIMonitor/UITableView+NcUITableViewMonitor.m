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

static NSMutableDictionary *SwizzledDelegateClasses = nil;

void NcUITableViewDelegate_swizzled_didSelectRowAtPath (id self, SEL _cmd, UITableView *tableView, NSIndexPath *indexPath);
void NcUITableViewDelegate_swizzled_didDeselectRowAtPath (id self, SEL _cmd, UITableView *tableView, NSIndexPath *indexPath);
void NcUITableViewDelegate_swizzled_willBeginEditingRowAtPath (id self, SEL _cmd, UITableView *tableView, NSIndexPath *indexPath);
void NcUITableViewDelegate_swizzled_didEndEditingRowAtPath (id self, SEL _cmd, UITableView *tableView, NSIndexPath *indexPath);

@interface SwizzleEntry : NSObject
{
    IMP _original_didSelectRowAtPath;
    IMP _original_didDeselectRowAtPath;
    IMP _original_willBeginEditingRowAtPath;
    IMP _original_didEndEditingRowAtPath;
    Class _cls;
}

- (void)swizzle:(Class)cls;
- (IMP)original_didSelectRowAtPath;
- (IMP)original_didDeselectRowAtPath;
- (IMP)original_willBeginEditingRowAtPath;
- (IMP)original_didEndEditingRowAtPath;
- (void)makeCallback:(UITableView *)tableView operation:(NSString *)operation path:(NSIndexPath *)indexPath;

@end

@implementation SwizzleEntry

- (void)swizzle:(Class)cls
{
    _cls = cls;
    Method *methods;
    Method method;
    unsigned int methodCount;
    
    methods = class_copyMethodList(cls, &methodCount);
    
    for (int i = 0; i < methodCount; ++i){
        method = methods[i];
        SEL name = method_getName(method);
        if (name == @selector(tableView:didSelectRowAtIndexPath:)){
            _original_didSelectRowAtPath = method_setImplementation(method, (IMP)NcUITableViewDelegate_swizzled_didSelectRowAtPath);
        }else if (name == @selector(tableView:didDeselectRowAtIndexPath:)){
            _original_didDeselectRowAtPath = method_setImplementation(method, (IMP)NcUITableViewDelegate_swizzled_didDeselectRowAtPath);
        }else if (name == @selector(tableView:willBeginEditingRowAtIndexPath:)){
            _original_willBeginEditingRowAtPath = method_setImplementation(method, (IMP)NcUITableViewDelegate_swizzled_willBeginEditingRowAtPath);
        }else if (name == @selector(tableView:didEndEditingRowAtIndexPath:)){
            _original_didEndEditingRowAtPath = method_setImplementation(method, (IMP)NcUITableViewDelegate_swizzled_didEndEditingRowAtPath);
        }
    }
    
    free (methods);
}

- (SwizzleEntry *)superEntry
{
    Class superClass = class_getSuperclass(_cls);
    if (superClass != NULL){
        NSString *superClassName = [NSString stringWithUTF8String:class_getName(superClass)];
        return [SwizzledDelegateClasses objectForKey:superClassName];
    }
    return nil;
}

- (IMP)original_didSelectRowAtPath
{
    if (_original_didSelectRowAtPath == NULL){
        SwizzleEntry *superEntry = [self superEntry];
        if (superEntry != nil){
            return [superEntry original_didSelectRowAtPath];
        }
        return NULL;
    }
    return _original_didSelectRowAtPath;
}

- (IMP)original_didDeselectRowAtPath
{
    if (_original_didDeselectRowAtPath == NULL){
        SwizzleEntry *superEntry = [self superEntry];
        if (superEntry != nil){
            return [superEntry original_didDeselectRowAtPath];
        }
        return NULL;
    }
    return _original_didDeselectRowAtPath;
}

- (IMP)original_willBeginEditingRowAtPath
{
    if (_original_willBeginEditingRowAtPath == NULL){
        SwizzleEntry *superEntry = [self superEntry];
        if (superEntry != nil){
            return [superEntry original_willBeginEditingRowAtPath];
        }
        return NULL;
    }
    return _original_willBeginEditingRowAtPath;
}

- (IMP)original_didEndEditingRowAtPath
{
    if (_original_didEndEditingRowAtPath == NULL){
        SwizzleEntry *superEntry = [self superEntry];
        if (superEntry != nil){
            return [superEntry original_didEndEditingRowAtPath];
        }
        return NULL;
    }
    return _original_didEndEditingRowAtPath;
}

- (void)makeCallback:(UITableView *)tableView operation:(NSString *)operation path:(NSIndexPath *)indexPath
{
    UITableViewCallback callback = objc_getAssociatedObject(ncUITableViewKey, NULL);
    if (nil != callback) {
        callback(tableView.accessibilityLabel,
                 [NSString stringWithFormat:@"%@ %@", operation, [indexPath stringFromPath]]);
    }
}

@end

void NcUITableViewDelegate_swizzled_didSelectRowAtPath (id self, SEL _cmd, UITableView *tableView, NSIndexPath *indexPath)
{
    Class delegateClass = object_getClass(self);
    NSString *delegateClassName = [NSString stringWithUTF8String:class_getName(delegateClass)];
    SwizzleEntry *entry = (SwizzleEntry *)[SwizzledDelegateClasses objectForKey:delegateClassName];
    [entry makeCallback:tableView operation:@"SELECT" path:indexPath];
    IMP original = [entry original_didSelectRowAtPath];
    ((void (*)(id, SEL, UITableView *, NSIndexPath *))original)(self, _cmd, tableView, indexPath);
}

void NcUITableViewDelegate_swizzled_didDeselectRowAtPath (id self, SEL _cmd, UITableView *tableView, NSIndexPath *indexPath)
{
    Class delegateClass = object_getClass(self);
    NSString *delegateClassName = [NSString stringWithUTF8String:class_getName(delegateClass)];
    SwizzleEntry *entry = (SwizzleEntry *)[SwizzledDelegateClasses objectForKey:delegateClassName];
    [entry makeCallback:tableView operation:@"UNSELECT" path:indexPath];
    IMP original = [entry original_didDeselectRowAtPath];
    ((void (*)(id, SEL, UITableView *, NSIndexPath *))original)(self, _cmd, tableView, indexPath);
}

void NcUITableViewDelegate_swizzled_willBeginEditingRowAtPath (id self, SEL _cmd, UITableView *tableView, NSIndexPath *indexPath)
{
    Class delegateClass = object_getClass(self);
    NSString *delegateClassName = [NSString stringWithUTF8String:class_getName(delegateClass)];
    SwizzleEntry *entry = (SwizzleEntry *)[SwizzledDelegateClasses objectForKey:delegateClassName];
    [entry makeCallback:tableView operation:@"EDIT_BEGIN" path:indexPath];
    IMP original = [entry original_willBeginEditingRowAtPath];
    ((void (*)(id, SEL, UITableView *, NSIndexPath *))original)(self, _cmd, tableView, indexPath);
}

void NcUITableViewDelegate_swizzled_didEndEditingRowAtPath (id self, SEL _cmd, UITableView *tableView, NSIndexPath *indexPath)
{
    Class delegateClass = object_getClass(self);
    NSString *delegateClassName = [NSString stringWithUTF8String:class_getName(delegateClass)];
    SwizzleEntry *entry = (SwizzleEntry *)[SwizzledDelegateClasses objectForKey:delegateClassName];
    [entry makeCallback:tableView operation:@"EDIT_END" path:indexPath];
    IMP original = [entry original_didEndEditingRowAtPath];
    ((void (*)(id, SEL, UITableView *, NSIndexPath *))original)(self, _cmd, tableView, indexPath);
}

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
    if (delegate != nil){
        if (SwizzledDelegateClasses == nil){
            SwizzledDelegateClasses = [[NSMutableDictionary alloc] init];
        }
        Class cls = object_getClass(delegate);
        while (cls != NULL){
            NSString *delegateClassName = [NSString stringWithUTF8String:class_getName(cls)];
            id entry = [SwizzledDelegateClasses objectForKey:delegateClassName];
            if (entry == nil){
                entry = [[SwizzleEntry alloc] init];
                [entry swizzle:cls];
                [SwizzledDelegateClasses setObject:entry forKey:delegateClassName];
            }
            cls = class_getSuperclass(cls);
        }
        [self ncSetDelegate:delegate];
    }
}

- (void)dealloc
{
    if (nil != self.delegate) {
        objc_removeAssociatedObjects(self);
        [self ncSetDelegate:nil];
    }
}

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