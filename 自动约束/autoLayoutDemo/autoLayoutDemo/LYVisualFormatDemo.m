//
//  LYVisualFormatDemo.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/31.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYVisualFormatDemo.h"

@interface LYVisualFormatDemo ()
@property(nonatomic,strong)UIView *viewRed;
@end

@implementation LYVisualFormatDemo

- (UIView *)viewRed{
    if(_viewRed == nil){
        _viewRed = [UIView new];
        _viewRed.backgroundColor = [UIColor redColor];
        _viewRed.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _viewRed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self VFSetUpSubviews];
}

- (void)VFSetUpSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewRed];
    
//    NSDictionary *viewDic = [NSDictionary dictionaryWithObject:self.viewRed forKey:@"viewRed"];
    NSDictionary *viewDic = NSDictionaryOfVariableBindings(_viewRed);
    NSString *formatString = @"|-[viewRed]-|";
    NSArray *constraint = [NSLayoutConstraint constraintsWithVisualFormat:formatString
                                            options:NSLayoutFormatAlignAllTop
                                            metrics:nil
                                              views:viewDic];
    
    NSString *hFormatString = @"V:|-[viewRed(100)]";
    NSArray *vconstraint = [NSLayoutConstraint constraintsWithVisualFormat:hFormatString
                                                                  options:NSLayoutFormatAlignAllTop
                                                                  metrics:nil
                                                                    views:viewDic];
    [NSLayoutConstraint activateConstraints:constraint];
    [NSLayoutConstraint activateConstraints:vconstraint];
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
