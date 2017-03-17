//
//  ViewController.m
//  ZWOpenFileDemo
//
//  Created by 郑亚伟 on 2017/3/2.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ViewController.h"
#import "QuickLookViewController.h"
#import "OpenRemoteFileViewController.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate>
@property(nonatomic,strong)UIDocumentInteractionController *documentInteractionController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"本地打开方式一",@"本地打开方式二",@"远程打开"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(50, 100 + 60 * i, self.view.frame.size.width - 100,50);
        button.tag = i;
        [self.view addSubview:button];
    }
}

- (void)btnClick:(UIButton *)btn{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Reader" ofType:@"pdf"];
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    if (btn.tag == 0) {
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        self.documentInteractionController.delegate = self;
        [self.documentInteractionController presentPreviewAnimated:YES];
    }else if (btn.tag == 1){
        QuickLookViewController *quickLookVC = [[QuickLookViewController alloc]init];
        quickLookVC.fileURL = URL;
        [self.navigationController pushViewController:quickLookVC animated:YES];
    }else if (btn.tag == 2){
        OpenRemoteFileViewController *openRemoteFileVC =[[OpenRemoteFileViewController alloc]init];
        openRemoteFileVC.fileURLString = @"http://weixintest.ihk.cn/ihkwx_upload/1.pdf";
        [self.navigationController pushViewController:openRemoteFileVC animated:YES];
    }
}

#pragma mark -UIDocumentInteractionControllerDelegate代理方法
//这是必须实现的方法，否则不会显示
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}
//设置预览名称
- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller{
    controller.name = @"附件预览";
}
//点击Done结束预览
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller{
    
}



@end
