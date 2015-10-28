//
//  HomeHeadView.h
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLCollectionWaterFallFlow.h"
#import "TLCollectionWaterFallCell.h"


@interface HomeHeadView : UIView <UIScrollViewDelegate> {

    __weak IBOutlet UIButton *newButton;
    __weak IBOutlet UIButton *_chButton;
    __weak IBOutlet UIButton *_toShopButton;
    __weak IBOutlet UIButton *_bathButton;
    __weak IBOutlet UIButton *_roomButton;
    __weak IBOutlet UIButton *_movieButton;
    __weak IBOutlet UIButton *_fallButton;
    __weak IBOutlet UIButton *_quanButton;
    
    
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;

//好店推荐
@property (weak, nonatomic) IBOutlet UIImageView *hotShop_oneImgView;
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotShopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *attributeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIImageView *midImgView;
@property (weak, nonatomic) IBOutlet UILabel *midHotLabel;
@property (weak, nonatomic) IBOutlet UILabel *midShopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *midSubLabel;
@property (weak, nonatomic) IBOutlet UILabel *midScoreLabel;

@property (weak, nonatomic) IBOutlet UIImageView *lastImgView;
@property (weak, nonatomic) IBOutlet UILabel *lastHotLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastSopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastSubLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastScoreLabel;

@property(nonatomic,strong)NSArray *listArray;
@property(nonatomic,strong)NSDictionary *special;

- (IBAction)newUserbtnAction:(UIButton *)sender;
- (IBAction)changeAction:(UIButton *)sender;
- (IBAction)toShopPayAction:(UIButton *)sender;
- (IBAction)bathAction:(UIButton *)sender;
- (IBAction)roomGameAction:(UIButton *)sender;
- (IBAction)movieAction:(UIButton *)sender;
- (IBAction)fallAction:(UIButton *)sender;
- (IBAction)quanToCardAction:(UIButton *)sender;

- (IBAction)moreGoodShop:(UIButton *)sender;

@end
