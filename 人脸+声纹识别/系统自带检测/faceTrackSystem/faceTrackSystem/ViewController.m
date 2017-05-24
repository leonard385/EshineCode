//
//  ViewController.m
//  faceTrackSystem
//
//  Created by 倪望龙 on 2017/5/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FTDetailView.h"
@interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,UIAlertViewDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *frontCamera;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;
//输出图片
@property (nonatomic ,strong) AVCaptureVideoDataOutput *output;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;
//人脸识别
@property(nonatomic,strong)CIDetector *faceDetector;
@property (nonatomic ,strong)FTDetailView *detailsView;
@end

@implementation ViewController

-(FTDetailView *)detailsView{
    if(_detailsView == nil){
        _detailsView = [FTDetailView new];
    }
    return _detailsView;
}

-(AVCaptureDevice *)frontCamera{
    if(_frontCamera == nil){
        _frontCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
    }
    return _frontCamera;
}

-(AVCaptureDeviceInput *)input{
    if(_input == nil){
        _input = [[AVCaptureDeviceInput alloc]initWithDevice:self.frontCamera error:nil];
    }
    return _input;
}

-(AVCaptureVideoDataOutput *)output{
    if(_output == nil){
        _output = [[AVCaptureVideoDataOutput alloc]init];
    }
    return _output;
}

-(AVCaptureSession *)session{
    if(_session == nil){
        _session = [[AVCaptureSession alloc]init];
        _session.sessionPreset = AVCaptureSessionPresetPhoto;
    }
    return _session;
}

-(AVCaptureVideoPreviewLayer *)previewLayer{
    if(_previewLayer == nil){
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
        _previewLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //Preserve aspect ratio; fill layer bounds
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}

-(CIDetector *)faceDetector{
    if(_faceDetector == nil){
        _faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyLow}];
    }
    return _faceDetector;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.previewLayer.frame = self.view.frame;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self VcSetUpdevice];
    [self VCSetUpSubviews];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)VCSetUpSubviews{
    [self.view.layer addSublayer:self.previewLayer];
    [self.view addSubview:self.detailsView];
    [self.view bringSubviewToFront:self.detailsView];
}

-(void)VcSetUpdevice{
    [self.session beginConfiguration];
    //session连接输入输出
    NSDictionary *settings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
    self.output.videoSettings = settings;
    self.output.alwaysDiscardsLateVideoFrames = YES;
    [self.session canAddInput:self.input] ? [self.session addInput:self.input]:nil;
    [self.session canAddOutput:self.output] ? [self.session addOutput:self.output]:nil;
    [self.session commitConfiguration];
    //添加图像预览
    [self.view.layer addSublayer:self.previewLayer];
    dispatch_queue_t queue = dispatch_queue_create("cameraQueue", DISPATCH_QUEUE_SERIAL);
    [self.output setSampleBufferDelegate:self queue:queue];
    [self.session startRunning];
}

#pragma mark - 获取摄像头设备
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    
    /*
     AVCaptureDevicePositionUnspecified         = 0,
     AVCaptureDevicePositionBack                = 1,
     AVCaptureDevicePositionFront               = 2
     */
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate代理方法
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    NSDictionary *attachments = CFBridgingRelease(CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate));
    CIImage *faceImage = [CIImage imageWithCVImageBuffer:pixelBuffer options:attachments];
    UIImage *faceOriginImage = [self sampleBufferToImage:sampleBuffer];
    UIImage *faceImg = [self fixOrientation:faceOriginImage];
    NSMutableDictionary *faceOptions = [NSMutableDictionary new];
    NSNumber *orientNum = [NSNumber numberWithInt:[self exifOrientation:[UIDevice currentDevice].orientation]];
    [faceOptions setObject:orientNum forKey:CIDetectorImageOrientation];
    [faceOptions setObject:[NSNumber numberWithBool:true] forKey:CIDetectorSmile];
    [faceOptions setObject:[NSNumber numberWithBool:true] forKey:CIDetectorEyeBlink];
    
    NSArray *allFaces = [self.faceDetector featuresInImage:faceImage options:faceOptions];
    CMFormatDescriptionRef formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer);
    CGRect cleanAperture = CMVideoFormatDescriptionGetCleanAperture(formatDescription, false);
    for (CIFaceFeature * faceFeature in allFaces) {
        CGRect faceRect = [self calculateFaceRectFacePosition:faceFeature.mouthPosition FaceBounds:faceFeature.bounds ClearAperture:cleanAperture];
        NSString *featureDetails = [NSString stringWithFormat:@"has smile: %d \n has closed left eye %d \n has closed right eye %d",faceFeature.hasSmile,faceFeature.leftEyeClosed,faceFeature.rightEyeClosed];
        [self updateWithFaceRect:faceRect Text:featureDetails];
        
        //3s后拍照
        __weak __typeof(self) weakSelf = self;
        if(faceFeature.leftEyeClosed && faceFeature.rightEyeClosed){
            //延时3s拍照
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.session stopRunning];
                _getFacePictureBlock ? _getFacePictureBlock(faceImg):nil;
            });
        }
    }
    if(allFaces.count == 0){
       dispatch_async(dispatch_get_main_queue(), ^{
           self.detailsView.alpha = 0.0f;
       });
    }
}

