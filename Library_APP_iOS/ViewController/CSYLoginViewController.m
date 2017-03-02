//
//  LoginViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/2.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYLoginViewController.h"
#import "CSYLoginView.h"
#import "Masonry.h"

@interface CSYLoginViewController ()
{
    CSYLoginView* _loginView;
}


-(void)p_setBackGroundImageAndEffect;
-(void)p_setLoginView;
-(void)p_setRegisterView;
@end

@implementation CSYLoginViewController

- (void)viewDidLoad
{
    
    //设置背景和效果
    [self p_setBackGroundImageAndEffect];
    
    [self p_setLoginView];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark 设置背景
-(void)p_setBackGroundImageAndEffect
{
    UIImageView* backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cafedeadend"]];
    backgroundImageView.frame = self.view.frame;
    
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualEffectView.frame = backgroundImageView.frame;
    visualEffectView.alpha = 0.8;
    
    [backgroundImageView addSubview:visualEffectView];
    [self.view addSubview:backgroundImageView];
    
}
#pragma -mark 设置登录View
-(void)p_setLoginView
{

    _loginView = [CSYLoginView getView];
    _loginView.layer.cornerRadius = 10;
    _loginView.alpha = 0.9;
//    _loginView.frame = CGRectMake(100, 300, 200, 200);

    [self.view addSubview:_loginView];
    
    
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_loginView.superview.mas_centerX);
        make.centerY.equalTo(_loginView.superview.mas_centerY);
        make.width.equalTo(_loginView.superview.mas_width).multipliedBy(0.8);
        make.height.equalTo(_loginView.mas_width);
    }];
    //一定要先加入到父类才有效  设置渐变
//    [loginView setGradientColorWith:[UIColor blueColor] toColor:[UIColor whiteColor] WithAlpha:0.6];
}
#pragma -mark  设置注册View
-(void)p_setRegisterView
{
    
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
