//
//  HomeHeadView.m
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HomeHeadView.h"

static CGFloat const kMargin = 10.f;
static NSString * const reuseIdentifier = @"TLCollectionWaterFallCell";
//瀑布流页数
static CGFloat const colNum = 2.0f;

@interface HomeHeadView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {

    UIPageControl *_pageC; //pageControl

//    NSArray *_listArray; //好店推荐的数组
//    NSDictionary *_special; //中间部分数据
    
    __weak IBOutlet UIImageView *_newImgView;
    __weak IBOutlet UILabel *_newTitleLabel;
    __weak IBOutlet UILabel *_newSubLabel;
    

    __weak IBOutlet UIImageView *_chImgeView;
    __weak IBOutlet UILabel *_chTitleLabel;
    __weak IBOutlet UILabel *_chSubLabel;
    
    __weak IBOutlet UIImageView *_toImgView;
    __weak IBOutlet UILabel *_toTitleLabel;
    __weak IBOutlet UILabel *_toSubLabel;
    
    __weak IBOutlet UIImageView *_bathImgView;
    __weak IBOutlet UILabel *_bathTitleLabel;
    __weak IBOutlet UILabel *_bathSubLabel;
    
    __weak IBOutlet UIImageView *_roomImgView;
    __weak IBOutlet UILabel *_roomTitleLabel;
    __weak IBOutlet UILabel *_roomSubLabel;
    
    __weak IBOutlet UIImageView *_movieImgView;
    __weak IBOutlet UILabel *_movieNameLabel;
    __weak IBOutlet UILabel *_movieSubLabel;
    
    __weak IBOutlet UIImageView *_fallImgView;
    __weak IBOutlet UILabel *_fallTitleLabel;
    __weak IBOutlet UILabel *_fallSubLabel;
    
    __weak IBOutlet UIImageView *_quanImgView;
    __weak IBOutlet UILabel *_quanTitleLabel;
    __weak IBOutlet UILabel *_quanSubLabel;
    

}

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TLCollectionWaterFallFlow *layout;

@end

@implementation HomeHeadView

- (void)awakeFromNib {
    
    newButton.layer.borderWidth = 0.5;
    newButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _chButton.layer.borderWidth = 0.5;
    _chButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _toShopButton.layer.borderWidth = 0.5;
    _toShopButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _bathButton.layer.borderWidth = 0.5;
    _bathButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _roomButton.layer.borderWidth = 0.5;
    _roomButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _movieButton.layer.borderWidth = 0.5;
    _movieButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _fallButton.layer.borderWidth = 0.5;
    _fallButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _quanButton.layer.borderWidth = 0.5;
    _quanButton.layer.borderColor = [UIColor lightGrayColor].CGColor;

    //创建顶部滑动视图
    [self _createScroollView];
    
    //加载好店推荐部分数据
//    [self _hotShopRequest];
    
    //中间部分数据加载
    [self midDataRequest];
    
}


#pragma mark - 创建顶部滑动视图
- (void)_createScroollView {

    _topScrollView.delegate = self;
    _topScrollView.contentSize = CGSizeMake(kScreenWidth * 4, 66);
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.pagingEnabled = YES;
    
    for (int i = 0; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"head0%i.jpg",i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * (i - 1), 0, self.bounds.size.width, 66)];
        imageView.image = image;
        
        [_topScrollView addSubview:imageView];
    }
    
    //创建pageControl
    [self _createPageControl];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(imageChange) userInfo:nil repeats:YES];
    
}

//创建pageControl
- (void)_createPageControl {

    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(100,66-30, kScreenWidth, 30)];
    _pageC.numberOfPages = 4;
    _pageC.currentPage = 0;
    _pageC.currentPageIndicatorTintColor = [UIColor blueColor];
    _pageC.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [_pageC addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_pageC];
    
}

