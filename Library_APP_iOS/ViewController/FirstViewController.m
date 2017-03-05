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
    
//    [self presentLoginViewController];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self presentLoginViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
