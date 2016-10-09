//
//  ZHCMessagesMoreItem.m
//  ZHChat
//
//  Created by aimoke on 16/8/25.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesMoreItem.h"
#import "UIImage+ZHCMessages.h"
#import "NSBundle+ZHCMessages.h"
#import "UIView+ZHCMessages.h"
#import "UIColor+ZHCMessages.h"



@interface ZHCMessagesMoreItem()
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation ZHCMessagesMoreItem


#pragma mark - Initialization
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSubViews];
    }
    return self;
}


-(void)awakeFromNib
{
    [self initialSubViews];
}

-(void)updateConstraints
{
    [super updateConstraints];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self zhc_pinSubview:self.button toEdge:NSLayoutAttributeTop withConstant:4.0f];
    [self zhc_pinSubview:self.button toEdge:NSLayoutAttributeCenterX withConstant:0.0f];
    [self.button zhc_pinSelfToEdge:NSLayoutAttributeWidth withConstant:50.0f];
    [self.button zhc_pinSelfToEdge:NSLayoutAttributeHeight withConstant:50.0f];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.button attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3.0]];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0f]];
}


#pragma mark - Private Methods
-(void)initialSubViews
{
    [self addSubview:self.button];
    [self addSubview:self.titleLabel];
    [self updateConstraintsIfNeeded];
}

#pragma mark - Public Methods
-(void)setViewWithTitle:(NSString *)title imgName:(NSString *)imgName
{
    self.titleLabel.text = title;
    NSParameterAssert(imgName != nil);
    UIImage *img = [UIImage imageNamed:imgName];
    [self.button setBackgroundImage:img forState:UIControlStateNormal];
    [self updateConstraintsIfNeeded];
}



#pragma mark - Getters
-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _titleLabel.textColor = [UIColor darkTextColor];
    }
    return _titleLabel;
}

#pragma mark - UserInteraction
-(void)buttonAction:(UIButton *)sender
{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Touchs
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.button setHighlighted:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.button setHighlighted:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
