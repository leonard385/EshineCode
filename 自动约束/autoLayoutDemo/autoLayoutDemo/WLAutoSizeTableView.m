//
//  WLAutoSizeTableView.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/25.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "WLAutoSizeTableView.h"

@implementation WLAutoSizeTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    if(!CGSizeEqualToSize(self.bounds.size, self.intrinsicContentSize)){
        [self invalidateIntrinsicContentSize];
    }
}

-(CGSize)intrinsicContentSize{
    return self.contentSize;
}

-(CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    CGSize size = [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
    return size;
}

@end
