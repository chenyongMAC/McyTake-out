//
//  NearbyShopAnnotation.m
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "NearbyShopAnnotation.h"

@implementation NearbyShopAnnotation

-(void) setModel:(NearbyShopModel *)model {
   
    _model = model;
//    NSDictionary *geo = weiboModel.geo;

//    NSArray *coordinates = [geo objectForKey:@"coordinates"];
//    if (coordinates.count >= 2) {
//        
//        NSString *longitude =    rcoordinates[0];
//        NSString *latitude = coordinates[1];
//        
//        _coordinate = CLLocationCoordinate2DMake([longitude floatValue], [latitude floatValue]);
//    }
    
    _coordinate = CLLocationCoordinate2DMake([model.longitude floatValue], [model.latitude floatValue]);
}


@end
