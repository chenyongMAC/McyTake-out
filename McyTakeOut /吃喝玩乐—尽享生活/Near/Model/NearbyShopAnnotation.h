//
//  NearbyShopAnnotation.h
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "NearbyShopModel.h"

@interface NearbyShopAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) NearbyShopModel *model;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end
