//
//  UIButton+NachoCoveMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/5/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef void (^UIButtonCallback)(NSString *desc);

@interface UIButton (NcUIButtonMonitor)

+ (void)setup:(UIButtonCallback)callback;

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;

@end

@interface NachoCoveUIMonitor : NSObject

+ (void)setupUIButton:(UIButtonCallback)callback;

@end
