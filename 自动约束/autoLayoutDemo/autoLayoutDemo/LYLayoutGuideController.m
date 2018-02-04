//
//  LYLayoutGuideController.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/25.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYLayoutGuideController.h"

@interface LYLayoutGuideController ()
@property(nonatomic,strong)UILayoutGuide *layoutGuideLed;
@property(nonatomic,strong)UIButton *btnShort;
@property(nonatomic,strong)UILayoutGuide *layoutGuideMid;
@property(nonatomic,strong)UIButton *btnLong;
@property(nonatomic,strong)UILayoutGuide *layoutGuideEnd;


@property(nonatomic,strong)UILayoutGuide *layoutGuideContent;
@property(nonatomic,strong)UILabel *labelLeft;
@property(nonatomic,strong)UILabel *labelRight;
@end

@implementation LYLayoutGuideController

-(UILayoutGuide *)layoutGuideLed{
    if(_layoutGuideLed == nil){
        _layoutGuideLed = [UILayoutGuide new];
    }
    return _layoutGuideLed;
}

-(UIButton *)btnShort{
    if(_btnShort == nil){
        _btnShort = [UIButton new];
        [_btnShort setTitle:@"Short" forState:UIControlStateNormal];
        [_btnShort.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_btnShort setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnShort setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _btnShort;
}

-(UILayoutGuide *)layoutGuideMid{
    if(_layoutGuideMid == nil){
        _layoutGuideMid = [UILayoutGuide new];
    }
    return _layoutGuideMid;
}

-(UIButton *)btnLong{
    if(_btnLong == nil){
        _btnLong = [UIButton new];
        [_btnLong setTitle:@"Short" forState:UIControlStateNormal];
        [_btnLong.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_btnLong setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnLong setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _btnLong;
}

-(UILayoutGuide *)layoutGuideEnd{
    if(_layoutGuideEnd == nil){
        _layoutGuideEnd = [UILayoutGuide new];
    }
    return _layoutGuideEnd;
}

-(UILayoutGuide *)layoutGuideContent{
    if(_layoutGuideContent == nil){
        _layoutGuideContent = [UILayoutGuide new];
    }
    return _layoutGuideContent;
}

-(UILabel *)labelLeft{
    if(_labelLeft == nil){
        _labelLeft = [UILabel new];
        [_labelLeft setFont:[UIFont systemFontOfSize:18.0f]];
        [_labelLeft setTextAlignment:NSTextAlignmentCenter];
        [_labelLeft setBackgroundColor:[UIColor redColor]];
        _labelLeft.text = @"left";
    }
    return _labelLeft;
}

-(UILabel *)labelRight{
    if(_labelRight == nil){
        _labelRight = [UILabel new];
        [_labelRight setFont:[UIFont systemFontOfSize:18.0f]];
        [_labelRight setTextAlignment:NSTextAlignmentCenter];
        [_labelRight setBackgroundColor:[UIColor blueColor]];
        _labelRight.text = @"right";
    }
    return _labelRight;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LGSetUpSubviews];
}

-(void)LGSetUpSubviews{
    [self.view addLayoutGuide:self.layoutGuideLed];
    [self.view addSubview:self.btnShort];
    [self.view addLayoutGuide:self.layoutGuideMid];
    [self.view addSubview:self.btnLong];
    [self.view addLayoutGuide:self.layoutGuideEnd];
    
    
    [NSLayoutConstraint constraintWithItem:self.layoutGuideLed
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0.0];
    
    [NSLayoutConstraint constraintWithItem:self.layoutGuideLed
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.topLayoutGuide
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:20.0f];
    
    
    
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
