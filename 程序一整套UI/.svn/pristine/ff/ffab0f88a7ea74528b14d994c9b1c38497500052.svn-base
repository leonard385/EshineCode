//
//  MMWorkViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkViewController.h"

@interface MMWorkViewController ()

@end

@implementation MMWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self WMSetUpNavItem];
    // Do any additional setup after loading the view.
}

-(void)WMSetUpNavItem{
    
    UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    filterBtn.frame = CGRectMake(0, 0, 20, 20);
    [filterBtn setBackgroundImage:[UIImage imageNamed:@"nav_saixuan"] forState:UIControlStateNormal];
    [filterBtn.imageView setContentMode:UIViewContentModeCenter];
    [filterBtn addTarget:self action:@selector(WMfilterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *filterBtnItem = [[UIBarButtonItem alloc] initWithCustomView:filterBtn];
    self.navigationItem.rightBarButtonItem = filterBtnItem;
    
}

#pragma mark - 筛选点击
-(void)WMfilterBtnClick{
    
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
