//
//  UIMonitorTesterViewController.h
//  UIMonitorTester
//
//  Created by Henry Kwok on 8/7/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMonitorTesterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrl1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrl2;

- (IBAction)button1Clicked:(id)sender;
- (IBAction)button2Clicked:(id)sender;
- (IBAction)segCtrl1Changed:(id)sender;
- (IBAction)segCtrl2Changed:(id)sender;

@end
