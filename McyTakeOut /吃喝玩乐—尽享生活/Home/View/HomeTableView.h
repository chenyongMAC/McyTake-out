//
//  HomeTableView.h
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)NSDictionary *hotShopDic;

//头视图数据
@property(nonatomic,strong)NSArray *listArray;
@property(nonatomic,strong)NSDictionary *special;

@end
