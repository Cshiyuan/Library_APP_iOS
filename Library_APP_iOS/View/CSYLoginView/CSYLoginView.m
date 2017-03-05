//
//  CSYLoginView.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/2.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYLoginView.h"
#import "Masonry.h"

@interface CSYLoginView() <UITextFieldDelegate>
{
    UIButton *_registerButton;
    LoginAction _loginAction;
    
}

@end


@implementation CSYLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//重写initWithCoder:用代码添加子控件
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        //you init
        _registerButton = [[UIButton alloc]init];
        _registerButton.layer.cornerRadius = 20;
        _registerButton.alpha = 0.8;
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_registerButton];
        
        
        //注册键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillChangeFrameNotification object:nil];
        //注册键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_passWord];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_userName];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
        
        [self addGestureRecognizer:singleTap];
        
        
    }
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _loginButton.userInteractionEnabled = NO;
    _loginButton.alpha = 0.5;
    
    _passWord.secureTextEntry = YES;
    
    _passWord.delegate = self;
    _userName.delegate = self;
    
    
    
}

#pragma -mark UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
   
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if(textField == _passWord)
    {
        [self loginAction:_loginButton];
    } else {
        [_passWord becomeFirstResponder];
    }
    return YES;
}

//给子控件布局
- (void)layoutSubviews
{
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(_registerButton.superview.mas_top).offset(-20);
        make.right.equalTo(_registerButton.superview.mas_right).offset(20);
        
    }];
}

-(void)loginAction:(UIButton *)button
{
    if(_loginAction)
    {
        _loginAction(_userName.text,_passWord.text);
    }
}




-(void)setLoginAction:(LoginAction)action
{
    if(action)
    {
        _loginAction = action;
    }
}



#pragma -mark NSNotification


-(void)textFieldChanged:(UITextField*)textField
{
    if(![_passWord.text isEqualToString:@""] && ![_userName.text isEqualToString:@""])
    {
        _loginButton.userInteractionEnabled = YES;
        _loginButton.alpha = 1.0;
    }
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    
    [self endEditing:YES];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyboardRect = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGFloat keyboardHeight = keyboardRect.origin.y;
    
//    NSLog(@"%@",self.frame);
//    NSLog(@"%@",CGRectGetMaxY(self.frame));
    
    double bHeight = CGRectGetMaxY(self.frame) - keyboardHeight;
    
    if(bHeight > 0)
    {
        [UIView animateWithDuration:duration animations:^{
            
            self.transform = CGAffineTransformMakeTranslation(0, -bHeight);
            
        }];
    }
    

}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    
    self.transform = CGAffineTransformIdentity;
}




@end
