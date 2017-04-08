//
//  SelectCollectionReusableView.m
//  LeNing
//
//  Created by 蔡翔 on 15/10/30.
//  Copyright © 2015年 Qeebu. All rights reserved.
//

#import "SelectCollectionReusableView.h"

@interface SelectCollectionReusableView ()

@property (weak,nonatomic) UILabel* textLabel;

@property (weak,nonatomic) UIImageView *imageView;

@end

@implementation SelectCollectionReusableView

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, (self.frame.size.height - 18.0f / 2), 0, 18)];
        
        [self addSubview:imageView];
        
        self.imageView = imageView;
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, (self.frame.size.height - 18.0f / 2), 100.0f, 18)];
        label.textColor = [UIColor colorWithWhite:0.294 alpha:1.000];
        label.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:label];
        
        self.textLabel = label;
        
        UIButton *delectButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 65 , (self.frame.size.height - 30.0f / 2), 65, 30)];
        [delectButton setTitleColor:[UIColor colorWithWhite:0.498 alpha:1.000] forState:UIControlStateNormal];
        [delectButton setContentEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
        [delectButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [delectButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [delectButton setTitle:@"清空" forState:UIControlStateNormal];
        [delectButton addTarget:self action:@selector(delect) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:delectButton];
        
        _delectButton = delectButton;
    }
    return self;
}

- (void)delect
{
    if ([self.delectDelegate respondsToSelector:@selector(delectData:)]) {
        [self.delectDelegate delectData:self];
    }
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void) setText:(NSString*)text
{
    self.textLabel.text = text;
}

- (void) setImage:(NSString *)image;
{
    [self.imageView setImage:[UIImage imageNamed:image]];
}
@end
