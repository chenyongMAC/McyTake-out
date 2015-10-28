//
//  StarView.m
//  StarDemo
//
//  Created by 朱家聪 on 15/8/22.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "StarView.h"
#import "UIViewExt.h"

@interface StarView ()
{
    UIView *_yellowView;    // 黄色星星视图
    UIView *_grayView;      // 灰色星星视图
}
@end

@implementation StarView

// 重写init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _createStarViews];
    }
    
    return self;
}

// 从xib 或者 故事版中创建视图时 调用的方法
- (void)awakeFromNib
{
    [self _createStarViews];
}

// 创建两种星星视图
- (void)_createStarViews
{
    // 读取两个图片
    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
    UIImage *grayImage = [UIImage imageNamed:@"gray"];
    
    // 灰色
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17.5 * 5, 17)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    // 放大灰色星星视图
    CGAffineTransform transform = CGAffineTransformMakeScale(self.frame.size.width / 17.5 / 5, self.frame.size.height / 17);
    _grayView.transform = transform;
    [self addSubview:_grayView];
    
    // 黄色
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17.5 * 5, 17)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    // 放大灰色星星视图
    _yellowView.transform = transform;
    [self addSubview:_yellowView];
    
    
    // 放大变换之后，视图的位置会发生变化 所以需要重新设置视图的中心点
    CGPoint selfCenterPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _yellowView.center = selfCenterPoint;
    _grayView.center = selfCenterPoint;
    
    
    
}


// 重写 评分的SET方法 在设置评分时改变黄色五角星的数量
- (void)setRating:(CGFloat)rating
{
    if (rating >= 0 && rating <= 5)
    {
        _rating = rating;
        _yellowView.width = _grayView.width * rating / 5;
    }
}

@end
