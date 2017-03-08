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
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *videoPreviewLayer;
    UIView *qrCodeFrameView;
}

@end

@implementation CSYScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_crossButton addTarget:self action:@selector(crossButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput* input = [[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:nil];
    
    captureSession = [[AVCaptureSession alloc]init];
    
    [captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc]init];
    
    [captureSession addOutput:captureMetadataOutput];
    
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    videoPreviewLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:videoPreviewLayer];
    
    [captureSession startRunning];
    
    
//    

//    // Start video capture.
//    captureSession?.startRunning()
//    
//    view.bringSubview(toFront: messageLabel);
//    view.bringSubview(toFront: topbar);
//    
//    qrCodeFrameView = UIView();
//    if let qrCodeFrameView = qrCodeFrameView {
//        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor;
//        qrCodeFrameView.layer.borderWidth = 2;
//        view.addSubview(qrCodeFrameView);
//        view.bringSubview(toFront: qrCodeFrameView);
//    }
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
}

-(void)crossButtonAction:(UIButton*)btn
{
//    [self.navigationController.p]
    [self dismissViewControllerAnimated:YES completion:nil];
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
