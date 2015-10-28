//
//  ShopAnnotationView.m
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ShopAnnotationView.h"
#import "NearbyShopAnnotation.h"
#import "UIImageView+WebCache.h"

@implementation ShopAnnotationView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, 100, 40);
        
        [self _createViews];
        
    }
    return  self;
    
}
//创建子视图
- (void)_createViews{
    
    _userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userHeadImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_userHeadImageView];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _textLabel.backgroundColor = [UIColor lightGrayColor];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.numberOfLines = 3;
    [self addSubview:_textLabel];
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    _userHeadImageView.frame = CGRectMake(0, 0, 40, 40);
    _textLabel.frame = CGRectMake(40, 0, 100, 40);
    
    
    //通过annotation得到 微博model，显示数据
    NearbyShopAnnotation *annotation = self.annotation;

    _textLabel.text = annotation.model.shop_name;
    NSString *urlStr = annotation.model.shop_url;
    [_userHeadImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
//    _textLabel.text = @"hello world";
    
    
}

@end
