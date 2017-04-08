//
//  CSRootViewController.m
//  ComplainSYS
//
//  Created by 逸信Mac on 16/5/5.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "CSRootViewController.h"
#import "QJCheckVersionUpdate.h"

@interface CSRootViewController ()

@end

@implementation CSRootViewController
-(instancetype)init
{
    self = [super init];
    if(self){
        self.title = @"湛江投诉管理系统";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //Appstore版本检查
    [self performSelector:@selector(RVCheckVersion) withObject:nil afterDelay:0.8f];
    // Do any additional setup after loading the view.
}


#pragma mark - 版本检查
-(void)RVCheckVersion
{
    QJCheckVersionUpdate *Version = [[QJCheckVersionUpdate alloc]init];
    [Version showAlertView];
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
