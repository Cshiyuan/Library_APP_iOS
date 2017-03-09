//
//  CSYSearchBookViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/8.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYSearchBookViewController.h"

@interface CSYSearchBookViewController () <UISearchResultsUpdating, UISearchControllerDelegate,UISearchBarDelegate>
{
    __weak IBOutlet UIButton *_crossButton;
    __weak IBOutlet UISearchBar *_searchBar;
}

@end

@implementation CSYSearchBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_crossButton addTarget:self action:@selector(crossButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    
//    _searchBar = [[UISearchBar alloc]init];
    _searchBar.delegate = self;
    
    self.navigationItem.titleView = _searchBar;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)crossButtonAction:(UIButton*)btn
{
    //    [self.navigationController.p]
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma -mark 定制statusBar部分
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
