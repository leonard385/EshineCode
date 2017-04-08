//
//  MMKVStructMapViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/11.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKVStructMapViewController.h"

@interface MMKVStructMapViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *picScrollerView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIImageView *mapImageView;
@end

@implementation MMKVStructMapViewController
-(UIScrollView *)picScrollerView{
    if(_picScrollerView == nil){
        _picScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _picScrollerView.contentSize = CGSizeMake(self.view.width, self.view.height);
        _picScrollerView.delegate = self;
        _picScrollerView.showsVerticalScrollIndicator = NO;
        _picScrollerView.pagingEnabled = YES;
        _picScrollerView.bounces = NO;
    }
    return _picScrollerView;
}

-(UIImageView *)mapImageView{
    if(_mapImageView == nil){
        _mapImageView = [UIImageView new];
        [_mapImageView setContentMode:UIViewContentModeTop];
        _mapImageView.image = [UIImage imageNamed:@"jiegoutu"];
    }
    return _mapImageView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SMSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)SMSetUpSubviews{
    [self.view addSubview:self.picScrollerView];
    [self.picScrollerView addSubview:self.mapImageView];
    
    [_mapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.picScrollerView).with.insets(UIEdgeInsetsMake(12, 12, 12, 12));
        make.center.mas_equalTo(self.picScrollerView);
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
