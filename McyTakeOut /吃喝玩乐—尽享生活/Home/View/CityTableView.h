//
//  CityTableView.h
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitiesModel.h"



@interface CityTableView : UITableView <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate> {
    
    UISearchBar *_searchBar;
}
- (void)filterContentForSearchText:(NSString *)searchText scope:(NSUInteger)scope;

@property(nonatomic,strong)NSArray *cityArray;
@property(nonatomic,strong)NSMutableArray *listFilterArray;

@property (nonatomic, strong) NSArray *selectedArray;
@property (nonatomic, strong) CitiesModel *model;

@end
