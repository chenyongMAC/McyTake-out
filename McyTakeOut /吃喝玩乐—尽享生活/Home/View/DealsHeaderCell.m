//
//  DealsHeaderCell.m
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/21.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "DealsHeaderCell.h"
#import "UIImageView+WebCache.h"

@implementation DealsHeaderCell

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
    
}


@end
