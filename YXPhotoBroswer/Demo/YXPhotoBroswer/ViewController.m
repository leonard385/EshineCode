//
//  ViewController.m
//  YXPhotoBroswer
//
//  Created by 梅守强 on 16/7/7.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "ViewController.h"
#import "YXPhotoBroswerViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *imageViewArray = [NSMutableArray arrayWithObjects:_imageView1, _imageView2, nil];
    //传入imageView的数组即可
    YXPhotoBroswerViewController *photoBroswerVC = [YXPhotoBroswerViewController new];
    photoBroswerVC.imageViewArrs = imageViewArray;
    [self presentViewController:photoBroswerVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
