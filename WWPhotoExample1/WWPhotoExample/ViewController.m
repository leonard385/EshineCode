//
//  ViewController.m
//  WWPhotoExample
//
//  Created by eshine on 16/7/12.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+WWPhoto.h"
#import "WWPhotoModel.h"

#define WeakSelf() __weak typeof(self) weakself= self

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *imageBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)photoBtnClick:(UIButton *)sender {
    WeakSelf();
    //打开相机或相册
    [self setOpenCamreBlock:^{
        [weakself OpenCamera];
        
    } OpenPhotoBlock:^(NSUInteger PhotoNum) {
        
        [weakself MMSOPenPotoLib];

    }];
    
    //返回选择的图片
    self.photoBlock = ^(UIImage *image){
        NSInteger count = [WWPhotoModel shareMannager].photoArray.count;
        NSLog(@"s:%ld",count);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.imageView.image = image;
        });
    };
    
//    YXPhotoBroswerViewController *photoBroswerVC = [YXPhotoBroswerViewController new];
//    photoBroswerVC.imageViewArrs = self.photosArray;
//    [self presentViewController:photoBroswerVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
