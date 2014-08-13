//
//  UIAlertView+NcUIAlertViewMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/12/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertViewCallback)(NSString *desc, NSInteger index);

@interface UIAlertView (NcUIAlertViewMonitor)

+ (void)setup:(UIAlertViewCallback)callback;

@end

@interface NcUIAlertViewDelegateProxy : NSObject <UIAlertViewDelegate>

@property(atomic, retain) id realDelegate;

- (id)initWithDelegate:(id)delegate;

@end
