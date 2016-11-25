//
//  MainViewController.m
//  ChangeOrientation
//
//  Created by Harvey on 16/6/6.
//  Copyright © 2016年 Haley. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "MainViewController.h"

@interface MainViewController ()<UIWebViewDelegate>

@property (strong, nonatomic)   UIWebView            *webView;  /**< webView */

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主页";
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"竖屏" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"横屏" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSString *url = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)leftAction
{
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}

- (void)rightAction
{
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"share"]) {
        NSArray *params =[url.query componentsSeparatedByString:@"&"];
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (NSString *paramStr in params) {
            NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
            if (dicArray.count > 1) {
                NSString *decodeValue = [dicArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [tempDic setObject:decodeValue forKey:dicArray[0]];
            }
        }
        NSLog(@"tempDict:%@",tempDic);
        return NO;
    } else if ([[url scheme] isEqualToString:@"portrait"]) {
        NSLog(@"currentThread:%@",[NSThread currentThread]);
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
        return NO;
    } else if ([[url scheme] isEqualToString:@"landscape"]) {
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        return NO;
    }
    
    return YES;
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


@end
