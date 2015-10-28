//
//  HomeViewController.m
//  吃喝玩乐—尽享生活
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableView.h"
#import "MyNetWorkQuery.h"
#import "ShopModel.h"
#import "DealsModel.h"
#import "MBProgressHUD.h"
#import "CitiesViewController.h"
#import "CitiesModel.h"

@interface HomeViewController () {

    HomeTableView *_tableView;
    MBProgressHUD *_hud;
    
    NSString *cityID;
    BOOL isSelectedCity;

}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isSelectedCity = NO;

    //设置导航栏右边按钮
    [self rightNavBarButton:@"icon_nav_saoyisao_normal.png"];
    
    //创建表视图
    [self _createTableView];
    
    //城市选择按钮
    [self _selectedCity];
    
    //加载数据
    [self _loadData];
    
    [self showHUD:@"努力加载中..."];
    
    //监听城市选择
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData:) name:@"selectArrayChange" object:nil];
}

-(void) getData:(NSNotification *)notification {
    
    //    NSLog(@"getData:%@", notification.object);
    CitiesModel *model = notification.object;
    //    NSLog(@"%@", model.city_id);
    cityID = [model.city_id stringValue];
    isSelectedCity = YES;
    [self _loadData];
    [self showHUD:@"努力加载中..."];
    [_tableView reloadData];
    
}


//创建表视图
- (void)_createTableView {
    

    _tableView = [[HomeTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    [self.view addSubview:_tableView];
    
}



//加载数据
- (void)_loadData {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (!isSelectedCity) {
        [params setObject:@"600010000" forKey:@"city_id"];
    } else {
        [params setObject:cityID forKey:@"city_id"];
    }
    
    [params setObject:Location forKey:@"location"];
    [params setObject:@"30000" forKey:@"radius"];
    [params setObject:@10 forKey:@"page_size"];
    
    [MyNetWorkQuery AFRequestData:Searchdeals HTTPMethod:@"GET" params:params completionHandle:^(id result) {
        
        NSDictionary *dealDic = [result objectForKey:@"data"];
        NSArray *deal = [dealDic objectForKey:@"deals"];
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dataDic in deal) {
            
            DealsModel *model = [[DealsModel alloc] initWithDataDic:dataDic];
            [dataArray addObject:model];
            
        }
        _tableView.dataArray = dataArray;
        [_tableView reloadData];
        
        [self completeHUD:@"加载完成"];
        
    } errorHandle:^(NSError *error) {
        
    }];
    
}

#pragma mark - 提示栏
- (void)showHUD:(NSString *)title {
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_hud show:YES];
    _hud.labelText = title;
    _hud.dimBackground = YES;
    
}

- (void)hideHUD {
    
    [_hud hide:YES];
    
}

- (void)completeHUD:(NSString *)title {
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = title;
    [_hud hide:YES afterDelay:1.5];
    
}

#pragma mark - 城市选择按钮
- (void)_selectedCity {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 20);
    [button setImage:[UIImage imageNamed:@"home_arrow_down_red.png"] forState:UIControlStateNormal];
    [button setTitle:@"城市" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:250/255.0 green:39/255.0 blue:92/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(citiesSelected) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cityButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = cityButton;
}

- (void)citiesSelected {
    
    CitiesViewController *citiesVC = [[CitiesViewController alloc] init];
    [self.navigationController pushViewController:citiesVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
