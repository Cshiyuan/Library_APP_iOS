//
//  CSYMapViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/8.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYMapViewController.h"
#import "FMMapKit.h"
#import "Masonry.h"
#import "CSYScanQRViewController.h"

@interface CSYMapViewController () <FMKMapViewDelegate>
@property (nonatomic,strong) FMKMapView *mapView;

-(void)p_setButton;
@end

@implementation CSYMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 通过地图ID初始化地图视图
    self.mapView = [[FMKMapView alloc] initWithFrame:self.view.frame ID:@"00205100000590132" delegate:self autoUpgrade:NO];
    [self.view addSubview:_mapView];
    
    // 通过主题ID设置主题，ID从蜂鸟官网开发资源中获取
    [_mapView setThemeWithID:@"3002"];
    [self p_setButton];
    
    //    [self presentLoginViewController];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    [userDefaults setBool:YES forKey:@"isLogin"];
    BOOL isLogin = [userDefaults boolForKey:@"isLogin"];
    
//    if (!isLogin) {
    if(!isLogin){
        [self presentLoginViewController];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)p_setButton
{
    UIButton *scanQRButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanQRButton.backgroundColor = [UIColor blueColor];
    scanQRButton.alpha = 0.5;
    scanQRButton.layer.cornerRadius = 10.0;
    scanQRButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [scanQRButton setTitle:@"扫码" forState:UIControlStateNormal];
    [scanQRButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:scanQRButton];
    
    [scanQRButton addTarget:self action:@selector(scanButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [scanQRButton addTarget:self action:@selector(scanButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    [scanQRButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.1);
        make.height.equalTo(scanQRButton.mas_width);
    }];
    
}

#pragma -mark 按钮响应事件
-(void)scanButtonTouchDown:(UIButton *)btn
{
    [btn setBackgroundColor:[UIColor grayColor]];
    CSYScanQRViewController *vc = [[CSYScanQRViewController alloc]init];
    [self presentViewController:vc];
    
}

-(void)scanButtonTouchUpInside:(UIButton *)btn
{
    [btn setBackgroundColor:[UIColor blueColor]];
}

@end
