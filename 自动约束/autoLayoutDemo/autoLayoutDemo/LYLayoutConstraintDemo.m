//
//  LYLayoutConstraintDemo.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/31.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYLayoutConstraintDemo.h"

@interface LYLayoutConstraintDemo ()
@property(nonatomic,strong)UIView *viewBlue;
@property(nonatomic,strong)UIView *viewGreen;
@end

@implementation LYLayoutConstraintDemo
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
        self.title = @"LYLayoutConstraintDemo";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LASetUpSubviews];
}

-(void)LASetUpSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewBlue];
    [self.view addSubview:self.viewGreen];
    
    [NSLayoutConstraint constraintWithItem:self.viewBlue
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeadingMargin
                                multiplier:1.0f
                                  constant:0.0f].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.viewBlue
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailingMargin
                                multiplier:1.0f
                                  constant:0.0f].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.viewBlue
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTopMargin
                                multiplier:1.0f
                                  constant:16.0f].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.viewBlue
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.viewBlue
                                 attribute:NSLayoutAttributeHeight
                                multiplier:2.0f
                                  constant:0.0f].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.viewGreen
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.viewBlue
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0f
                                  constant:20.0f].active = YES;
    [NSLayoutConstraint constraintWithItem:self.viewGreen
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.viewBlue
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0f
                                  constant:0.0f].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.viewGreen
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                  constant:120.0f].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.viewGreen
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                  constant:90.0f].active = YES;

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
