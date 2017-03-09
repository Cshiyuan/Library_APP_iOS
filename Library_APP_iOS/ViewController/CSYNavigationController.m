//
//  CSYNavigationController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/5.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYNavigationController.h"

@interface CSYNavigationController ()  <UIGestureRecognizerDelegate>

@end

@implementation CSYNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *backButtonBackgroundImage = [[UIImage imageNamed:@"cross"] imageWithColor:[UIColor whiteColor]];
//    UIImage *backButtonBackgroundImage = [UIImage imageNamed:@"cross"];
//    backButtonBackgroundImage = [backButtonBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backButtonBackgroundImage.size.width + 1, 0, 0) resizingMode:UIImageResizingModeStretch];
//    
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:18.f]};
//    
//    //设置navBar字体颜色
//    //在plist里面, 加上View controller-based status bar appearance, 并且设置为NO
//    self.navigationBar.barStyle = UIStatusBarStyleDefault;
//    [self.navigationBar setTintColor:[UIColor whiteColor]];
//    
//    //设置NavBar的背景颜色
//    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
//    
//    //隐藏navgationBar底部的黑线
//    UIImageView *hairImageView = [self findHairlineImageViewUnder:self.view];
//    if (hairImageView){
//        
//        hairImageView.hidden = YES;
//    }
    
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

// 找出navgationBar的黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && CGRectGetHeight(view.bounds) <= 1.f) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
#pragma mark -定制StatusBarStyle
//- (UIViewController *)childViewControllerForStatusBarStyle{
//    return self.topViewController;
//}

@end
