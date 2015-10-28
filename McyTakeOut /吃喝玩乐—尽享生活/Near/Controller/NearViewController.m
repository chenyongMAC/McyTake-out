//
//  NearViewController.m
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NearViewController.h"
#import "NearByViewController.h"
#import "MultilevelMenu.h"
#import "NearTableView.h"
#import "ShopCollectionView.h"
#import "AFNetworking.h"
#import "MyNetWorkQuery.h"
#import "Commen.h"
#import "DealsModel.h"
#import "ShopMall.h"
#import "NearbyShopModel.h"

@interface NearViewController () {
    
    NearTableView *_tableView;
    ShopCollectionView *_shopView;
    
    //分类菜单 数据数组
    NSMutableArray *_lis;
    //分类菜单视图
    MultilevelMenu *_menuView;
    BOOL isMenuView;
    
    
    //定位信息
    UILabel *_locationLabel;
    
    //当前经纬度
    NSString *_lonLat;
    
    NSArray *_shopsArray;
}

@end

@implementation NearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏按钮
    [self rightNavBarButton];
    [self leftNavBarButton];
    
    //创建视图
    [self _createViews];
    
    //加载分类菜单视图：注意菜单视图一定要放在主视图后面加载，确保点击分类按钮后可以看到分类菜单
    [self _createMenuView];
    
    //加载数据
    [self refreshBtnAction];
    
    //加载头部商圈数据
    [self _loadHeadShopMallData];
}


#pragma mark - 设置导航栏左边按钮
-(void) leftNavBarButton {
    //分类按钮
    UIButton *leftBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    [leftBtn1 setImage:[UIImage imageNamed:@"icon_nav_ditu_normal.png"] forState:UIControlStateNormal];
    [leftBtn1 addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left1 = [[UIBarButtonItem alloc] initWithCustomView:leftBtn1];
    
    self.navigationItem.leftBarButtonItems = @[left1];
}

//设置导航栏右边按钮
- (void)rightNavBarButton {
    
    //购物车
    UIButton *rightBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    [rightBtn1 setImage:[UIImage imageNamed:@"icon_nav_cart_normal.png"] forState:UIControlStateNormal];
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn1];
    
    
    //分类按钮
    UIButton *rightBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    [rightBtn2 setImage:[UIImage imageNamed:@"icon_nav_sousuo_normal.png"] forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(classifyAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn2];
    
    self.navigationItem.rightBarButtonItems = @[right2,right1];
}

-(void) classifyAction {
    NSLog(@"点击了分类按钮");
    
//    NSArray *catID_Array = @[@"326", @"326", @"326", @"326", @"326", @"326"];
    NSArray *classify_image = @[@"马里奥", @"皮卡丘", @"小毛驴", @"长颈鹿", @"愤怒的小鸟", @"拳皇"];
    NSArray *classify_name = @[@"附近商圈", @"皮卡丘", @"小毛驴", @"长颈鹿", @"愤怒的小鸟", @"拳皇"];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i < 7; i++) {
        JKPopMenuItem *item = [JKPopMenuItem itemWithTitle:classify_name[i-1] image:[UIImage imageNamed:classify_image[i-1]]];
        [array addObject:item];
    }
    
    JKPopMenuView *jkpop = [JKPopMenuView menuViewWithItems:array];
    jkpop.delegate = self;
    [jkpop show];
}

-(void) menuAction {
    if (!isMenuView) {
        [UIView animateWithDuration:0.3 animations:^{
            _menuView.bottom = kScreenHeight;
        }];
        
        isMenuView = YES;
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _menuView.bottom = 64;
        }];

        isMenuView = NO;
    }
}

#pragma mark - 创建主视图
- (void)_createViews {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 30)];
    view.backgroundColor = [UIColor purpleColor];

    [self.view addSubview:view];
    
    _tableView = [[NearTableView alloc] initWithFrame:CGRectMake(0, 94, kScreenWidth, kScreenHeight-40) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    //创建TableView的头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 195)];
    headView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 20)];
    _locationLabel.text = @"位置";
    _locationLabel.font = [UIFont systemFontOfSize:10.0f];
    [headView addSubview:_locationLabel];
    
    UIButton *refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 20, 3, 14, 14)];
    [refreshBtn setImage:[UIImage imageNamed:@"icon_location_reload.png"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:refreshBtn];
    
    UILabel *shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, kScreenWidth, 20)];
    shopLabel.text = @"商场商圈";
    [headView addSubview:shopLabel];
    shopLabel.backgroundColor = [UIColor whiteColor];
    shopLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    shopLabel.font = [UIFont systemFontOfSize:14.0f];
    shopLabel.layer.borderWidth = 1;
    
    _shopView = [[ShopCollectionView alloc] initWithFrame:CGRectMake(5, 40, kScreenWidth - 10, 145)];
    [headView addSubview:_shopView];
    _tableView.tableHeaderView = headView;
    
}

//加载数据
- (void)_loadData:(NSString *)lonlat {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"600010000" forKey:@"city_id"];
    [params setObject:lonlat forKey:@"location"];
    [params setObject:@"1000" forKey:@"radius"];
    
    [MyNetWorkQuery AFRequestData:Searchshops HTTPMethod:@"GET" params:params completionHandle:^(id result) {
        
        NSDictionary *dataDic = [result objectForKey:@"data"];
        _shopsArray = [dataDic objectForKey:@"shops"];
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in _shopsArray) {
            
            NSArray *deal = [dic objectForKey:@"deals"];
            for (NSDictionary *dealDic in deal) {
                DealsModel *model = [[DealsModel alloc] initWithDataDic:dealDic];
                [dataArray addObject:model];
            }
        }
        
        _tableView.shopsArray = _shopsArray;
        _tableView.dealsArray = dataArray;
//        NSLog(@"%@",dataArray);
        [_tableView reloadData];
        
    } errorHandle:^(NSError *error) {
        NSLog(@"获取附近推荐出错");
    }];
    
}

