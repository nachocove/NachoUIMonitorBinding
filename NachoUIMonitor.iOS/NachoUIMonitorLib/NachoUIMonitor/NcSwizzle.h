//
//  NcSwizzle.h
//  NachoUIMonitor
//
//  Created by Henry Kwok on 8/8/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NcSwizzle : NSObject

+ (void)swizzle:(Class)cls original:(SEL)origSelector new:(SEL)newSelector;

@end
