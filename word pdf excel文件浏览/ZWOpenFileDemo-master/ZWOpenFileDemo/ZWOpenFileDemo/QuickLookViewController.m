//
//  QuickLookViewController.m
//  ZWOpenFileDemo
//
//  Created by 郑亚伟 on 2017/3/2.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "QuickLookViewController.h"
#import <QuickLook/QuickLook.h>

@interface QuickLookViewController ()<QLPreviewControllerDataSource,
QLPreviewControllerDelegate>
@property (nonatomic,strong) QLPreviewController *previewController;
@end

@implementation QuickLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"附件预览";
    _previewController = [[QLPreviewController alloc] init];
    _previewController.dataSource = self;
    _previewController.delegate = self;
    
    _previewController.view.frame = CGRectMake(0, 64, self.view.frame.size.width , self.view.frame.size.height);
    //_previewController.currentPreviewItemIndex = 2;
    [self addChildViewController:_previewController];
    [self.view addSubview:_previewController.view];
    [_previewController reloadData];
}

#pragma mark -代理方法
- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index{
    return self.fileURL;
}
//必须实现
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}


@end
