//
//  CXTexeFileBgView.m
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "CXTexeFileBgView.h"

@implementation CXTexeFileBgView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [self.layer setMasksToBounds:YES];
    [self.layer setBackgroundColor:[UIColor colorWithWhite:0.925 alpha:1.000].CGColor];
    [self.layer setCornerRadius:3.0];
//    [self.layer setBorderWidth:1.0];   //边框宽度
//    [self.layer setBorderColor:[UIColor colorWithRed:0.941 green:0.580 blue:0.408 alpha:1.000].CGColor];//边框颜色
}
@end
