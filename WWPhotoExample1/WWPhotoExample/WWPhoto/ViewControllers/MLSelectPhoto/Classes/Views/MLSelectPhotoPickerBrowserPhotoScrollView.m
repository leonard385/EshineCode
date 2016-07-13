//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  ZLPhotoPickerBrowserPhotoScrollView.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-14.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "MLSelectPhotoPickerBrowserPhotoScrollView.h"
#import "MLSelectPhotoPickerDatas.h"
#import "MLSelectPhotoCommon.h"
#import "UIView+MLExtension.h"

// Private methods and properties
@interface MLSelectPhotoPickerBrowserPhotoScrollView ()<UIActionSheetDelegate> {
    MLSelectPhotoPickerBrowserPhotoView *_tapView; // for background taps
    MLSelectPhotoPickerBrowserPhotoImageView *_photoImageView;
}

@property (assign,nonatomic) BOOL isHiddenShowSheet;

@end

@implementation MLSelectPhotoPickerBrowserPhotoScrollView

- (id)init{
    if ((self = [super init])) {
        
        // Setup
        // Tap view for background
        _tapView = [[MLSelectPhotoPickerBrowserPhotoView alloc] initWithFrame:self.bounds];
        _tapView.tapDelegate = self;
        _tapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tapView.backgroundColor = [UIColor blackColor];
        [self addSubview:_tapView];
        
        // Image view
        _photoImageView = [[MLSelectPhotoPickerBrowserPhotoImageView alloc] initWithFrame:CGRectZero];
        _photoImageView.tapDelegate = self;
        _photoImageView.contentMode = UIViewContentModeCenter;
        _photoImageView.backgroundColor = [UIColor blackColor];
        [self addSubview:_photoImageView];
        
        // Setup
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
        [self addGestureRecognizer:longGesture];
    }
    return self;
}

- (void)setSheet:(UIActionSheet *)sheet{
    _sheet = sheet;
    if (!sheet) {
        self.isHiddenShowSheet = sheet;
    }
}

- (void)longGesture:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        if (!self.isHiddenShowSheet) {
            self.sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存到相册" otherButtonTitles:nil, nil];
        }
        
        if (!self.isHiddenShowSheet) {
            [self.sheet showInView:self];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            UIImageWriteToSavedPhotosAlbum(_photoImageView.image, nil, nil, nil);
            if (_photoImageView.image) {
                [self showMessageWithText:@"保存成功"];
            }
        }else{
            if (_photoImageView.image) {
                [self showMessageWithText:@"没有用户权限,保存失败"];
            }
        }
    }
}

