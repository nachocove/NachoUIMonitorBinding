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
	// Do any additional setup after loading the view, typically from a nib.
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

@end
