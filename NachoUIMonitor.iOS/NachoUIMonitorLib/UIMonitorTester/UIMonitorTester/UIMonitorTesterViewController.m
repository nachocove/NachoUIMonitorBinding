//
//  UIMonitorTesterViewController.m
//  UIMonitorTester
//
//  Created by Henry Kwok on 8/7/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import "UIMonitorTesterViewController.h"

@interface UIMonitorTesterViewController ()

@end

@implementation UIMonitorTesterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.segCtrl1.accessibilityLabel = @"segctrl1";
    self.segCtrl2.accessibilityLabel = @"segctrl2";
    self.datePicker1.accessibilityLabel = @"datepicker1";
    self.pageCtrl1.accessibilityLabel = @"pagectrl1";
    self.textField1.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1Clicked:(id)sender
{
    NSLog(@"button1 clicked");
}

- (IBAction)button2Clicked:(id)sender
{
    NSLog(@"button2 clicked");
}

- (IBAction)segCtrl1Changed:(id)sender
{
    NSLog(@"segCtrl1 changed");
}

- (IBAction)segCtrl2Changed:(id)sender
{
    NSLog(@"segCtrl2 changed");
}

- (IBAction)switch1Changed:(id)sender
{
    NSLog(@"switch1 changed");
}

- (IBAction)switch2Changed:(id)sender
{
    NSLog(@"switch2 changed");
}

- (IBAction)datePicker1Changed:(id)sender
{
    NSLog(@"datePicker1 changed");
}

- (IBAction)textField1Edited:(id)sender
{
    NSLog(@"textField1 edited");
}

- (IBAction)pageCtrl1Changed:(id)sender
{
    self.label1.text = [NSString stringWithFormat:@"Page %d", [sender currentPage]+1];
    NSLog(@"pageCtrl1 changed");
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
