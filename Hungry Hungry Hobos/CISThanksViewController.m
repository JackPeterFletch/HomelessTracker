//
//  CISThanksViewController.m
//  Hungry Hungry Hobos
//
//  Created by Jack Fletcher on 4/25/13.
//  Copyright (c) 2013 Cisco. All rights reserved.
//

#import "CISThanksViewController.h"
#import "CISInformViewController.h"

@interface CISThanksViewController ()
@property (weak, nonatomic) IBOutlet UILabel *numberOfHomies;
@property (weak, nonatomic) IBOutlet UILabel *representativeName;

@end

@implementation CISThanksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Logging le value  %@", _nearbyHomeless);
    
    _numberOfHomies.text = [_nearbyHomeless stringValue];
    
    _representativeName.text = _representative;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)informButton:(id)sender {
    
    [self performSegueWithIdentifier:@"InformSegue" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"InformSegue"]){
        CISInformViewController *controller = (CISInformViewController *)segue.destinationViewController;
        controller.nearbyHomeless = _nearbyHomeless;
        controller.longitude = _longitude;
        controller.latitude = _latitude;
        controller.address = _address;
        controller.district = _district;
        controller.representative = _representative;
        controller.email = _email;
        controller.gender = _gender;
        controller.phoneNumber = _phoneNumber;
        controller.officeAddress = _officeAddress;
        controller.twitterHandle = _twitterHandle;
        
        NSLog(@"LOGGING HERE TOO!, %@", controller.twitterHandle);
        
    }
}

@end