- (void)pageControlAction:(UIPageControl *)pageCon {

    [_topScrollView setContentOffset:CGPointMake(kScreenWidth * pageCon.currentPage, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat xOffset = scrollView.contentOffset.x;
    NSInteger index = xOffset / kScreenWidth;
    
    _pageC.currentPage = index;
}

//定时器方法，不断改变图片
- (void)imageChange {

    static NSInteger j = 1;
    _pageC.currentPage = j;
    
    [_topScrollView setContentOffset:CGPointMake(j * kScreenWidth, 0) animated:YES];
    j++;
    if (j == 4) {
        j = 0;
    }
}

//加载好店推荐部分数据
- (void)_hotShopRequest {

    NSString *urlStr = @"http://180.97.34.118/naserver/search/merchantrec";
    NSString *httpArg = @"page_type=component&goods_per_page=3&s_name=index_shop_ranking_meirihaodian&locate_city_id=600010000&situationId=1&appid=android&tn=android&terminal_type=android&device=Xiaomi+2014812&channel=1006900a&v=5.13.2&os=SDK19&cityid=600010000&location=30.324091%2C120.350402&cuid=F0DF94CD7CC07BDF0FA191ACA26AAF4E%7C079304320240668&uuid=ffffffff-cd9e-be17-3c1d-5697050e83f7&timestamp=1445149957951&swidth=720&sheight=1280&net=wifi&sign=acfdd35ad85ae9c6f72e6a39214e4b0d";
    [MyNetWorkQuery requestData:urlStr HTTPMethod:@"GET" httpArg:httpArg completionHandle:^(id result) {
        
        NSDictionary *dataDic = [result objectForKey:@"data"];
        _listArray = [dataDic objectForKey:@"list"];
        
        //填充好店推荐数据
        [self _loadHotShopData];
        
    } errorHandle:^(NSError *error) {
        NSLog(@"好店推荐数据加载出错");
    }];
    
}

#pragma mark - 好店推荐部分数据填充
- (void)_loadHotShopData {

    //商店图片
    NSString *name = _listArray[0][@"tiny_image"];
    [_hotShop_oneImgView sd_setImageWithURL:[NSURL URLWithString:name]];
    
    //热词
    _hotLabel.text = _listArray[0][@"recom_reason"];
    //店名
    _hotShopNameLabel.text = _listArray[0][@"poiname"];
    //子标签
    _attributeLabel.text = [_listArray[0][@"sub_cat_list"] componentsJoinedByString:@","];
    //评分
    _scoreLabel.text = [NSString stringWithFormat:@"%@分",_listArray[0][@"poi_avg_score"]];
    
    //商店图片
    NSString *midURL = _listArray[1][@"tiny_image"];
    [_midImgView sd_setImageWithURL:[NSURL URLWithString:midURL]];
    //热词
    _midHotLabel.text = _listArray[1][@"recom_reason"];
    //店名
    _midShopNameLabel.text = _listArray[1][@"poiname"];
    //子标签
    _midSubLabel.text = [_listArray[1][@"sub_cat_list"] componentsJoinedByString:@","];
    //评分
    _midScoreLabel.text = [NSString stringWithFormat:@"%@分",_listArray[1][@"poi_avg_score"]];
    
    //商店图片
    NSString *lastURL = _listArray[2][@"tiny_image"];
    [_lastImgView sd_setImageWithURL:[NSURL URLWithString:lastURL]];
    //热词
    _lastHotLabel.text = _listArray[2][@"recom_reason"];
    //店名
    _lastSopNameLabel.text = _listArray[2][@"poiname"];
    //子标签
    _lastSubLabel.text = [_listArray[2][@"sub_cat_list"] componentsJoinedByString:@","];
    //评分
    _lastScoreLabel.text = [NSString stringWithFormat:@"%@分",_listArray[2][@"poi_avg_score"]];
    
}

//中间部分数据加载
- (void)midDataRequest {

    NSString *urlStr = @"http://app.nuomi.com/naserver/home/homepage";
    NSString *httpArg = @"page_type=component&appid=android&tn=android&terminal_type=android&device=Xiaomi+2014812&channel=1006900a&v=5.13.2&os=SDK19&cityid=600010000&location=30.32402%2C120.350529&cuid=F0DF94CD7CC07BDF0FA191ACA26AAF4E%7C079304320240668&uuid=ffffffff-cd9e-be17-3c1d-5697050e83f7&timestamp=1445150363930&swidth=720&sheight=1280&net=wifi&sign=c052d0c41b66217ec95c509f25683cc4";
    
    [MyNetWorkQuery requestData:urlStr HTTPMethod:@"GET" httpArg:httpArg completionHandle:^(id result) {
        
        NSDictionary *dataDic = [result objectForKey:@"data"];
        _special = [dataDic objectForKey:@"special"];
        
        //中间部分数据填充
        [self _midDataLoad];
        
    } errorHandle:^(NSError *error) {
        NSLog(@"好店推荐数据加载出错");
    }];
}

#pragma mark - 中间部分数据填充
- (void)_midDataLoad {

    NSDictionary *midSoecial_1 = _special[@"block_1"];
    
    NSString *urlStr_1 = midSoecial_1[@"picture_url"];
    [_newImgView sd_setImageWithURL:[NSURL URLWithString:urlStr_1]];
    _newTitleLabel.text = midSoecial_1[@"adv_title"];
    _newSubLabel.text = midSoecial_1[@"adv_subtitle"];
    
    
    NSArray *array_2 = _special[@"block_2"];
    
    NSString *urlStr_2 = array_2[0][@"picture_url"];
    [_chImgeView sd_setImageWithURL:[NSURL URLWithString:urlStr_2]];
    _chTitleLabel.text = array_2[0][@"adv_title"];
    _chSubLabel.text = array_2[0][@"adv_subtitle"];
    
    NSString *urlStr_3 = array_2[1][@"picture_url"];
    [_movieImgView sd_setImageWithURL:[NSURL URLWithString:urlStr_3]];
    _movieNameLabel.text = array_2[1][@"adv_title"];
    _movieSubLabel.text = array_2[1][@"adv_subtitle"];
    
    NSString *urlStr_4 = array_2[2][@"picture_url"];
    [_toImgView sd_setImageWithURL:[NSURL URLWithString:urlStr_4]];
    _toTitleLabel.text = array_2[2][@"adv_title"];
    _toSubLabel.text = array_2[2][@"adv_subtitle"];
    
    NSString *urlStr_5 = array_2[3][@"picture_url"];
    [_bathImgView sd_setImageWithURL:[NSURL URLWithString:urlStr_5]];
    _bathTitleLabel.text = array_2[3][@"adv_title"];
    _bathSubLabel.text = array_2[3][@"adv_subtitle"];
    
    NSString *urlStr_6 = array_2[4][@"picture_url"];
    [_roomImgView sd_setImageWithURL:[NSURL URLWithString:urlStr_6]];
    _roomTitleLabel.text = array_2[4][@"adv_title"];
    _roomSubLabel.text = array_2[4][@"adv_subtitle"];
    
    NSArray *array_3 = _special[@"block_3"];
    
    NSString *urlStr_7 = array_3[0][@"picture_url"];
    [_fallImgView sd_setImageWithURL:[NSURL URLWithString:urlStr_7]];
    _fallTitleLabel.text = array_3[0][@"adv_title"];
    _fallSubLabel.text = array_3[0][@"adv_subtitle"];
    
    NSString *urlStr_8 = array_3[1][@"picture_url"];
    [_quanImgView sd_setImageWithURL:[NSURL URLWithString:urlStr_8]];
    _quanTitleLabel.text = array_3[1][@"adv_title"];
    _quanSubLabel.text = array_3[1][@"adv_subtitle"];

}

- (IBAction)newUserbtnAction:(UIButton *)sender {
    
    NSLog(@"你点击了新用户专享");
}

- (IBAction)changeAction:(UIButton *)sender {
    NSLog(@"你点击了特权日");
}

- (IBAction)toShopPayAction:(UIButton *)sender {
    NSLog(@"你点击了到店付");
}

- (IBAction)bathAction:(UIButton *)sender {
    
    NSLog(@"你点击了温泉洗浴");
}

- (IBAction)roomGameAction:(UIButton *)sender {
    
    NSLog(@"你点击了密室逃脱");
}

- (IBAction)movieAction:(UIButton *)sender {
    
    NSLog(@"电影蚁人来战");
}

- (IBAction)fallAction:(UIButton *)sender {
    
    NSLog(@"你点击了秋季温补");
}

- (IBAction)quanToCardAction:(UIButton *)sender {
    
    NSLog(@"你点击了券换卡");
}

- (IBAction)moreGoodShop:(UIButton *)sender {
    
    NSLog(@"你点击了好店推荐");
}

@end
