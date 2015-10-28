//
//  priceCell.h
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/21.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface priceCell : UITableViewCell


@property (nonatomic, strong) NSDictionary *dataDic;

@property (strong, nonatomic) IBOutlet UILabel *promotionPrice;
@property (strong, nonatomic) IBOutlet UILabel *currentPrice;
@property (strong, nonatomic) IBOutlet UILabel *marketPrice;
@property (strong, nonatomic) IBOutlet StarView *starView;
@property (strong, nonatomic) IBOutlet UILabel *ratingValue;

@end
