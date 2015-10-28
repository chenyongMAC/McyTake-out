//
//  priceCell.m
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/21.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "priceCell.h"

@implementation priceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setDataDic:(NSDictionary *)dataDic {
    if (_dataDic != dataDic) {
        _dataDic = [dataDic copy];
        [self setNeedsLayout];
    }
}


-(void) layoutSubviews {
    [super layoutSubviews];
    
//    NSDictionary *pro = _dataDic[@"promotion_price"];
//    float promotion = [pro[@"600010000"] floatValue]/100.0;
//    _promotionPrice.text = [NSString stringWithFormat:@"￥%.2f", promotion];
    
 
    float current = [_dataDic[@"current_price"] floatValue]/100.0;
    _currentPrice.text = [NSString stringWithFormat:@"%.2f", current];
    

    float market = [_dataDic[@"market_price"] floatValue]/100.0;
    _marketPrice.text = [NSString stringWithFormat:@"%.2f", market];
    
    
    
}

@end
