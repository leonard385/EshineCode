//
//  MMEmployeeViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/13.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployeeViewController.h"
#import "MMEmployStatisticViewController.h"
#import "MMEmployMannagerViewController.h"
@interface MMEmployeeViewController ()
@property(nonatomic,strong)UIButton *editNavBtn;
@property(nonatomic,strong)UIButton *filterNavBtn;
@end

@implementation MMEmployeeViewController

-(UIButton *)editNavBtn{
    if(_editNavBtn == nil){
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        editBtn.frame = CGRectMake(0, 0, 39, 26);
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [editBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(EMFuncBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _editNavBtn = editBtn;
        _editNavBtn.hidden = YES;
    }
    return _editNavBtn;
}

-(UIButton *)filterNavBtn{
    if(_filterNavBtn == nil){
        UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        filterBtn.frame = CGRectMake(0, 0, 20, 20);
        [filterBtn setBackgroundImage:[UIImage imageNamed:@"nav_saixuan"] forState:UIControlStateNormal];
        [filterBtn.imageView setContentMode:UIViewContentModeCenter];
        [filterBtn addTarget:self action:@selector(EMfilterBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _filterNavBtn = filterBtn;
        _filterNavBtn.hidden = YES;
    }
    return _filterNavBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self EVSetUpNavItems];
    // Do any additional setup after loading the view.
}

-(void)EVSetUpNavItems{
  UIBarButtonItem *rightItemEdit = [[UIBarButtonItem alloc] initWithCustomView:self.editNavBtn];
  UIBarButtonItem *filterBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.filterNavBtn];

   self.navigationItem.rightBarButtonItems = @[filterBtnItem,rightItemEdit];
}

#pragma mark  - 编辑
-(void)EMFuncBtnClick:(UIButton *)sender{
    NSString *btnString = sender.titleLabel.text;
    if([btnString isEqualToString:@"编辑"]){
        NSDictionary *info = [NSDictionary dictionaryWithObject:@(1) forKey:kMemberEditIsEdit];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMemberEditNotice object:nil userInfo:info];
        [sender setTitle:@"取消" forState:UIControlStateNormal];
    }else if([btnString isEqualToString:@"取消"]){
        NSDictionary *info = [NSDictionary dictionaryWithObject:@(0) forKey:kMemberEditIsEdit];
        [[NSNotificationCenter defaultCenter]postNotificationName:kMemberEditNotice object:nil userInfo:info];
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
}

-(void)EMfilterBtnClick{
     [[NSNotificationCenter defaultCenter]postNotificationName:kMemberFilterNotice object:nil];
}

-(void)currentVCWillChangeTo:(NSUInteger)idex controller:(UIViewController *)vc{
    if([vc isKindOfClass:[MMEmployMannagerViewController class]]){
        _editNavBtn.hidden = NO;
        _filterNavBtn.hidden = NO;
    }else{
        _editNavBtn.hidden = YES;
        _filterNavBtn.hidden = YES;
    }
}

-(void)currentVCDidChangeTo:(NSUInteger)idex controller:(UIViewController *)vc{
  
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
