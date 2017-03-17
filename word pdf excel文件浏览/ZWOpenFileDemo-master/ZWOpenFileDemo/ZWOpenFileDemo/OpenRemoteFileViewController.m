//
//  OpenRemoteFileViewController.m
//  ZWOpenFileDemo
//
//  Created by 郑亚伟 on 2017/3/3.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "OpenRemoteFileViewController.h"
#import <QuickLook/QuickLook.h>

@interface OpenRemoteFileViewController ()<UIWebViewDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property(nonatomic,strong)UIWebView *openFileWebView;

@property (nonatomic,strong)NSURL *fileURL;

@property (nonatomic,strong) QLPreviewController *qlVC;
@end

@implementation OpenRemoteFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _openFileWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 0)];
    _openFileWebView.delegate = self;
    _openFileWebView.backgroundColor = [UIColor cyanColor];
    [_openFileWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.fileURLString]]];
}
#pragma mark - private
- (NSString *)documentsDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return documentsDirectoryPath;
}


#pragma mark - webView代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网络加载");
    NSURL *targetURL = [NSURL URLWithString:self.fileURLString];
    NSString *docPath = [self documentsDirectoryPath];
    NSString *pathToDownloadTo = [NSString stringWithFormat:@"%@/%@", docPath, [targetURL lastPathComponent]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //是否已经下载
    BOOL hasDownLoad= [fileManager fileExistsAtPath:pathToDownloadTo];
    if (hasDownLoad) {
        NSLog(@"下载过了");
        self.fileURL = [NSURL fileURLWithPath:pathToDownloadTo];
        _qlVC = [[QLPreviewController alloc]init];
        _qlVC.delegate = self;
        _qlVC.dataSource = self;
//        _qlVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width , self.view.frame.size.height);
//        [self addChildViewController:_qlVC];
//        [self.view addSubview:_qlVC.view];
//        [_qlVC reloadData];
//        [self.navigationController pushViewController:_qlVC animated:NO];
        [self presentViewController:_qlVC animated:NO completion:nil];
    }else {
        NSLog(@"没下载过");
        NSURL *targetURL = [NSURL URLWithString:self.fileURLString];
        NSData *fileData = [[NSData alloc] initWithContentsOfURL:targetURL];
       
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        [fileData writeToFile:[NSString stringWithFormat:@"%@/%@", documentsDirectory, [targetURL lastPathComponent]] atomically:YES];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [_openFileWebView loadRequest:request];
    }
}


#pragma mark - QLPreviewController代理
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.fileURL;
}
- (void)previewControllerWillDismiss:(QLPreviewController *)controller{
    [self.navigationController popViewControllerAnimated:NO];
}
//- (void)previewControllerDidDismiss:(QLPreviewController *)controller{
//    [self.navigationController popViewControllerAnimated:NO];
//}

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item{
    return YES;
}
- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id <QLPreviewItem>)item inSourceView:(UIView * __nullable * __nonnull)view{
    return CGRectZero;
}

@end
