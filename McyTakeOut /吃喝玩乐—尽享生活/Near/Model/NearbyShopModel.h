//
//  NearbyShopModel.h
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseModel.h"
#import "DealsModel.h"

/*
 longitude
 distance
 deal_num
 deals
 latitude
 shop_murl
 shop_id
 shop_name
 shop_url
 */

@interface NearbyShopModel : BaseModel

@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *distance;
@property (nonatomic, copy) NSString *shop_name;
@property (nonatomic, retain) NSNumber *shop_id;
@property (nonatomic, retain) NSNumber *deal_num;
//@property (nonatomic, strong) NSArray *deals;
@property (nonatomic, copy) NSString *shop_murl;
@property (nonatomic, copy) NSString *shop_url;

@property (nonatomic, strong) NSMutableArray *dealsDataArray;

@end
