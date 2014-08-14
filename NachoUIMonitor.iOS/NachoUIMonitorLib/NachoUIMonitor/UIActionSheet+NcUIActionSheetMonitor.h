//
//  UIActionSheet+NcUIActionSheetMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/12/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIActionSheetCallback)(NSString *desc, NSInteger index);

@interface UIActionSheet (NcUIActionSheetMonitor)

+ (void)setup:(UIActionSheetCallback)callback;

@end

@interface NcUIActionSheetDelegateProxy : NSObject <UIActionSheetDelegate>

@property(atomic, retain) id realDelegate;

- (id)initWithDelegate:(id)delegate;

@end
