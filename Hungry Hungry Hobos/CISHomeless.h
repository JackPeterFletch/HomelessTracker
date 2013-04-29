//
//  CISHomeless.h
//  Hungry Hungry Hobos
//
//  Created by Jack Fletcher on 4/25/13.
//  Copyright (c) 2013 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CISHomeless : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString * title;
    NSString * subtitle;
}
@end