- (void)dealloc {
    self.isHiddenShowSheet = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPhoto:(MLSelectPhotoAssets *)photo{
    _photo = photo;
    
    if ([photo isKindOfClass:[UIImage class]]) {
        _photoImageView.image = (UIImage *)photo;
        [self displayImage];
    }else if (photo.originImage){
        _photoImageView.image = photo.originImage;
        [self displayImage];
    }
}

#pragma mark - Image
// Get and display image
- (void)displayImage {
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    self.contentSize = CGSizeMake(0, 0);
    
    // Get image from browser as it handles ordering of fetching
    UIImage *img = _photoImageView.image;
    if (img) {
        
        // Set image
        _photoImageView.image = img;
        _photoImageView.hidden = NO;
        
        // Setup photo frame
        CGRect photoImageViewFrame;
        photoImageViewFrame.origin = CGPointZero;
        photoImageViewFrame.size = img.size;
        _photoImageView.frame = photoImageViewFrame;
        self.contentSize = photoImageViewFrame.size;
        
        // Set zoom to minimum zoom
        [self setMaxMinZoomScalesForCurrentBounds];
        
    }
    [self setNeedsLayout];
}

#pragma mark - Loading Progress
#pragma mark - Setup
//- (CGFloat)initialZoomScaleWithMinScale {
//    CGFloat zoomScale = self.minimumZoomScale;
//    if (_photoImageView) {
//        // Zoom image to fill if the aspect ratios are fairly similar
//        CGSize boundsSize = self.bounds.size;
//        CGSize imageSize = _photoImageView.image.size;
//        CGFloat boundsAR = boundsSize.width / boundsSize.height;
//        CGFloat imageAR = imageSize.width / imageSize.height;
//        CGFloat xScale = boundsSize.width / imageSize.width;
//
//        if (ABS(boundsAR - imageAR) < 0.17) {
//            zoomScale = xScale;
//        }
//    }
//    return zoomScale;
//}

- (void)setMaxMinZoomScalesForCurrentBounds {
    
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    
    // Bail if no image
    if (_photoImageView.image == nil) return;
    
    // Reset position
    _photoImageView.frame = CGRectMake(0, 0, _photoImageView.frame.size.width, _photoImageView.frame.size.height);
    
    // Sizes
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = _photoImageView.image.size;
    
    // Calculate Min
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    // Calculate Max
    CGFloat maxScale = 3;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Let them go a bit bigger on a bigger screen!
        maxScale = 4;
    }
    
    // Image is smaller than screen so no zooming!
    if (xScale >= 1 && yScale >= 1) {
        minScale = MIN(xScale, yScale);
    }
    
    if (minScale >= 3) {
        minScale = 1;
    }
    
    // Set min/max zoom
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    
    // Initial zoom
    self.zoomScale = minScale;
    
    // If we're zooming to fill then centralise
    if (self.zoomScale != minScale) {
        // Centralise
        self.contentOffset = CGPointMake((imageSize.width * self.zoomScale - boundsSize.width) / 2.0,
                                         (imageSize.height * self.zoomScale - boundsSize.height) / 2.0);
        // Disable scrolling initially until the first pinch to fix issues with swiping on an initally zoomed in photo
        self.scrollEnabled = NO;
    }
    
    // Layout
    [self setNeedsLayout];
    
}

#pragma mark - Layout

- (void)layoutSubviews {
    // Super
    [super layoutSubviews];
    
    // Center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _photoImageView.frame;
    
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    
    // Center
    if (!CGRectEqualToRect(_photoImageView.frame, frameToCenter))
        _photoImageView.frame = frameToCenter;
    
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _photoImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Tap Detection
- (void)handleDoubleTap:(CGPoint)touchPoint {
    
    // Zoom
    if (self.zoomScale != self.minimumZoomScale) {
        
        // Zoom out
        [self setZoomScale:self.minimumZoomScale animated:YES];
        self.contentSize = CGSizeMake(self.frame.size.width, 0);
    } else {
        
        // Zoom in to twice the size
        CGFloat newZoomScale = ((self.maximumZoomScale + self.minimumZoomScale) / 2);
        CGFloat xsize = self.bounds.size.width / newZoomScale;
        CGFloat ysize = self.bounds.size.height / newZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        
    }
    
}

- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch{
    [self disMissTap:nil];
}

#pragma mark - disMissTap
- (void) disMissTap:(UITapGestureRecognizer *)tap{
    if (self.callback){
        self.callback(nil);
    }else if ([self.photoScrollViewDelegate respondsToSelector:@selector(pickerPhotoScrollViewDidSingleClick:)]) {
        [self.photoScrollViewDelegate pickerPhotoScrollViewDidSingleClick:self];
    }
}

// Image View
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch {
    [self handleDoubleTap:[touch locationInView:imageView]];
}

- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch{
    [self disMissTap:nil];
}

- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch {
    // Translate touch location to image view location
    CGFloat touchX = [touch locationInView:view].x;
    CGFloat touchY = [touch locationInView:view].y;
    touchX *= 1/self.zoomScale;
    touchY *= 1/self.zoomScale;
    touchX += self.contentOffset.x;
    touchY += self.contentOffset.y;
    [self handleDoubleTap:CGPointMake(touchX, touchY)];
}

@end
