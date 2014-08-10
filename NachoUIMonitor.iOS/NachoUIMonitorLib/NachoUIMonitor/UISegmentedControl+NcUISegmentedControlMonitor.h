//
//  UISegmentedControl+NcUISegmentedControlMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/8/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UISegmentedControlCallback)(NSString *desc, NSInteger index);

@interface UISegmentedControl(NcUISegmentedControlMonitor)

+ (void)setup:(UISegmentedControlCallback)callback;

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;

@end
