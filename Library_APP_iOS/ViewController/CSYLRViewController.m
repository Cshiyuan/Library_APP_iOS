//
//  LoginViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/2.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYLRViewController.h"
#import "CSYLoginView.h"
#import "Masonry.h"
#import "CSYHTTPClient.h"

@interface CSYLRViewController ()
{
    CSYLoginView* _loginView;
    double _moveHeight;
}


-(void)p_setBackGroundImageAndEffect;
-(void)p_setLoginView;
-(void)p_setRegisterView;
@end

@implementation CSYLRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _moveHeight = 0;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKeyboardDisappear:) name:UIKeyboardWillHideNotification object:nil];

    
    //设置背景和效果
    [self p_setBackGroundImageAndEffect];
    [self p_setLoginView];
    
    
    
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
   
    
    [_loginView setLoginAction:^(NSString *email, NSString *password) {
        
//         [self showLoadingHUDWithText:nil];
        
            [[CSYHTTPClient defaultClient]getPath:LOGIN_URL parameters:@{@"email": email,@"password":password} success:^(NSURLSessionDataTask *task, id responseObject) {
        
                if (![responseObject isKindOfClass:[NSDictionary class]]) {
        //            handler(-100, @"格式有误");
        //            return nil;
                }
                NSDictionary *responseDic = responseObject;
                NSNumber *code = responseDic[@"data"][@"code"];
                
                if ([code isEqualToNumber:@200])
                {
//                    [self dismissHUD];

                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setBool:YES forKey:@"isLogin"];
                    
                }
                else
                {
//                    [self dismissHUD];
                }
        
                NSLog(@"%@",code);
        
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
    }];
}
#pragma -mark  设置注册View
-(void)p_setRegisterView
{
    
}

#pragma mark -键盘即将跳出

-(void)didClickKeyboard:(NSNotification *)sender
{
 
    NSLog(@"didClickKeyboard");
    CGFloat durition = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGRect keyboardRect = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
//    CGFloat keyboardHeight = keyboardRect.size.height;
    double betweenHeight = (_loginView.frame.origin.y + _loginView.frame.size.height) - keyboardRect.origin.y;
//    
    if (betweenHeight > 0) {
        _moveHeight += betweenHeight;
    }

    if(betweenHeight > 0)
    {
        [UIView animateWithDuration:durition animations:^{
        
            _loginView.transform = CGAffineTransformMakeTranslation(0, -_moveHeight);
        
        }];
    }
    
    
}

#pragma mark -当键盘即将消失

-(void)didKeyboardDisappear:(NSNotification *)sender
{
    NSLog(@"didKeyboardDisappear");
    
    CGFloat duration = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        
        _loginView.transform = CGAffineTransformIdentity;
        
    }];
    
    _moveHeight = 0;
    
}

// 触摸背景，关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (view == self.view || view == _loginView) {
        [_loginView.passWord resignFirstResponder];
        [_loginView.userName resignFirstResponder];
    }
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
