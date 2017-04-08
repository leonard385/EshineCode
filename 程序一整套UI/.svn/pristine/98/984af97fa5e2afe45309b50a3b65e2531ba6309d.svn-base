//
//  MMTrainSectionHead.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainSectionHead.h"

@interface MMTrainSectionHead()
@property(nonatomic,strong)UIButton *dropBtn;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIView *verLine;
@end

@implementation MMTrainSectionHead

-(UIButton *)dropBtn{
    if(_dropBtn == nil){
        _dropBtn = [UIButton new];
        [_dropBtn setImage:[UIImage imageNamed:@"content_zhankai"] forState:UIControlStateNormal];
        [_dropBtn setImage:[UIImage imageNamed:@"content_shouqi"] forState:UIControlStateSelected];
        [_dropBtn addTarget:self action:@selector(dropBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dropBtn;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(kBlueColor)];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
        _lableTitle.numberOfLines = 1.0f;
        _lableTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _lableTitle;
}

-(UIView *)verLine{
    if(_verLine == nil){
        _verLine = [UIView new];
        _verLine.backgroundColor = HEXCOLOR(kBlueColor);
    }
    return _verLine;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super  initWithReuseIdentifier:reuseIdentifier];
    if(self){
        [self SHSetUpSubviews];
     }
    return self;
}

-(void)SHSetUpSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.verLine];
    [self.contentView addSubview:self.dropBtn];
   
    
    [_dropBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(15.0f);
        make.size.mas_equalTo(CGSizeMake(27.0, 33.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_dropBtn);
        make.left.mas_equalTo(_dropBtn.mas_right).with.offset(4.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(28.5f);
        make.top.mas_equalTo(_dropBtn.mas_centerY);
        make.width.mas_equalTo(2.0f);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark - 展开点击
-(void)dropBtnClick:(UIButton *)sender{
    BOOL dropState = !sender.selected;
    [UIView animateWithDuration:0.5 animations:^{
        if(dropState){
            sender.transform = CGAffineTransformMakeRotation(0);
        }else{
            sender.transform = CGAffineTransformIdentity;
        }
    }completion:^(BOOL finished) {
        sender.selected = dropState;
    }];
    
    _dropBtnClickBlock?_dropBtnClickBlock(dropState):nil;
}

-(void)setDropState:(BOOL)dropState{
    _dropState = dropState;
    [UIView animateWithDuration:0.1 animations:^{
        if(dropState){
            _dropBtn.transform = CGAffineTransformMakeRotation(0);
        }else{
            _dropBtn.transform = CGAffineTransformIdentity;
        }
    }completion:^(BOOL finished) {
        _dropBtn.selected = dropState;
    }];

}

-(void)setTitle:(NSString *)title{
    _title = title;
    _lableTitle.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
