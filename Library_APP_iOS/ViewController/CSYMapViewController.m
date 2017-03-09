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
#import "CSYSearchBookViewController.h"
#import "UISearchBar+CSYBase.h"

@interface CSYMapViewController () <FMKMapViewDelegate>
{
    __weak IBOutlet UIView* _topStatusView;
    __weak IBOutlet UISearchBar *_searchBar;
}
@property (nonatomic,strong) FMKMapView *mapView;

-(void)p_setButton;
@end

@implementation CSYMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 通过地图ID初始化地图视图
    self.mapView = [[FMKMapView alloc] initWithFrame:self.view.frame ID:@"00205100000590132" delegate:self autoUpgrade:NO];
    [self.view addSubview:_mapView];
    
    
    
    UITapGestureRecognizer *tagGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchesMap)];
    [_mapView addGestureRecognizer:tagGR];
    
    // 通过主题ID设置主题，ID从蜂鸟官网开发资源中获取
    [_mapView setThemeWithID:@"3002"];
    [self p_setButton];
    
    [self.view bringSubviewToFront:_topStatusView];
    [self.view bringSubviewToFront:_searchBar];
    

    //重新设置颜色
    [_searchBar removeBorderWithBackgroundColor:[UIColor colorWithRed:(146.0/255.0) green:(146.0/255.0) blue:(146.0/255.0) alpha:1 ]];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [userDefaults boolForKey:@"isLogin"];
    
    if(!isLogin){
        [self presentLoginViewController];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)p_setButton
{
    UIButton *scanQRButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanQRButton.backgroundColor = [UIColor cyanColor];
    scanQRButton.alpha = 0.6;
    scanQRButton.layer.cornerRadius = 10.0;
    scanQRButton.titleLabel.font = [UIFont systemFontOfSize:11];
    scanQRButton.layer.borderWidth = 1.0;
    [scanQRButton setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateNormal];
    [scanQRButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.view addSubview:scanQRButton];
    [scanQRButton addTarget:self action:@selector(scanButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [scanQRButton addTarget:self action:@selector(scanButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [scanQRButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.12);
        make.height.equalTo(scanQRButton.mas_width);
    }];
    
    
    UIButton *searchBKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBKButton.backgroundColor = [UIColor redColor];
    searchBKButton.alpha = 0.6;
    searchBKButton.layer.cornerRadius = 10.0;
    searchBKButton.layer.borderWidth = 1.0;
    searchBKButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [searchBKButton setTitle:@"找书" forState:UIControlStateNormal];
    [searchBKButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:searchBKButton];
    [searchBKButton addTarget:self action:@selector(searchBKButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [searchBKButton addTarget:self action:@selector(searchBKButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [searchBKButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(scanQRButton.mas_bottom).offset(-50);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.12);
        make.height.equalTo(scanQRButton.mas_width);
    }];
    
}

#pragma -mark 按钮响应事件
-(void)scanButtonTouchDown:(UIButton *)btn
{
    [btn setBackgroundColor:[UIColor grayColor]];
}

-(void)scanButtonTouchUpInside:(UIButton *)btn
{
    [btn setBackgroundColor:[UIColor cyanColor]];
    CSYScanQRViewController *vc = [[CSYScanQRViewController alloc]init];
    [self presentViewController:vc];
}

-(void)searchBKButtonTouchDown:(UIButton *)btn
{
    
    [btn setBackgroundColor:[UIColor grayColor]];
  
}

-(void)searchBKButtonTouchUpInside:(UIButton *)btn
{
    [btn setBackgroundColor:[UIColor redColor]];
    CSYSearchBookViewController *vc = [[CSYSearchBookViewController alloc]init];
    [self presentViewController:vc];
}

#pragma -mark 定制statusBar部分
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)touchesMap
{
    //触碰地图的时候将_searchBar收起
    [_searchBar resignFirstResponder];
}
@end
