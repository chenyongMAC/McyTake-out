//
//  NearbyShopModel.m
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "NearbyShopModel.h"

@implementation NearbyShopModel

- (NSDictionary *)attributeMapDictionary {
    
    NSDictionary *mapAttr = @{
                              @"longitude": @"longitude",
                              @"distance" : @"distance",
                              @"deal_num" : @"deal_num",
//                              @"deals" : @"deals",
                              @"latitude" : @"latitude",
                              @"shop_murl": @"shop_murl",
                              @"shop_id" : @"shop_id",
                              @"shop_name" : @"shop_name",
                              @"shop_url" : @"shop_url"
                              };
    
    return mapAttr;
}

-(void) setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    
    _dealsDataArray = [[NSMutableArray alloc] init];
    NSArray *dealArray = [dataDic objectForKey:@"deals"];
    if (dealArray != nil) {
        for (NSDictionary *dic in dealArray) {
            DealsModel *model = [[DealsModel alloc] initWithDataDic:dic];
            [_dealsDataArray addObject:model];
        }
    }
    
}

@end
