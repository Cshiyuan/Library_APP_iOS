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
//        _registerButton.frame =
        _registerButton.alpha = 0.8;
//        _registerButton.titleLabel.text = @"注册";
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_registerButton];
        
        
    }
    return self;
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


@end
