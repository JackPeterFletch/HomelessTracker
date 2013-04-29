//
//  CISMailerViewController.m
//  Hungry Hungry Hobos
//
//  Created by Jack Fletcher on 4/25/13.
//  Copyright (c) 2013 Cisco. All rights reserved.
//

#import "CISMailerViewController.h"
#import "CISThanksViewController.h"

@interface CISMailerViewController ()
  @property (weak, nonatomic) IBOutlet UILabel *longditudeLabel;
  @property (weak, nonatomic) IBOutlet UILabel *LattitudeLabel;
  @property (strong, nonatomic) CLLocationManager *locationManager;
  @property (strong, nonatomic) CLLocation *currentLocation;
@property (weak, nonatomic) IBOutlet UIButton *SpotterButton;
  @property (strong, nonatomic) NSMutableData *responseData;
@end

@implementation CISMailerViewController

@synthesize locationManager, currentLocation;

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
	// Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.currentLocation = newLocation;
    
    //if(newLocation.horizontalAccuracy <= 100.0f) { [locationManager stopUpdatingLocation]; }
    
    _longditudeLabel.text = [[NSString alloc] initWithFormat:@"%f", currentLocation.coordinate.latitude];
                             
    _LattitudeLabel.text = [[NSString alloc] initWithFormat:@"%f", currentLocation.coordinate.longitude];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}
- (IBAction)spotHomelessButton:(id)sender {
    
    NSMutableString *lat = [[NSMutableString alloc] initWithFormat:@"%f", currentLocation.coordinate.latitude];
    [lat setString: [lat stringByReplacingOccurrencesOfString:@"." withString:@"P"]];
    
    NSMutableString *lon = [[NSMutableString alloc] initWithFormat:@"%f", currentLocation.coordinate.longitude];
    [lon setString: [lon stringByReplacingOccurrencesOfString:@"." withString:@"P"]];
    
    NSMutableString *noOf = [[NSMutableString alloc] initWithFormat:@"%@",
                             @"1"];
    [noOf setString: [noOf stringByReplacingOccurrencesOfString:@"." withString:@"P"]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://171.71.119.10:3000/homeless/%@/%@/%@", lat,lon,noOf]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [urlRequest setHTTPMethod:@"POST"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    [_SpotterButton setEnabled:(NO)];
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"response data - %@", [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding]);
    
    [_SpotterButton setEnabled:(YES)];
    
    NSError *error;
    NSDictionary *jsonResultSet = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    
    //NSDictionary *homie = [jsonResultSet objectForKey:(@"homelesses")];
        
    NSNumber *ID = [jsonResultSet objectForKey:@"id"];
    _latitude = [jsonResultSet objectForKey:@"latitude"];
    _longitude = [jsonResultSet objectForKey:@"longitude"];
    _address = [jsonResultSet objectForKey:@"address"];
    _district = [jsonResultSet objectForKey:@"district"];
    _representative = [jsonResultSet objectForKey:@"representative"];
    _nearby = [jsonResultSet objectForKey:@"nearby"];
    _email = [jsonResultSet objectForKey:@"email"];
    _gender = [jsonResultSet objectForKey:@"gender"];
    _phoneNumber = [jsonResultSet objectForKey:@"phone"];
    _officeAddress = [jsonResultSet objectForKey:@"office"];
    _twitterHandle = [jsonResultSet objectForKey:@"twitter"];
        
    NSLog([ID stringValue]);
    NSLog([_latitude stringValue]);
    NSLog([_longitude stringValue]);
    NSLog([_nearby stringValue]);
    NSLog(_address);
    NSLog(_district);
    NSLog(_representative);
    NSLog(_email);
    NSLog(_officeAddress);
    NSLog(_gender);
    NSLog(_phoneNumber);
    NSLog(_twitterHandle);
    
    NSLog(@"LOGGING HERE, %@", _nearby);
    NSLog(@"AND HERE, %@", _address);
    
    [self performSegueWithIdentifier:@"spottedHomeless" sender:self];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"spottedHomeless"]){
        CISThanksViewController *controller = (CISThanksViewController *)segue.destinationViewController;
        controller.nearbyHomeless = _nearby;
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
