//
//  CSYCommonViewController.h
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/5.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSYCommonViewController : UIViewController


-(void)startLoadingWithIndicator;
-(void)stopLoadingWithIndicator;

- (void) dismissHUD;
- (void) showSuccessHUDWithText:(NSString *) text;
- (void) showSuccessHUDWithText:(NSString *)text duration:(float) duration;
- (void) showErrorHUDWithText:(NSString *) text;
- (void) showErrorHUDWithText:(NSString *) text duration:(float) duration;

- (void) showLoadingHUDWithText:(NSString *) text;
- (void)presentViewController:(UIViewController*)vc;
- (void)presentLoginViewController;
@end
