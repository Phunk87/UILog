//
//  ViewController.m
//  UILogDemo
//
//  Created by 0day on 13-4-15.
//  Copyright (c) 2013年 0day. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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

- (IBAction)buttonAPressed:(id)sender {
    UILogPush(@"Button A Pressed");
}

- (IBAction)buttonBPressed:(id)sender {
    UILogPush(@"Button B Pressed");
}

- (IBAction)buttonCPressed:(id)sender {
    UILogPush(@"Button C Pressed");
}

- (IBAction)buttonDPressed:(id)sender {
    UILogPush(@"Button D Pressed");
}
@end
