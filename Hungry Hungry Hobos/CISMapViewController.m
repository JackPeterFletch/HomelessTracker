//
//  CISMapViewController.m
//  Hungry Hungry Hobos
//
//  Created by Jack Fletcher on 4/25/13.
//  Copyright (c) 2013 Cisco. All rights reserved.
//

#import "CISMapViewController.h"
#import "CISHomeless.h"
#import "HeatMap.h"
#import "HeatMapView.h"
#import <MapKit/MapKit.h>

@interface CISMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *theMap;

@end

@implementation CISMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [_theMap removeOverlays:_theMap.overlays];
    
    NSMutableArray * annotationsToRemove = [ _theMap.annotations mutableCopy ];
    [ annotationsToRemove removeObject:_theMap.userLocation ];
    [ _theMap removeAnnotations:annotationsToRemove ];
}

-(void)viewWillAppear:(BOOL)animated
{
    mapView.delegate = self;
    
    _theMap.showsUserLocation = true;
    _theMap.userTrackingMode = MKUserTrackingModeFollow;
	// Do any additional setup after loading the view.
    
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://171.71.119.10:3000/homelesses.json"]];
    //NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    NSString *urlString= [NSString stringWithFormat:@"http://171.71.119.10:3000/homelesses.json"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSDictionary *jsonResultSet = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    
    
    NSMutableDictionary *toRet = [[NSMutableDictionary alloc] init];
    
    NSDictionary *homelessDictionary = [jsonResultSet objectForKey:(@"homelesses")];
    for (NSDictionary *homie in homelessDictionary){
        
        NSNumber *ID = [homie objectForKey:@"id"];
        NSNumber *latitude = [homie objectForKey:@"latitude"];
        NSNumber *longitude = [homie objectForKey:@"longitude"];
        NSString *address = [homie objectForKey:@"address"];
        NSString *district = [homie objectForKey:@"district"];
        NSString *representiative = [homie objectForKey:@"representative"];
        NSString *email = [homie objectForKey:@"email"];
        
        NSLog([ID stringValue]);
        NSLog([latitude stringValue]);
        NSLog([longitude stringValue]);
        NSLog(address);
        NSLog(district);
        NSLog(representiative);
        NSLog(email);
        
        NSLog(@"TeSST");
        
        CLLocationDegrees CLlongitude = (CLLocationDegrees)[longitude doubleValue];
        CLLocationDegrees CLlatitude = (CLLocationDegrees)[latitude doubleValue];
        
        CLLocation *coordinate = [[CLLocation alloc] initWithLatitude:CLlatitude longitude:CLlongitude];
        
        //CISHomeless *homelessPin = [[CISHomeless alloc] initWithCoordinate:coordinate andTitle:@"Lol" andSubtitle:@"Homeless Dude"];
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate.coordinate;
        
        MKMapPoint heatPoint = MKMapPointForCoordinate(coordinate.coordinate);
        NSValue *heatPointValue = [NSValue value:&heatPoint withObjCType:@encode(MKMapPoint)];
        [toRet setObject:[NSNumber numberWithInt:1] forKey:heatPointValue];
        
        
        //[_theMap addAnnotation:point];
    }
    
    HeatMap *hm = [[HeatMap alloc] initWithData:toRet];
    [_theMap addOverlay:hm];
    [_theMap setVisibleMapRect:[hm boundingMapRect] animated:YES];}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    return [[HeatMapView alloc] initWithOverlay:overlay];
}

@end
