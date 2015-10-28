//
//  SideCollectionView.m
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CitiesCollectionView.h"
#import "UIView+UIViewController.h"

@implementation CitiesCollectionView


- (id)initWithFrame:(CGRect)frame {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //单元格大小
    layout.itemSize = CGSizeMake(80, 22);
    //水平最小间距
    layout.minimumInteritemSpacing = 5;
    //竖直最小间距
    layout.minimumLineSpacing = 5;
    
    layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        
        _hotCityArray = @[@"北京市",
                          @"上海市",
                          @"成都市",
                          @"杭州市",
                          @"郑州市",
                          @"武汉市",
                          @"天津市",
                          @"重庆市",
                          @"西安市"];
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return self;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 1;
    } else if (section == 1) {
    
        return 1;
    } else if (section == 2) {
    
        return 1;
    } else {
    
        return 9;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    
    if (indexPath.section == 0) { //已定位城市
        
        label.frame = CGRectMake(0, 0, kScreenWidth, 20);
        label.text = @"已定位城市";
        label.textAlignment = NSTextAlignmentLeft;
        
    } else if (indexPath.section == 1) { //杭州市
        
        label.text = @"杭州市";
        cell.backgroundColor = [UIColor whiteColor];
        
    } else if (indexPath.section == 2) { //热门城市
    
        label.frame = CGRectMake(0, 0, kScreenWidth, 20);
        label.text = @"热门城市";
        label.textAlignment = NSTextAlignmentLeft;
        
    } else { //热门城市列表
        
        cell.backgroundColor = [UIColor whiteColor];
        label.text = _hotCityArray[indexPath.item];
    }
    
    cell.layer.cornerRadius = 2;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        return;
    } else if (indexPath.section == 2 && indexPath.row == 0) {
    
        return;
    }
    else {
        
        [self.viewController.navigationController popViewControllerAnimated:YES];

    }
    
}



@end
