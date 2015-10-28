//
//  HomeTableView.m
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HomeTableView.h"
#import "HomeViewCell.h"
#import "HomeHeadView.h"
#import "UIView+UIViewController.h"
#import "ShopViewController.h"

@implementation HomeTableView {
    
    HomeHeadView *_head;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{

    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.alpha = 0;
        
        _head = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeadView" owner:self options:nil] lastObject];
        self.tableHeaderView = _head;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeViewCell" owner:self options:nil] lastObject];
    }
    DealsModel *model = _dataArray[indexPath.row];
    cell.model = model;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return @"猜你喜欢";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 86;
}

#pragma mark - UITableView Delegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopViewController *shopVC = [[ShopViewController alloc] init];
    DealsModel *model = _dataArray[indexPath.row];
    shopVC.model = model;
    
    [self.viewController.navigationController pushViewController:shopVC animated:YES];
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
}


@end





