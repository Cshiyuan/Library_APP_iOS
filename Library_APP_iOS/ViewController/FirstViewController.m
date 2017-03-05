//
//  FirstViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/2.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "FirstViewController.h"
#import "FMMapKit.h"

@interface FirstViewController () <FMKMapViewDelegate>
@property (nonatomic,strong) FMKMapView *mapView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    
    
    // 通过地图ID初始化地图视图
    self.mapView = [[FMKMapView alloc] initWithFrame:self.view.frame ID:@"00205100000590132" delegate:self autoUpgrade:NO];
    [self.view addSubview:_mapView];
    
    // 通过主题ID设置主题，ID从蜂鸟官网开发资源中获取
    [_mapView setThemeWithID:@"3002"];
    
//    [self presentLoginViewController];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    [userDefaults setBool:YES forKey:@"isLogin"];
    BOOL isLogin = [userDefaults boolForKey:@"isLogin"];
    
    if (!isLogin) {
        [self presentLoginViewController];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
