//
//  LYIntrinsicSizeDemoController.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/22.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYIntrinsicSizeDemoController.h"
#import "LYSizeToFitIntrinsicSize.h"
@interface LYIntrinsicSizeDemoController ()
@property (weak, nonatomic) IBOutlet UIButton *btnLike;

@property(nonatomic,strong)LYSizeToFitIntrinsicSize *fitView;
@end

@implementation LYIntrinsicSizeDemoController
-(LYSizeToFitIntrinsicSize *)fitView{
    if(_fitView == nil){
        _fitView = [LYSizeToFitIntrinsicSize new];
        _fitView.backgroundColor = [UIColor redColor];
    }
    return _fitView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self ISSetUpSubviews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(ISReloadFitView) withObject:nil afterDelay:1];
}

-(void)ISSetUpSubviews{
    [self.view addSubview:self.fitView];
    [_fitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnLike.mas_bottom).with.offset(10.0f);
        make.right.mas_equalTo(_btnLike);
        make.left.mas_equalTo(self.view).with.offset(10.0f);
    }];
}

-(void)ISReloadFitView{

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
