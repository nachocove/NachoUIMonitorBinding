//
//  NachoUIMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/6/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButton+NachoCoveMonitor.h"

@interface NachoUIMonitor : NSObject

+ (void)setupUIButton:(UIButtonCallback)callback;

@end
