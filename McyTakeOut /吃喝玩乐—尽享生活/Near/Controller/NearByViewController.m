//
//  NearByViewController.m
//  吃喝玩乐—尽享生活
//
//  Created by 陈勇 on 15/10/22.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "NearByViewController.h"
#import "NearbyShopModel.h"
#import "ShopAnnotationView.h"
#import "NearbyShopAnnotation.h"
#import "MyNetWorkQuery.h"

@interface NearByViewController () {
    //自己的位置信息
    NSString *_lonLat;
    
    //商店信息数组
    NSMutableArray *_shopsArray;
}

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createViews];
    
    //定位自己的位置
    [self _location];
    
//    [self _loadNearByShop:@"1" lat:@"1"];

}

-(void) _createViews {
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    //地图样式
    _mapView.mapType = MKMapTypeStandard;
    
    //显示用户位置
    _mapView.showsUserLocation = YES;
    
    //用户跟随模式
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //代理
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
}

-(void) _location {
    
    /* 使用CLLocationManager的时候需要在info.plist文件中做如下配置
     NSLocationWhenInUseUsageDescription Boolean YES
     NSLocationAlwaysUsageDescription   string  （随意填写）
     */
    
    //1.定位
    if (_locationManager == nil) {
        
        _locationManager = [[CLLocationManager alloc] init];
        
        if (kVersion >= 8.0) {
            
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //1.停止定位
    [_locationManager stopUpdatingLocation];
    
    //2.获取位置数组中的最后一个元素，即最新位置
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //3.iOS自己内置定位方法
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"%@",place.name);
        
    }];
    
    //4.加载附近商店信息
    _lonLat = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    [self _loadData:_lonLat];
    
    //4.根据经纬度，获取附近商店
    //    [self _loadNearByShop:longitude lat:latitude];
    
    CLLocationCoordinate2D center = coordinate;
    MKCoordinateSpan span = {0.1, 0.1};
    
    //region设置范围：coordinate设置坐标，span设置显示跨度
    MKCoordinateRegion region = {center, span};
    [_mapView setRegion:region];
}


#pragma mark - 加载附近的商店
- (void)_loadData:(NSString *)lonlat {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"600010000" forKey:@"city_id"];
    [params setObject:lonlat forKey:@"location"];
    [params setObject:@"1000" forKey:@"radius"];
    
    [MyNetWorkQuery AFRequestData:Searchshops HTTPMethod:@"GET" params:params completionHandle:^(id result) {
        
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSArray *shopArr = [dataDic objectForKey:@"shops"];
        
        _shopsArray = [[NSMutableArray alloc] initWithCapacity:shopArr.count];
        for (NSDictionary *dic in shopArr) {
            NearbyShopModel *model = [[NearbyShopModel alloc] initWithDataDic:dic];
            
            NearbyShopAnnotation *annotation = [[NearbyShopAnnotation alloc] init];
            annotation.model = model;
            
            [_shopsArray addObject:annotation];
        }
        
        [_mapView addAnnotations:_shopsArray];
        
    } errorHandle:^(NSError *error) {
        NSLog(@"获取附近推荐出错");
    }];
 
    
}


#pragma mark - 创建标注视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //如果是自己的位置，则不要使用自定义标注视图
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        //0  复用池，得到 大头针标注视图
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"userView"];

        if (pinView == nil) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"userView"];

            //1  设置大头针颜色
            pinView.pinColor = MKPinAnnotationColorGreen;

            //2  从天而降动画
            pinView.animatesDrop = YES;

            //3 设置显示标题
            pinView.canShowCallout = YES;

            //4.添加辅助视图
            pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        return pinView;
    }
    
    //如果是商家的位置，使用自定义的视图
    ShopAnnotationView *annotationView = (ShopAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    
    if (annotationView == nil) {
        annotationView = [[ShopAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
    }
    
    annotationView.annotation = annotation;
    
    
    return annotationView;
    
}



#pragma mark - 选中标注视图的协议方法
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSLog(@"选中某个位置");
    
    //1.忽视非商店的图标点击事件
    if (![view.annotation isKindOfClass:[NearbyShopAnnotation class]]) {
        return;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
