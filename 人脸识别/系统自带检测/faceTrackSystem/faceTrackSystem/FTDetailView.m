//
//  FTDetailView.m
//  faceTrackSystem
//
//  Created by 倪望龙 on 2017/5/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "FTDetailView.h"
@interface FTDetailView()

@end
@implementation FTDetailView

-(UILabel *)detailsLable{
    if(_detailsLable == nil){
        _detailsLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _detailsLable.numberOfLines = 0;
        _detailsLable.textColor = [UIColor whiteColor];
        _detailsLable.font = [UIFont systemFontOfSize:18.0f];
        _detailsLable.textAlignment = NSTextAlignmentLeft;
    }
    return _detailsLable;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.layer.borderColor = [[UIColor redColor]colorWithAlphaComponent:0.7].CGColor;
        self.layer.borderWidth = 5.0f;
        [self addSubview:self.detailsLable];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    CGRect lableFrame = self.detailsLable.frame;
    lableFrame = CGRectMake(0, frame.size.height, frame.size.width * 2.0f, frame.size.width * 2.0f/2.0f);
    self.detailsLable.frame = lableFrame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
