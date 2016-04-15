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

@interface NSIndexPath (NcUITableViewMonitor)

- (NSString *)stringAtPosition:(NSUInteger)node;

- (NSString *)stringFromPath;

@end
