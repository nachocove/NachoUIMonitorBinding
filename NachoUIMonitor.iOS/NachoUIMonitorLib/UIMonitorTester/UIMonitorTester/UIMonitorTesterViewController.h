//
//  UIMonitorTesterViewController.h
//  UIMonitorTester
//
//  Created by Henry Kwok on 8/7/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMonitorTesterViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrl1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrl2;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker1;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl1;

@property (nonatomic, retain) UITapGestureRecognizer *tapRecognizer;

- (IBAction)button1Clicked:(id)sender;
- (IBAction)button2Clicked:(id)sender;
- (IBAction)segCtrl1Changed:(id)sender;
- (IBAction)segCtrl2Changed:(id)sender;
- (IBAction)switch1Changed:(id)sender;
- (IBAction)switch2Changed:(id)sender;
- (IBAction)datePicker1Changed:(id)sender;
- (IBAction)textField1Edited:(id)sender;
- (IBAction)pageCtrl1Changed:(id)sender;

@end
