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
