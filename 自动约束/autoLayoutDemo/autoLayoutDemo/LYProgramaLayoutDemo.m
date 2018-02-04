//
//  LYProgramaLayoutDemo.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/31.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYProgramaLayoutDemo.h"
#import "LYLayoutAnchorsDemo.h"
#import "LYLayoutConstraintDemo.h"
#import "LYVisualFormatDemo.h"
@interface LYProgramaLayoutDemo ()

@end

@implementation LYProgramaLayoutDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)LayoutAnchorClick:(id)sender {
    LYLayoutAnchorsDemo *vc = [LYLayoutAnchorsDemo new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnLayoutContraintClick:(id)sender {
    LYLayoutConstraintDemo *vc = [LYLayoutConstraintDemo new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)visalLauClick:(id)sender {
    LYVisualFormatDemo *vfVc = [LYVisualFormatDemo new];
    [self.navigationController pushViewController:vfVc animated:YES];
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
