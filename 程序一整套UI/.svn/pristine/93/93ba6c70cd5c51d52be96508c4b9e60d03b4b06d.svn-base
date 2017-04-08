//
//  MMMessageViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/6.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMMessageViewController.h"

@interface MMMessageViewController ()

@end

@implementation MMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self MVSetUpNavItem];
    // Do any additional setup after loading the view.
}

-(void)MVSetUpNavItem{
    
    UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    filterBtn.frame = CGRectMake(0, 0, 20, 20);
    [filterBtn setBackgroundImage:[UIImage imageNamed:@"nav_tianjiaqunzu"] forState:UIControlStateNormal];
    [filterBtn.imageView setContentMode:UIViewContentModeCenter];
    [filterBtn addTarget:self action:@selector(MVaddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *filterBtnItem = [[UIBarButtonItem alloc] initWithCustomView:filterBtn];
    self.navigationItem.rightBarButtonItem = filterBtnItem;
    
}

#pragma mark - 筛选点击
-(void)MVaddBtnClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
