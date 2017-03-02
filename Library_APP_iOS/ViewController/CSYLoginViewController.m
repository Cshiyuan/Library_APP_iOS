//
//  LoginViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/2.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYLoginViewController.h"

@interface CSYLoginViewController ()


-(void)p_setBackGroundImageAndEffect;
@end

@implementation CSYLoginViewController

- (void)viewDidLoad
{
    
    //设置背景和效果
    [self p_setBackGroundImageAndEffect];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)p_setBackGroundImageAndEffect
{
    UIImageView* backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cafedeadend"]];
    backgroundImageView.frame = self.view.frame;
    
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualEffectView.frame = backgroundImageView.frame;
    
    [backgroundImageView addSubview:visualEffectView];
    [self.view addSubview:backgroundImageView];
    
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
