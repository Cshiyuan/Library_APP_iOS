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
#import "UISearchBar+CSYBase.h"
#import "CSYToolSet.h"


#define cellIdentify @"BookInfoIdentifier"
//#define searchResultCellIdentifiers = @"SearchResultCell"
#define nothingFoundCellIdentifiers @"NothingFoundCell"


@interface CSYSearchBookViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UIView *_topNavigationView;
    __weak IBOutlet UIButton *_crossButton;
    __weak IBOutlet UISearchBar *_searchBar;
    __weak IBOutlet UITableView *_bookTableView;
    NSMutableArray *_bookArray;
    __weak IBOutlet NSLayoutConstraint *topNaivgationViewHeight;
}

@end

@implementation CSYSearchBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"NothingFoundCell" bundle:nil];
    [_bookTableView registerNib:nib forCellReuseIdentifier:nothingFoundCellIdentifiers];
    _bookArray = [[NSMutableArray alloc]init];
    [_crossButton addTarget:self action:@selector(crossButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _searchBar.delegate = self;
    //去掉边框并且设置颜色
    [_searchBar removeBorderWithBackgroundColor:[UIColor colorWithRed:(146.0/255.0) green:(146.0/255.0) blue:(146.0/255.0) alpha:1 ]];
    _bookTableView.delegate = self;
    _bookTableView.dataSource = self;
    
    //有传递值
    if(_keyWorkForSearch)
    {
        [self loadingBookInfo:_keyWorkForSearch];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma -mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_bookArray.count == 0)
    {
        UITableViewCell *nothingFoundCell =  [_bookTableView dequeueReusableCellWithIdentifier:nothingFoundCellIdentifiers forIndexPath:indexPath];
        nothingFoundCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return nothingFoundCell;
    }
    
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
    if(_bookArray.count == 0)
        return 1;
    return _bookArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_bookArray.count == 0) {
        return _bookTableView.frame.size.height;
    }
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    if(_bookArray.count == 0)
    {
        [_searchBar resignFirstResponder];
        return ;
    }
    [_searchBar resignFirstResponder];
    if(_bookInfoBlock)
    {
        _bookInfoBlock(_bookArray[indexPath.row]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)configCell:(CSYBookInfoCell*)cell With:(BookInfo*)bookInfo
{
    cell.bKNameLabel.text = [NSString stringWithFormat:@"书名: %@", bookInfo.bookName];
    cell.bKPubNameLabel.text = [NSString stringWithFormat:@"出版社: %@", bookInfo.pubName];
    cell.detailInfoLabel.text = [NSString stringWithFormat:@"作者: %@ 书架: %@", bookInfo.authors,bookInfo.slfName];
    [cell.bKImageView sd_setImageWithURL:[NSURL URLWithString:bookInfo.cover_thumb_url] placeholderImage:nil];
}


#pragma -mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search : %@",searchBar.text);
    [_bookArray removeAllObjects];
    [_searchBar resignFirstResponder];
    [self loadingBookInfo:searchBar.text];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"beginEditing");
    topNaivgationViewHeight.constant = 0;
    return YES;
}

#pragma -mark 根据关键字从远程加载数据
-(void)loadingBookInfo:(NSString*)keyWord
{
     [self startLoadingWithIndicator];
    [[CSYHTTPClient defaultClient]getPath:Search_URL parameters:@{@"BookName":keyWord} success:^(NSURLSessionDataTask *task, id responseObject) {
        
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
        [_bookTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self stopLoadingWithIndicator];
        
    }];

}

-(void)crossButtonAction:(UIButton*)btn
{
    [_searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma -mark 定制statusBar部分
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
