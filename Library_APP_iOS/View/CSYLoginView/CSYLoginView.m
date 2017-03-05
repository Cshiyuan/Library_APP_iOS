//
//  CSYLoginView.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/2.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYLoginView.h"
#import "Masonry.h"

@interface CSYLoginView()
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
        
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _passWord.secureTextEntry = YES;
}

-(void)setLoginAction:(LoginAction)action
{
    if(action)
    {
        _loginAction = action;
    }
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (textView.frame.origin.y+textView.frame.size.height+10) - (self.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
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



@end
