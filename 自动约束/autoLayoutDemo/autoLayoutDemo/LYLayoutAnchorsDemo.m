
//
//  LYLayoutAnchorsDemo.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/31.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYLayoutAnchorsDemo.h"

@interface LYLayoutAnchorsDemo ()
@property(nonatomic,strong)UIView *viewRed;
@property(nonatomic,strong)UIView *viewBlue;
@property(nonatomic,strong)UIView *viewGreen;
@end

@implementation LYLayoutAnchorsDemo
-(UIView *)viewRed{
    if(_viewRed == nil){
        _viewRed = [UIView new];
        _viewRed.backgroundColor = [UIColor redColor];
        _viewRed.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _viewRed;
}

-(UIView *)viewBlue{
    if(_viewBlue == nil){
        _viewBlue = [UIView new];
        _viewBlue.backgroundColor = [UIColor blueColor];
        _viewBlue.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _viewBlue;
}

-(UIView *)viewGreen{
    if(_viewGreen == nil){
        _viewGreen = [UIView new];
        _viewGreen.backgroundColor = [UIColor greenColor];
        _viewGreen.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _viewGreen;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"LYLayoutAnchorsDemo";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LASetUpSubviews];
}

- (void)LASetUpSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewRed];
    [self.view addSubview:self.viewBlue];
    [self.view addSubview:self.viewGreen];
    
    UILayoutGuide *margin = self.view.layoutMarginsGuide;
    [self.viewRed.topAnchor constraintEqualToAnchor:margin.topAnchor constant:16.0f].active = YES;
    [self.viewRed.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = YES;
    [self.viewRed.trailingAnchor constraintEqualToAnchor:margin.trailingAnchor].active = YES;
    [self.viewRed.widthAnchor constraintEqualToAnchor:self.viewRed.heightAnchor multiplier:16.0f/9.0f].active = YES;
    
    [self.viewBlue.topAnchor constraintEqualToAnchor:self.viewRed.bottomAnchor constant:20.0f].active = YES;
    [self.viewBlue.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = YES;
    [self.viewBlue.heightAnchor constraintEqualToConstant:110.0f].active = YES;
    [self.viewGreen.leadingAnchor constraintEqualToAnchor:self.viewBlue.trailingAnchor constant:8.0f].active = YES;
    [self.viewGreen.trailingAnchor constraintEqualToAnchor:margin.trailingAnchor].active = YES;
    [self.viewGreen.topAnchor constraintEqualToAnchor:self.viewBlue.topAnchor].active = YES;
    [self.viewGreen.bottomAnchor constraintEqualToAnchor:self.viewBlue.bottomAnchor].active = YES;
    [self.viewGreen.widthAnchor constraintEqualToAnchor:self.viewBlue.widthAnchor multiplier:1].active = YES;
   
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
