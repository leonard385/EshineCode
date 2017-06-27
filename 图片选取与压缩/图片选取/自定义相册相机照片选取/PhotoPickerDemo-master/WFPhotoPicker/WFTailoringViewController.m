//
//  WFTailoringViewController.m
//  WFPhotoPicker
//
//  Created by 赚发2 on 16/9/2.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import "WFTailoringViewController.h"
#import <Photos/Photos.h>
#import "WFPhotoAlbum.h"

static CGFloat rectWidth = 300;
static CGFloat rectHeight = 180;

@interface WFTailoringViewController ()
//原图imageView
@property (nonatomic, strong) UIImageView *tailorImageView;
//image
@property (nonatomic, strong) UIImage *showImage;

@end

@implementation WFTailoringViewController

#pragma mark - UIViewController life cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self private_setupViews];
    [self private_showImage];
}

#pragma mark - event response -
- (void)panAction:(UIPanGestureRecognizer *)panGesture{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    CGPoint translation = [panGesture translationInView:panGesture.view.superview];
    panGesture.view.center = CGPointMake(panGesture.view.center.x + translation.x,
                                         panGesture.view.center.y + translation.y);
    [panGesture setTranslation:CGPointZero inView:panGesture.view.superview];
    //不能上出选择框
    if (panGesture.view.frame.origin.x >= (width - rectWidth ) / 2){
        panGesture.view.frame = CGRectMake((width - rectWidth ) / 2, panGesture.view.frame.origin.y, panGesture.view.frame.size.width, panGesture.view.frame.size.height);
    };
    //不能右出选择框
    if (panGesture.view.frame.origin.y >= (height - rectHeight) / 2) {
        panGesture.view.frame = CGRectMake(panGesture.view.frame.origin.x, (height - rectHeight) / 2, panGesture.view.frame.size.width, panGesture.view.frame.size.height);
    }
    CGFloat scaleH = panGesture.view.frame.size.height;
    //不能下出选择框
    if (panGesture.view.frame.origin.y <= -(scaleH - (height - rectHeight) / 2 - rectHeight)) {
        panGesture.view.frame = CGRectMake(panGesture.view.frame.origin.x, -(scaleH - (height - rectHeight) / 2 - rectHeight) ,panGesture.view.frame.size.width, panGesture.view.frame.size.height);
    }
    CGFloat scaleW = panGesture.view.frame.size.width;
    //不能右出选择框
    if (panGesture.view.frame.origin.x <= -(scaleW - (width - rectWidth) / 2 - rectWidth)) {
        panGesture.view.frame = CGRectMake(-(scaleW - (width - rectWidth) / 2 - rectWidth), panGesture.view.frame.origin.y, panGesture.view.frame.size.width, panGesture.view.frame.size.height);
    }
}

- (void)pinchAction:(UIPinchGestureRecognizer *)pinchGesture{

    pinchGesture.view.transform = CGAffineTransformScale(pinchGesture.view.transform, pinchGesture.scale, pinchGesture.scale);
    //确保不能放大过大或过小
    //2D 矩阵:ad缩放bc旋转tx,ty位移
    //规则:x=ax+cy+tx
    //    y=bx+dy+ty
    if (pinchGesture.view.transform.a > 1.5) {
        CGAffineTransform transform = pinchGesture.view.transform;
        transform.a = 1.5;
        transform.d = 1.5;
        pinchGesture.view.transform = transform;
    }
    if (pinchGesture.view.transform.a < 0.80) {
        CGAffineTransform transform = pinchGesture.view.transform;
        transform.a = 0.80;
        transform.d = 0.80;
        pinchGesture.view.transform = transform;
    }
    pinchGesture.scale = 1;
}

