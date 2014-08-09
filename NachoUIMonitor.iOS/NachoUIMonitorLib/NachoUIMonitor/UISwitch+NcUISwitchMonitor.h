//
//  UISwitch+NcUISwitchMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/9/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UISwitchCallback)(NSString *desc, NSString *onOff);

@interface UISwitch (NcUISwitchMonitor)

+ (void)setup:(UISwitchCallback)callback;

- (void)ncSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;

@end
