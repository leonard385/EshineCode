//
//  MMTrainViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainViewController.h"

@interface MMTrainViewController ()

@end

@implementation MMTrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TVSetUpNavItem];
    // Do any additional setup after loading the view.
}

-(void)TVSetUpNavItem{
    
    UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    filterBtn.frame = CGRectMake(0, 0, 20, 20);
    [filterBtn setBackgroundImage:[UIImage imageNamed:@"nav_saixuan"] forState:UIControlStateNormal];
    [filterBtn.imageView setContentMode:UIViewContentModeCenter];
    [filterBtn addTarget:self action:@selector(TVfilterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *filterBtnItem = [[UIBarButtonItem alloc] initWithCustomView:filterBtn];
    self.navigationItem.rightBarButtonItem = filterBtnItem;
    
}

#pragma mark - 筛选点击
-(void)TVfilterBtnClick{
  
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