- (void)sureSelectedImage:(UIButton *)sender{
    UIImage *image = [self private_captureImageFromView:self.view];
    _tailoredImage ? _tailoredImage(image) : nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private methods -
- (void)private_setupViews{
    self.view.backgroundColor = [UIColor blackColor];
    //选择图片
    _tailorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    _tailorImageView.userInteractionEnabled = YES;
    [self.view addSubview:_tailorImageView];
    //选择框
    [self private_setupBoxLayer];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [_tailorImageView addGestureRecognizer:panGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [_tailorImageView addGestureRecognizer:pinchGesture];
    //底部视图
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    [self.view addSubview:toolView];
    toolView.backgroundColor = [UIColor whiteColor];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(self.view.frame.size.width - 80, 5, 60, 40);
    sureButton.backgroundColor = [UIColor colorWithRed:110 / 255.0 green:204 / 255.0 blue:245 / 255.0 alpha:1];
    [sureButton setTitle:@"确定" forState: UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureSelectedImage:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.layer.cornerRadius = 5;
    sureButton.layer.masksToBounds = YES;
    [toolView addSubview:sureButton];
    
}

- (void)private_setupBoxLayer{
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    [self private_addShapeLayerWithFrame:CGRectMake(0, 0, width, (height - rectHeight) / 2)
                     strokeColor:[UIColor clearColor]
                       fillColor:[UIColor colorWithWhite:0.2 alpha:0.2]];
    [self private_addShapeLayerWithFrame:CGRectMake(0, (height - rectHeight) / 2, (width - rectWidth) / 2, rectHeight)
                     strokeColor:[UIColor clearColor]
                       fillColor:[UIColor colorWithWhite:0.2 alpha:0.2]];
    [self private_addShapeLayerWithFrame:CGRectMake(0, height /  2 + rectHeight / 2, width, height / 2 - rectHeight /  2)
                     strokeColor:[UIColor clearColor]
                       fillColor:[UIColor colorWithWhite:0.2 alpha:0.2]];
    [self private_addShapeLayerWithFrame:CGRectMake((width - rectWidth) / 2 + rectWidth, height / 2 - rectHeight / 2 , width - rectWidth - (width - rectWidth) /  2, rectHeight)
                     strokeColor:[UIColor clearColor]
                       fillColor:[UIColor colorWithWhite:0.2 alpha:0.2]];
    [self private_addShapeLayerWithFrame:CGRectMake((width - rectWidth) / 2, height / 2 - rectHeight / 2, rectWidth, rectHeight)
                     strokeColor:[UIColor lightGrayColor]
                       fillColor:[UIColor clearColor]];
}
- (void)private_addShapeLayerWithFrame:(CGRect)frame
                   strokeColor:(UIColor *)strokeColor
                     fillColor:(UIColor *)fillColor{
    UIBezierPath *rectRangePath = [UIBezierPath bezierPathWithRect:frame];
    rectRangePath.lineWidth = 1;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:shapeLayer above:_tailorImageView.layer];
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.fillColor = fillColor.CGColor;
    shapeLayer.path = rectRangePath.CGPath;
}

- (void)private_showImage{ 
    [[WFPhotoAlbum standarWFPhotosAlbum] getPhotosWithAsset:_asset
                                              originalImage:YES
                                                 completion:^(UIImage *image) {
        CGFloat height = _tailorImageView.frame.size.width * image.size.height / image.size.width;
        _tailorImageView.frame = CGRectMake(0, 0, _tailorImageView.frame.size.width, height);
        _tailorImageView.center = self.view.center;
        _tailorImageView.image = image;
    }];
}

- (UIImage *)private_captureImageFromView:(UIView *)view{
    CGRect screenRect = CGRectMake((self.view.frame.size.width - rectWidth) / 2,
                                   (self.view.frame.size.height - rectHeight) / 2,
                                   rectWidth,
                                   rectHeight);
    UIGraphicsBeginImageContextWithOptions(screenRect.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL){
        return nil;
    }
    //copy 一份图形上下位文,用来操作
    CGContextSaveGState(context);
    //将当前图行位文进行矩阵变换
    CGContextTranslateCTM(context, -screenRect.origin.x, -screenRect.origin.y);
    
    if( [view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
        //捕捉当前快照
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    }else{
        //layer 层渲染
        [view.layer renderInContext:context];
    }
    //图形位文退出栈
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
