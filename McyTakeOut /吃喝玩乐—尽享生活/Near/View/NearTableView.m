//
//  NearTableView.m
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NearTableView.h"
#import "NearByViewCell.h"
#import "DealsModel.h"
#import "NearByHeaderCell.h"
#import "NearbyShopModel.h"
#import "ShopDetailViewController.h"
#import "DealsDetailViewController.h"
#import "UIView+UIViewController.h"

@implementation NearTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{

    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
//        [self _createViews];
        
        UINib *nib1 = [UINib nibWithNibName:@"NearByViewCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib1 forCellReuseIdentifier:@"nearCell"];
        
        UINib *nib2 = [UINib nibWithNibName:@"NearByHeaderCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib2 forCellReuseIdentifier:@"NearByHeaderCell"];
        
    }
    return self;
}

- (void)_createViews {

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 100)];
    headView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    
    UILabel *locLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    locLabel.text = @"位置";
    locLabel.font = [UIFont systemFontOfSize:10.0f];
    [headView addSubview:locLabel];
    
    UIButton *refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 20, 3, 14, 14)];
    [refreshBtn setImage:[UIImage imageNamed:@"icon_location_reload.png"] forState:UIControlStateNormal];
    [headView addSubview:refreshBtn];
    
    UILabel *shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 20)];
    shopLabel.text = @"商场商圈";
    [headView addSubview:shopLabel];
    shopLabel.backgroundColor = [UIColor whiteColor];
    shopLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    shopLabel.font = [UIFont systemFontOfSize:14.0f];
    shopLabel.layer.borderWidth = 1;

    _shopView = [[ShopCollectionView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 150)];
    [headView addSubview:_shopView];
    self.tableHeaderView = headView;
    
}


#pragma mark - UITableView Delegate DataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%lu", (unsigned long)_dataArray.count);
    
        return _shopsArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dic = _shopsArray[section];
    
    return [dic[@"deal_num"] integerValue] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0) {
        NearByHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearByHeaderCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[NearByHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NearByHeaderCell"];
        }
        
        UILabel *shop_name = (UILabel *)[cell.contentView viewWithTag:101];
        shop_name.text = _shopsArray[indexPath.section][@"shop_name"];

        UILabel *distance = (UILabel *)[cell.contentView viewWithTag:102];
        distance.text = [NSString stringWithFormat:@"距离：%ldm", [_shopsArray[indexPath.section][@"distance"] integerValue]];
        
        return cell;
    } else {
        NSInteger index = 0;
        if (indexPath.section > 0) {
            for (int i=0; i<=indexPath.section-1; i++) {
                NSDictionary *dic = _shopsArray[i];
                NSInteger num = [dic[@"deal_num"] integerValue];
                index += num;
            }
        }
        
        
//        NSInteger num = [dic[@"deal_num"] integerValue];
        
        NearByViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearCell" forIndexPath:indexPath];
        
        DealsModel *model = _dealsArray[index + (indexPath.row - 1)];
        
        cell.model = model;
        
        
        return cell;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 30;
    } else {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        ShopDetailViewController *shopDetailVC = [[ShopDetailViewController alloc] init];
        
        NSDictionary *shops = _shopsArray[indexPath.section];
        shopDetailVC.shopURL = shops[@"shop_murl"];
        
        [self.viewController.navigationController pushViewController:shopDetailVC animated:YES];
        
        
    } else {
        
        NSInteger index = 0;
        if (indexPath.section > 0) {
            
            for (int i = 0; i <= indexPath.section-1; i++) {
                
                NSDictionary *dic = _shopsArray[i];
                NSInteger num = [dic[@"deal_num"] integerValue];
                
                index += num;
            }
        }
        
        DealsDetailViewController *dealsDetailVC = [[DealsDetailViewController alloc] init];
        DealsModel *model = _dealsArray[index + (indexPath.row - 1)];
        dealsDetailVC.model = model;
        [self.viewController.navigationController pushViewController:dealsDetailVC animated:YES];
    }
    
    
}

@end
