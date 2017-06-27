//
//  ViewController.m
//  WFPhotoPicker
//
//  Created by 赚发2 on 16/9/2.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import "ViewController.h"
#import "WFPhotosViewController.h"
#import "WBSPopShareView.h"

static CGFloat rectWidth = 300;
static CGFloat rectHeight = 180;

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
#pragma mark - UIViewController life cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - event reponse -
- (IBAction)choosePhotoStype:(id)sender {
    WBSPopShareView *popShareView = [[WBSPopShareView alloc] initWithFrameWithFrame:self.view.frame images:@[@"photo",@"camera",@"cancle"] titles:@[@"相册",@"相册",@"取消"]];
    [self.navigationController.view addSubview:popShareView];
    
    popShareView.handleShareBlock = ^ (UIButton *sender){
        if (sender.tag == 100) {
            UIImageWriteToSavedPhotosAlbum([[UIImage alloc] init], nil, nil, nil);
            
            WFPhotosViewController *photosVC = [[WFPhotosViewController alloc] init];
            UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:photosVC];
            photosVC.tailoredImage = ^ (UIImage *image){
                _imageView.image = image;
            };
            [self presentViewController:naviVC animated:YES completion:nil];
        }else if (sender.tag == 101){
            [self creatImagePickVCWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
    };
}
#pragma mark - private methods -
- (UIImagePickerController *)creatImagePickVCWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    
    UIImagePickerController *imagePickVC = [[UIImagePickerController alloc]init];
    
    //设置选取的照片是否可编辑
    imagePickVC.allowsEditing = YES;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"模拟器无法打开相机");
            return nil;
        }
    }
    //设置相册呈现的样式
    imagePickVC.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePickVC.delegate = self;
    
    [self.navigationController presentViewController:imagePickVC animated:YES completion:^{
    }];
    return imagePickVC;
}

//裁剪图片,此处裁剪为125*125大的图,即为我们的缩略图
- (UIImage *)wf_thumbnailsCutfullPhoto:(UIImage*)image
{
     CGSize newSize;
     CGImageRef imageRef = nil;

     if ((image.size.width / image.size.height) < (rectWidth / rectHeight)) {
         newSize.width = image.size.width;
         newSize.height = image.size.width * rectHeight / rectWidth;

         imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
     } else {
         newSize.height = image.size.height;
         newSize.width = image.size.height * rectWidth / rectHeight;

        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    }
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
     return img;
}

#pragma mark - UIImagePickerControllerDelegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //裁剪后的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.image = [self wf_thumbnailsCutfullPhoto:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消按钮的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