#pragma mark - 判断设备方向
-(int)exifOrientation:(UIDeviceOrientation)orientation{
    switch (orientation) {
        case UIDeviceOrientationFaceDown:
            return 8;
        case UIDeviceOrientationLandscapeLeft:
            return 3;
        case UIDeviceOrientationLandscapeRight:
            return 1;
        default:
            return 6;
    }

}

#pragma mark - 人像调整
-(CGRect)calculateFaceRectFacePosition:(CGPoint)facePosition FaceBounds:(CGRect)faceBounds ClearAperture:(CGRect)clearAperture{
    CGSize parentFrameSize = self.previewLayer.frame.size;
    CGRect previewBox = [self videoBoxFrameSize:parentFrameSize ApertureSize:clearAperture.size];
    CGRect faceRect = faceBounds;
    CGFloat temp;
    temp = faceRect.size.width;
    faceRect.size.width =  faceRect.size.height;
    faceRect.size.height = temp;
    
    temp = faceRect.origin.x;
    faceRect.origin.x =  faceRect.origin.y;
    faceRect.origin.y = temp;
    
    CGFloat widthScaleBy = previewBox.size.width / clearAperture.size.height;
    CGFloat heightScaleBy = previewBox.size.height / clearAperture.size.width;
    
    faceRect.size.width *= widthScaleBy;
    faceRect.size.height *= heightScaleBy;
    faceRect.origin.x *= widthScaleBy;
    faceRect.origin.y *= heightScaleBy;
    faceRect.origin.y += previewBox.origin.y;
    CGRect frame = CGRectMake(parentFrameSize.width - faceRect.origin.x - faceRect.size.width / 2.0 - previewBox.origin.x / 2.0f, faceRect.origin.y, faceRect.size.width, faceRect.size.height);
    return frame;
}

#pragma mark - 人脸框大小
-(CGRect)videoBoxFrameSize:(CGSize)frameSize ApertureSize:(CGSize)apertureSize{
    CGFloat apertureRatio = apertureSize.height / apertureSize.width;
    CGFloat viewRatio = frameSize.width / frameSize.height;
    CGSize size = CGSizeZero;

    if (viewRatio > apertureRatio) {
        size.width = frameSize.width;
        size.height = apertureSize.width * (frameSize.width / apertureSize.height);
    } else {
        size.width = apertureSize.height * (frameSize.height / apertureSize.width);
        size.height = frameSize.height;
    }

    CGRect videoBox = CGRectMake(0, 0, size.width,size.height);
    
    if (size.width < frameSize.width) {
        videoBox.origin.x = (frameSize.width - size.width) / 2.0;
    } else {
        videoBox.origin.x = (size.width - frameSize.width) / 2.0;
    }
    
    if (size.height < frameSize.height) {
        videoBox.origin.y = (frameSize.height - size.height) / 2.0;
    } else {
        videoBox.origin.y = (size.height - frameSize.height) / 2.0;
    }
    
    return videoBox;
}


#pragma mark  - 调整视图
-(void)updateWithFaceRect:(CGRect)faceRect Text:(NSString *)text{
  dispatch_async(dispatch_get_main_queue(), ^{
      [UIView animateWithDuration:0.2 animations:^{
          self.detailsView.detailsLable.text = text;
          self.detailsView.alpha = 1.0;
          self.detailsView.frame = faceRect;
      }];
  });
}



-(UIImage *)sampleBufferToImage:(CMSampleBufferRef)sampleBuffer{
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:imageBuffer];
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef videoImage = [temporaryContext createCGImage:ciImage fromRect:CGRectMake(0, 0, CVPixelBufferGetWidth(imageBuffer), CVPixelBufferGetHeight(imageBuffer))];
    UIImage *result = [[UIImage alloc] initWithCGImage:videoImage scale:1.0 orientation:UIImageOrientationLeftMirrored];
    CGImageRelease(videoImage);
    
    return result;
    
}

#pragma mark - 调整原始数据
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
