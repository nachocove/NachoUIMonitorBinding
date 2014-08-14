//
//  UITableView+NcUITableViewMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/13/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UITableViewCallback)(NSString *desc, NSString *operation);

@interface UITableView (NcUITableViewMonitor)

+ (void)setup:(UITableViewCallback)callback;

- (void)ncSetDelegate:(id)delegate;

@end

@interface NcUITableViewDelegateProxy : NSProxy<UITableViewDelegate>

@property(nonatomic, retain) id realDelegate;

- (void)makeCallback:(UITableView *)tableView operation:(NSString *)operation path:(NSIndexPath *)path;

- (id)initWithDelegate:(id<UITableViewDelegate>)delegate;

- (void)forwardInvocation:(NSInvocation *)invocation;

@end

@interface NSIndexPath (NcUITableViewMonitor)

- (NSString *)stringAtPosition:(NSUInteger)node;

- (NSString *)stringFromPath;

@end
