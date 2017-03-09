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

    _searchBar.delegate = self;
    
    //遍历出UISearchBar的背景，从父窗口remove掉
    for (UIView *subview in [[_searchBar.subviews firstObject] subviews]) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
        }
    }
    
    [_searchBar setBackgroundColor:[UIColor colorWithRed:(146.0/255.0) green:(146.0/255.0) blue:(146.0/255.0) alpha:1 ]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"1");
}

-(void)crossButtonAction:(UIButton*)btn
{
    //    [self.navigationController.p]
    [_searchBar resignFirstResponder];
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
