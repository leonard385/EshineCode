//
//  MMTrainTaskEditHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainTaskEditHeadView.h"
@interface MMTrainTaskEditHeadView ()<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UITextField *titleInput;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UILabel *lableSubTitle;
@property(nonatomic,strong)UITextView *textViewContent;
@property(nonatomic,strong)UILabel *lableLimit;
@property(nonatomic,strong)UIView *lineView;
@end
@implementation MMTrainTaskEditHeadView

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"目录标题";
    }
    return _lableTitle;
}

-(UITextField *)titleInput{
    if(_titleInput == nil){
        _titleInput = [[UITextField alloc]init];
        [_titleInput setPlaceholder:@"请输入"];
        [_titleInput setTextColor:HEXCOLOR(0x999999)];
        [_titleInput setFont:[UIFont systemFontOfSize:15.0f]];
        [_titleInput setBorderStyle:UITextBorderStyleNone];
        [_titleInput setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_titleInput setTextAlignment:NSTextAlignmentRight];
        _titleInput.delegate = self;
    }
    return _titleInput;
}

-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
        _line.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line;
}

-(UILabel *)lableSubTitle{
    if(_lableSubTitle == nil){
        _lableSubTitle = [UILabel new];
        _lableSubTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableSubTitle.textColor = HEXCOLOR(0x333333);
        _lableSubTitle.text = @"目录描述";
    }
    return _lableSubTitle;
}

-(UITextView *)textViewContent{
    if(_textViewContent == nil){
        _textViewContent = [UITextView new];
        [_textViewContent setFont:[UIFont systemFontOfSize:15.0f weight:22.0f]];
        [_textViewContent setTextColor:HEXCOLOR(0x999999)];
        _textViewContent.delegate = self;
    }
    return _textViewContent;
}

-(UILabel *)lableLimit{
    if(_lableLimit == nil){
        _lableLimit = [UILabel new];
        _lableLimit.font = [UIFont systemFontOfSize:16.0f];
        _lableLimit.textColor = HEXCOLOR(0x999999);
        _lableLimit.text = @"16/99";
        _lableLimit.textAlignment = NSTextAlignmentRight;
    }
    return _lableLimit;
}

-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [UIView new];
        _lineView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _lineView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self TTSetUpSubviews];
    }
    return self;
}

-(void)TTSetUpSubviews{
    [self addSubview:self.lableTitle];
    [self addSubview:self.titleInput];
    [self addSubview:self.line];
    [self addSubview:self.lableSubTitle];
    [self addSubview:self.textViewContent];
    [self addSubview:self.lableLimit];
    [self addSubview:self.lineView];
    

    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(44.0f);
        make.left.mas_equalTo(self).with.offset(12.0f);
        make.right.mas_equalTo(self).with.offset(-12.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_line);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(_line.mas_top);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_titleInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle);
        make.bottom.right.mas_equalTo(_line);
        make.left.mas_equalTo(_lableTitle.mas_right).with.offset(8.0f);
    }];
    
    [_lableSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_line);
        make.top.mas_equalTo(_line.mas_bottom);
        make.height.mas_equalTo(44.0f);
    }];
    
    [_textViewContent mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(_lableSubTitle.mas_bottom);
         make.left.right.mas_equalTo(_line);
         make.height.mas_equalTo(73.0f);
    }];
    
    [_lableLimit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_textViewContent);
        make.height.mas_equalTo(21.0f);
        make.top.mas_equalTo(_textViewContent.mas_bottom);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableLimit.mas_bottom).with.offset(12.0f);
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(10.0f);
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
