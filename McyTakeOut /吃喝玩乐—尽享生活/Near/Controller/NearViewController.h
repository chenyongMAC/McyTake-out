//
//  NearViewController.h
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JKPopMenuView.h"
#import <CoreLocation/CoreLocation.h>

@interface NearViewController : BaseViewController <JKPopMenuViewSelectDelegate, CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
}

@end
