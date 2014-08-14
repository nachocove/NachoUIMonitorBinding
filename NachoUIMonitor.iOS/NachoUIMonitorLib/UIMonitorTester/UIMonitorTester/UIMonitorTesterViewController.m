//
//  UIMonitorTesterViewController.m
//  UIMonitorTester
//
//  Created by Henry Kwok on 8/7/14.
//  Copyright (c) 2014 NachoCove. All rights reserved.
//

#import "UIMonitorTesterViewController.h"


typedef void (^UIAlertViewCallback)(NSString *desc, NSInteger index);

@interface UIAlertView (NcUIAlertViewMonitor)

+ (void)setup:(UIAlertViewCallback)callback;

@end

@interface UIMonitorTesterViewController ()

@property(nonatomic, retain) id delegateProxy;

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

#if 1
    self.tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [self.tapRecognizer addTarget:self action:@selector(tapsRecognized:)];
#else
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapsRecognized:)];
#endif
    self.tapRecognizer.accessibilityLabel = @"taprecognizer";
    // two 2-finger taps
    self.tapRecognizer.numberOfTapsRequired = 3;
    self.tapRecognizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:self.tapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1Clicked:(id)sender
{
    NSLog(@"button1 clicked");

    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Alert View"
                                                 message:@"Alert View Message"
                                                delegate:nil
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"Ok", nil];
    av.accessibilityLabel = @"alertview1";
    [av show];
}

- (IBAction)button2Clicked:(id)sender
{
    NSLog(@"button2 clicked");
    
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Action Sheet" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Apple", @"Orange", nil];
    as.accessibilityLabel = @"actionsheet1";
    [as showInView:self.view];
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

- (void)tapsRecognized:(UIGestureRecognizer *)gestutreRecognizer
{
    assert (nil != gestutreRecognizer);
    NSUInteger numTouches = [gestutreRecognizer numberOfTouches];
    NSLog(@"taprecognizer tapped (touches=%lu)", (unsigned long)numTouches);
    for (unsigned int n = 0; n < numTouches; n++) {
        CGPoint point = [gestutreRecognizer locationOfTouch:n inView:self.view];
        NSLog(@"   [%u] (%lf, %lf)", n, point.x, point.y);
    }
}
                          
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
