//
//  LYLayoutPriorityDemoController.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/24.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYLayoutPriorityDemoController.h"

@interface LYLayoutPriorityDemoController ()
@property(nonatomic,strong)UIView *blueView;
@property(nonatomic,strong)UIView *purpleView;
@end

@implementation LYLayoutPriorityDemoController

-(UIView *)blueView{
    if(_blueView == nil){
        _blueView = [UIView new];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

-(UIView *)purpleView{
    if(_purpleView == nil){
        _purpleView = [UIView new];
        _purpleView.backgroundColor = [UIColor purpleColor];
    }
    return _purpleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LPSetUpSubviews];
}

-(void)LPSetUpSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.purpleView];
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(20.0f);
        make.left.mas_equalTo(self.view).with.offset(20.0f);
        make.bottom.mas_equalTo(self.view).with.offset(-20.0f);
        make.width.mas_greaterThanOrEqualTo(150.0f);
    }];
    
    [_purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_blueView);
        make.width.mas_equalTo(_blueView).with.multipliedBy(2).priorityHigh();
        make.left.mas_equalTo(_blueView.mas_right).with.offset(8.0f);
        make.right.mas_equalTo(self.view).with.offset(-20.0f);
    }];
    
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
