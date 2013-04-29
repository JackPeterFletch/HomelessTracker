//
//  CISMailerViewController.h
//  Hungry Hungry Hobos
//
//  Created by Jack Fletcher on 4/25/13.
//  Copyright (c) 2013 Cisco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CISMailerViewController : UIViewController <CLLocationManagerDelegate,NSURLConnectionDelegate>

@property(nonatomic) NSNumber *nearby;
@property(nonatomic) NSNumber *longitude;
@property(nonatomic) NSNumber *latitude;
@property(nonatomic) NSString *address;
@property(nonatomic) NSString *district;
@property(nonatomic) NSString *representative;
@property(nonatomic) NSString *email;
@property(nonatomic) NSString *gender;
@property(nonatomic) NSString *phoneNumber;
@property(nonatomic) NSString *officeAddress;
@property(nonatomic) NSString *twitterHandle;

@end
