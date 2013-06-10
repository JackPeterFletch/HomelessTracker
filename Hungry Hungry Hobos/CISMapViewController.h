//
//  CISMapViewController.h
//  Hungry Hungry Hobos
//
//  Created by Jack Fletcher on 4/25/13.
//  Copyright (c) 2013 Cisco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CISMapViewController : UIViewController<MKMapViewDelegate>{
    NSMutableData *responseData;
    __weak IBOutlet MKMapView *mapView;
}
@end
