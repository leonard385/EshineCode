//
//  ViewController.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/9.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "ViewController.h"
#import "LYStatckViewDemoController.h"
#import "LYStackDynamicController.h"
#import "LYIntrinsicSizeDemoController.h"
#import "LYBaseLayoutDemoController.h"
#import "LYLayoutPriorityDemoController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnStackviewClivk:(id)sender {
    LYStatckViewDemoController *stVc = [[LYStatckViewDemoController alloc]initWithNibName:@"LYStatckViewDemoController" bundle:nil];
    [self.navigationController pushViewController:stVc animated:YES];
}

- (IBAction)btnCodeStackClick:(id)sender {
    LYStackDynamicController *stackVc = [LYStackDynamicController new];
    [self.navigationController pushViewController:stackVc animated:YES];
}

- (IBAction)btnSizeClick:(id)sender {
    LYIntrinsicSizeDemoController *isVc = [[LYIntrinsicSizeDemoController alloc]initWithNibName:@"LYIntrinsicSizeDemoController" bundle:nil];
    [self.navigationController pushViewController:isVc animated:YES];
}

- (IBAction)btnAutoLayoutClick:(id)sender {
    
}
- (IBAction)btnDemoClick:(id)sender {
    LYLayoutPriorityDemoController *vc = [LYLayoutPriorityDemoController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
