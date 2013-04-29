//
//  CISViewController.m
//  Hungry Hungry Hobos
//
//  Created by Jack Fletcher on 4/25/13.
//  Copyright (c) 2013 Cisco. All rights reserved.
//

#import "CISViewController.h"

@interface CISViewController ()

@end

@implementation CISViewController

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

- (IBAction)Login:(UIButton *)sender {
    //Request Hobo list from Rails
    
    [self performSegueWithIdentifier:@"toTabbed" sender:self];
    
}
@end
