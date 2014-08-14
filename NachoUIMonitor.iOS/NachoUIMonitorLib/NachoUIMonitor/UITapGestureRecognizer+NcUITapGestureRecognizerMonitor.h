//
//  UITapGestureRecognizer+NcUITapGestureRecognizerMonitor.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/13/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

// Conceptually, it would make more sense to pass in an array of coordinates.
// It is also more flexible than to limit it to 3 touches. However, in terms of
// implementation, it is a lot more complicated with very limit benefit.
//
// C# binding map a C# [] to an ObjC NSArray *. However, NSArray can only take on
// object and CGPoint is a C structure. So, we need to objectify CGPoint using
// NSValue. We also need to be careful about managing the life cycle of this
// NSArray object as well. That may become more tricky if these callbacks
// are asynchronous.
//
// Limiting to 3 touches is a bit ugly but it is robust and the chance of having
// more than 3 touches on a tap is low. (If that days does come, we can always
// add more touches in the callback.)
typedef void (^UITapGestureRecognizerCallback)(NSString *desc, unsigned int numTouches,
                                               CGPoint point1, CGPoint point2, CGPoint point3);

@interface UITapGestureRecognizer (NcUITapGestureRecognizerMonitor)

+ (void)setup:(UITapGestureRecognizerCallback)callback;

- (id)ncInitWithTarget:(id)target action:(SEL)action;

- (void)ncAddTarget:(id)target action:(SEL)action;

- (void)ncTapRecognized:(UIGestureRecognizer *)gestureRecognizer;

@end