//加载头部商圈数据
- (void)_loadHeadShopMallData {
    
    //加载头部商圈数据
    NSString *urlString = @"http://180.97.34.118/naserver/search/shopmall";
    NSString *httpArg = @"locate_city_id=600010000&appid=android&tn=android&terminal_type=android&device=Xiaomi+2014812&channel=1006900a&v=5.13.2&os=SDK19&cityid=600010000&location=30.324115%2C120.350545&cuid=F0DF94CD7CC07BDF0FA191ACA26AAF4E%7C079304320240668&uuid=ffffffff-cd9e-be17-3c1d-5697050e83f7&timestamp=1445764527045&swidth=720&sheight=1280&net=wifi&sign=49feec3da9f2b131e2fde81be7a86ac7";
    
    [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" httpArg:httpArg completionHandle:^(id result) {
        
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSArray *shoplistArray = [dataDic objectForKey:@"shoplist"];
        
        NSMutableArray *mallArray = [[NSMutableArray alloc] init];
        for (NSDictionary *listDic in shoplistArray) {
            
            ShopMall *mall = [[ShopMall alloc] initWithDataDic:listDic];
            [mallArray addObject:mall];
            
        }
        _shopView.shopMallArray = mallArray;
        [_shopView reloadData];
        
        //        [self completeHUD:@"加载完成"];
        
    } errorHandle:^(NSError *error) {
        NSLog(@"商圈数据加载出错");
    }];
    
}

#pragma mark - 获取地理位置
//刷新按钮
- (void)refreshBtnAction {
    
    if (_locationManager == nil) {
        
        _locationManager = [[CLLocationManager alloc] init];
        
        if (kVersion >= 8.0) {
            
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    
    _locationLabel.text = @"努力加载中...";
    
    //设置定位精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [_locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //二 iOS自己内置定位方法
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"%@",place.name);
        
        _locationLabel.text = place.name;
        
    }];
    
    _lonLat = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    
    [self _loadData:_lonLat];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - JKPopMenuViewSelectDelegate
- (void)popMenuViewSelectIndex:(NSInteger)index
{
    //    NSLog(@"%s",__func__);
    NSLog(@"你点击了第%ld个按钮", index+1);
    
    //第一个按钮：地图树洞功能
    if (index == 0) {
        [self _createMap];
    }
}

#pragma mark - 地图点击按钮
-(void) _createMap {
    NearByViewController *nearbyVC = [[NearByViewController alloc] init];
    
    [self.navigationController pushViewController:nearbyVC animated:YES];
}



#pragma mark - 创建菜单栏按钮
-(void) _createMenuView {
    /**
     *  构建需要数据 2层或者3层数据 (ps 2层也当作3层来处理)
     */
    
    _lis =[NSMutableArray arrayWithCapacity:0];
    
    //1.有6页菜单栏
    NSInteger countMax=6;
    
    for (int i=0; i<countMax; i++) {
        //2.创建左边菜单栏 所对应的右边菜单栏（第一层）
        rightMeun *meun = [[rightMeun alloc] init];
        meun.meunName=[NSString stringWithFormat:@"菜单%d",i];
        
        //3.创建子菜单栏
        NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
        for ( int j=0; j <countMax+1; j++) {
            
            //子菜单栏 分类名（第二层）
            rightMeun * meun1=[[rightMeun alloc] init];
            meun1.meunName=[NSString stringWithFormat:@"%d头菜单%d",i,j];
            [sub addObject:meun1];
            
            //子菜单栏 分类内容（第三层）
            NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
            if (j%2==0) {
                
                for ( int z=0; z <countMax+2; z++) {
                    
                    rightMeun * meun2=[[rightMeun alloc] init];
                    meun2.meunName=[NSString stringWithFormat:@"%d层菜单%d",j,z];
                    
                    [zList addObject:meun2];
                    
                }
            }
            //将第三层数据 作为第二层数据的子内容
            meun1.nextArray=zList;
        }
        
        //将第二层数据 作为第一层数据的子内容
        meun.nextArray=sub;
        
        //4.将全部数据保存到数组
        [_lis addObject:meun];
    }
    
    /**
     *  适配 ios 7 和ios 8 的 坐标系问题
     */
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    /**
     默认是 选中第一行
     
     :returns: <#return value description#>
     */
    _menuView =[[MultilevelMenu alloc] initWithFrame:CGRectMake(0, 64-kScreenHeight, kScreenWidth, kScreenHeight-64) WithData:_lis withSelectIndex:^(NSInteger left, NSInteger right,rightMeun* info) {
        
        NSLog(@"点击的 菜单%@",info.meunName);
    }];
    
    //跳转到某页面时 默认选择某一行
    _menuView.needToScorllerIndex=0;
    
    //记录上一次滑动的位置，并选择是否需要动作效果
    //    view.isRecordLastScroll=YES;
    _menuView.isRecordLastScrollAnimated = YES;
    
    
    [self.view addSubview:_menuView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
