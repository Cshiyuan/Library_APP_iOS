//
//  LoginViewController.h
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/2.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSYCommonViewController.h"

@interface CSYLRViewController : CSYCommonViewController

//Message Methods
- (void) showLoadingHUDWithText:(NSString *) text;
- (void) dismissHUD;
- (void) showSuccessHUDWithText:(NSString *) text;



@end
