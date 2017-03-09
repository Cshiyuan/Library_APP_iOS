//
//  CSYScanQRViewController.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/8.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYScanQRViewController.h"

@interface CSYScanQRViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    __weak IBOutlet UIButton *_crossButton;
    __weak IBOutlet UIView *_topView;
    __weak IBOutlet UIView *_topStatusView;
    AVCaptureSession *_captureSession;
    AVCaptureVideoPreviewLayer *_videoPreviewLayer;
    UIView *_qrCodeFrameView;
}

@end

@implementation CSYScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_crossButton addTarget:self action:@selector(crossButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput* input = [[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:nil];
    
    _captureSession = [[AVCaptureSession alloc]init];
    
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc]init];
    
    [_captureSession addOutput:captureMetadataOutput];
    
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _videoPreviewLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    
    [self.view bringSubviewToFront:_topView];
    [self.view bringSubviewToFront:_topStatusView];

    _qrCodeFrameView = [[UIView alloc]init];
    _qrCodeFrameView.layer.borderColor = [UIColor greenColor].CGColor;
    _qrCodeFrameView.layer.borderWidth = 2;
    [self.view addSubview:_qrCodeFrameView];
    [self.view bringSubviewToFront:_qrCodeFrameView];
    
    
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    self.preferredStatusBarStyle = UIStatusBarStyleLightContent;
//    [self setNeedsStatusBarAppearanceUpdate];

    //相对于上面的接口，这个接口可以动画的改变statusBar的前景色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
//    [self pre]
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if(metadataObjects.count == 0 || metadataObjects == nil)
    {
        _qrCodeFrameView.frame = CGRectZero;
        return;
    }
    
    //Get the metadata object
    AVMetadataMachineReadableCodeObject *metadataObj = metadataObjects[0];
    if (metadataObj.type == AVMetadataObjectTypeQRCode) {
        AVMetadataObject *barCodeObject = [_videoPreviewLayer transformedMetadataObjectForMetadataObject:metadataObj];
        
        _qrCodeFrameView.frame = barCodeObject.bounds;
        
        if(metadataObj.stringValue != nil)
        {
            NSLog(@"%@",metadataObj.stringValue);
        }
        
    }
}

-(void)crossButtonAction:(UIButton*)btn
{
//    [self.navigationController.p]
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma -mark 定制statusBar部分
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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