//
//  NearByViewController.h
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/22.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "Commen.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NearByViewController : BaseViewController <MKMapViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate> {
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}

@end
