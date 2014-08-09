//
//  UIPageControl+NcUIPageControlMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/9/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIPageControlCallback)(NSString *desc, NSInteger page);

@interface UIPageControl (NcUIPageControlMonitor)

+ (void)setup:(UIPageControlCallback)callback;

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;

@end
