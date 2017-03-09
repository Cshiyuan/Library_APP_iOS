//
//  CSYSearchBookViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/8.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYSearchBookViewController.h"
#import "BookInfo.h"
#import "CSYBookInfoCell.h"


#define cellIdentify @"BookInfoIdentifier"

@interface CSYSearchBookViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UIButton *_crossButton;
    __weak IBOutlet UISearchBar *_searchBar;
    __weak IBOutlet UITableView *_bookTableView;
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
    
    //重新设置颜色
    [_searchBar setBackgroundColor:[UIColor colorWithRed:(146.0/255.0) green:(146.0/255.0) blue:(146.0/255.0) alpha:1 ]];

    _bookTableView.delegate = self;
    _bookTableView.dataSource = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma -mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSYBookInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"CSYBookInfoCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        
    }
    
    cell.bKNameLabel.text = @"书名: dasd";
    cell.bKPubNameLabel.text = @"出版社: 华纳师范大学";
    cell.detailInfoLabel.text = @"作者: 201231,23.123  书架: asd";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}




#pragma -mark UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"1");
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search : %@",searchBar.text);
}



-(void)crossButtonAction:(UIButton*)btn
{
    [_searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 触摸背景，关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (view == self.view)
    {
        [_searchBar resignFirstResponder];
    }
}


#pragma -mark 定制statusBar部分
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
