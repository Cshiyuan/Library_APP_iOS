//
//  CSYSearchBookViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/8.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYSearchBookViewController.h"
#import "CSYHTTPClient.h"
#import "BookInfo.h"
#import "CSYBookInfoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CSYToolSet.h"


#define cellIdentify @"BookInfoIdentifier"

@interface CSYSearchBookViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UIButton *_crossButton;
    __weak IBOutlet UISearchBar *_searchBar;
    __weak IBOutlet UITableView *_bookTableView;
    
    NSMutableArray *_bookArray;
}

@end

@implementation CSYSearchBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bookArray = [[NSMutableArray alloc]init];
    
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
    
    [self configCell:cell With:_bookArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _bookArray.count;
}

-(void)configCell:(CSYBookInfoCell*)cell With:(BookInfo*)bookInfo
{
    cell.bKNameLabel.text = [NSString stringWithFormat:@"书名: %@", bookInfo.bookName];
    cell.bKPubNameLabel.text = [NSString stringWithFormat:@"出版社: %@", bookInfo.pubName];
    cell.detailInfoLabel.text = [NSString stringWithFormat:@"作者: %@ 书架: %@", bookInfo.authors,bookInfo.slfName];
    [cell.bKImageView sd_setImageWithURL:[NSURL URLWithString:bookInfo.cover_thumb_url] placeholderImage:nil];
}

#pragma -mark UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"1");
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search : %@",searchBar.text);
    [_searchBar resignFirstResponder];
    [self startLoadingWithIndicator];
    [[CSYHTTPClient defaultClient]getPath:Search_URL parameters:@{@"BookName":searchBar.text} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {

        }
        NSDictionary *responseDic = responseObject;
        NSNumber *code = responseDic[@"data"][@"code"];
        
        if ([code isEqualToNumber:@200])
        {
            
            
            NSArray *datas = responseDic[@"data"][@"info"];
            for(NSDictionary* book in datas)
            {
                BookInfo *info = [CSYToolSet getBookInfoWithDictionary:book];
                [_bookArray addObject:info];
            }
            
            [_bookTableView reloadData];
        }
        
        [self stopLoadingWithIndicator];
  
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
          [self stopLoadingWithIndicator];
        
    }];
    
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
    if (view == self.view || view == _bookTableView)
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
