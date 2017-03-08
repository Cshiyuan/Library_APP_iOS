//
//  CSYCommonViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/5.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYCommonViewController.h"
#import "MBProgressHUD.h"
#import "CSYLRViewController.h"
//#import "ZSBlockAlertView.h"
#import "CSYNavigationController.h"
#import "SVProgressHUD.h"

#define LOG_DATA(d) NSLog(@"%@", [[NSString alloc] initWithData:(d) encoding:NSUTF8StringEncoding])
#define INDICATOR_ALPHA 0.7f

#define HUDSuccessMessage(msg,d) ([SVProgressHUD showSuccessWithStatus:(msg) duration:(d)])
#define HUDErrorMessage(msg,d) ([SVProgressHUD showErrorWithStatus:(msg) duration:(d)])


float CSYHudShortDuration = 0.5f;
float CSYHudNormalDuration = 1.0f;
float CSYHudLongDuration = 2.0f;

NSString *const DMMultiShopSelectedShopChangedNotification = @"DMMultiShopSelectedShopChangedNotification";

//static const void *kDMLoadingHUDKey = "kDMLoadingHUDKey";



static NSOperationQueue *sRequestQueue = nil;


@interface CSYCommonViewController ()

@end

@implementation CSYCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Message METHODS
- (void)showLoadingHUDWithText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = text;
}

- (void)dismissHUD
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}

- (void)showSuccessHUDWithText:(NSString *)text
{
    [self showSuccessHUDWithText:text duration:CSYHudShortDuration];
}

- (void)showSuccessHUDWithText:(NSString *)text duration:(float)duration
{
    [self dismissHUD];
//    HUDSuccessMessage(text, duration);
    
    [SVProgressHUD showSuccessWithStatus:text];
}

- (void)showErrorHUDWithText:(NSString *)text
{
    [self showErrorHUDWithText:text duration:CSYHudNormalDuration];
}

- (void)showErrorHUDWithText:(NSString *)text duration:(float)duration
{
    [self dismissHUD];
//    HUDErrorMessage(text, duration);
}

-(void)presentLoginViewController{
    
    [self.view endEditing:YES];
//    [DMUserLoginSession destroyActiveSession];
//    [[NSNotificationCenter defaultCenter] postNotificationName:DMUserDidLogoutNotificationName object:nil];
    CSYLRViewController *controller = [[CSYLRViewController alloc] init];
    
    CSYNavigationController *nav = [[CSYNavigationController alloc] initWithRootViewController:controller];
    [nav setNavigationBarHidden:YES animated:NO];
    
    if (self.navigationController) {
        
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    } else {
        
        [self presentViewController:nav animated:YES completion:nil];
    }

}

-(void)presentViewController:(UIViewController*)vc
{
    CSYNavigationController *nav = [[CSYNavigationController alloc] initWithRootViewController:vc];
    [nav setNavigationBarHidden:YES animated:NO];
    
    if (self.navigationController) {
        
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
    } else {
        
        [self presentViewController:nav animated:YES completion:nil];
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
