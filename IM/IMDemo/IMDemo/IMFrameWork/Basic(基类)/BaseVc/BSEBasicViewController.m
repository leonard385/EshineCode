//
//  BSEBasicViewController.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/3.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "BSEBasicViewController.h"

@interface BSEBasicViewController ()

@end

@implementation BSEBasicViewController

-(instancetype)init
{
    self = [super init];
    if(self){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self BNSetUpNavItem];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)BNSetUpNavItem
{
    UIButton *LeftItem = [UIButton buttonWithType:UIButtonTypeSystem];
    LeftItem.frame = CGRectMake(0, 0, 25, 25);
    [LeftItem setBackgroundImage:[UIImage imageNamed:@"a3"] forState:UIControlStateNormal];
    [LeftItem addTarget:self action:@selector(BNNavBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customLeftItem = [[UIBarButtonItem alloc] initWithCustomView:LeftItem];
//    [LeftItem setTag:LeftNavTag];
    self.navigationItem.leftBarButtonItem = customLeftItem;
}

-(void)BNNavBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
