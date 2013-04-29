//
//  CISInformViewController.h
//  Hungry Hungry Hobos
//
//  Created by Jack Fletcher on 4/25/13.
//  Copyright (c) 2013 Cisco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface CISInformViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property(nonatomic) NSNumber *nearbyHomeless;
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
