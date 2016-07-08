//
//  YXPhotoBroswerViewController.m
//  YXPhotoBroswer
//
//  Created by 梅守强 on 16/7/7.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "YXPhotoBroswerViewController.h"
#import "PhotoBroswerVC.h"

@interface YXPhotoBroswerViewController ()

@end

@implementation YXPhotoBroswerViewController

- (NSMutableArray *)imageViewArrs {
    if (!_imageViewArrs) {
        _imageViewArrs = [NSMutableArray array];
    }
    return _imageViewArrs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIImageView *imageView in self.imageViewArrs) {
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(show:)];
        //设置可以交互
        [imageView setUserInteractionEnabled:YES];
        //添加tag值
        imageView.tag = [self.imageViewArrs indexOfObject:imageView];
        [imageView addGestureRecognizer:tapGR];
    }
}

- (void)show:(UITapGestureRecognizer *)gr {
    [PhotoBroswerVC show:[self getCurrentVC] type:PhotoBroswerVCTypeZoom index:gr.view.tag photoModelBlock:^NSArray *{
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:self.imageViewArrs.count];
        for (NSUInteger i = 0; i< self.imageViewArrs.count; i++) {
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            //            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            //            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image = [self.imageViewArrs[i] image];
            //源frame
            pbModel.sourceImageView = self.imageViewArrs[i];
            [modelsM addObject:pbModel];
        }
        return modelsM;
    }];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
