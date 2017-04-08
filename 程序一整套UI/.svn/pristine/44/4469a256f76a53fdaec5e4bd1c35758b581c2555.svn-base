//
//  MMKnowlegeHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/28.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKnowlegeHeadView.h"
#import "MMKnowlegeHeadItem.h"
#import "MMKnowlegeBtnItem.h"
#import "YYText.h"
#import "UIButton+LXMImagePosition.h"
@interface MMKnowlegeHeadView()
@property(nonatomic,strong)UIView *topHalfContent;
@property(nonatomic,strong)UIView *bottomHalfView;
@property(nonatomic,strong)UIView *subContent;
@property(nonatomic,strong)MMKnowlegeHeadItem *btnHead;
@property(nonatomic,strong)MMKnowlegeBtnItem *btnAttent;
@property(nonatomic,strong)MMKnowlegeBtnItem *btnKnowlege;
@property(nonatomic,strong)MMKnowlegeBtnItem *btnSkill;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIButton *btnCheck;
@end
@implementation MMKnowlegeHeadView
-(UIView *)bottomHalfView{
    if(_bottomHalfView == nil){
        _bottomHalfView = [UIView new];
        _bottomHalfView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomHalfView;
}

-(UIView *)topHalfContent{
    if(_topHalfContent == nil){
        _topHalfContent   = [UIView new];
        _topHalfContent.backgroundColor = HEXCOLOR(kBlueColor);
    }
    return _topHalfContent;
}

-(UIView *)subContent{
    if(_subContent == nil){
        _subContent = [UIView new];
        _subContent.backgroundColor = [UIColor whiteColor];
        _subContent.layer.cornerRadius = 5.0f;
        _subContent.layer.shadowRadius = 5.0f;
        _subContent.layer.shadowColor = [UIColor blackColor].CGColor;
        _subContent.layer.shadowOpacity = 0.2f;
    }
    return _subContent;
}

-(MMKnowlegeHeadItem *)btnHead{
    if(_btnHead == nil){
        _btnHead = [MMKnowlegeHeadItem new];
        [_btnHead setImage:[UIImage imageNamed:@"icon_gengduo"] forState:UIControlStateNormal];
        [_btnHead setAttributedTitle:[self getAtrstrWithUser:@"柳叶叶" Time:@"9"] forState:UIControlStateNormal];
        [_btnHead setBackgroundImage:[UIImage imageNamed:@"bg_zsk"] forState:UIControlStateNormal];
        [_btnHead addTarget:self action:@selector(btnHeadClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnHead;
}

-(MMKnowlegeBtnItem *)btnAttent{
    if(_btnAttent == nil){
        _btnAttent = [[MMKnowlegeBtnItem alloc]initWithTitle:@"我的关注"];
        [_btnAttent setNum:@"20"];
        [_btnAttent addTarget:self action:@selector(btnAttentClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAttent;
}

-(MMKnowlegeBtnItem *)btnKnowlege{
    if(_btnKnowlege == nil){
        _btnKnowlege = [[MMKnowlegeBtnItem alloc]initWithTitle:@"我的知识"];
        [_btnKnowlege setNum:@"10"];
        [_btnKnowlege addTarget:self action:@selector(btnKnowlegeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnKnowlege;
}

-(MMKnowlegeBtnItem *)btnSkill{
    if(_btnSkill == nil){
        _btnSkill = [[MMKnowlegeBtnItem alloc]initWithTitle:@"积分值"];
        [_btnSkill setNum:@"98"];
        [_btnSkill addTarget:self action:@selector(btnSkillClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSkill;
}
-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
        _line.backgroundColor = HEXCOLOR(kLineColor);
    }
    return _line;
}

-(UIButton *)btnCheck{
    if(_btnCheck == nil){
        _btnCheck = [UIButton new];
        [_btnCheck setTitle:@"查看我的技能评估" forState:UIControlStateNormal];
        [_btnCheck setTitleColor:HEXCOLOR(0x7599c3) forState:UIControlStateNormal];
        [_btnCheck.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_btnCheck setImage:[UIImage imageNamed:@"icon_ck"] forState:UIControlStateNormal];
        [_btnCheck setImagePosition:LXMImagePositionLeft spacing:5.0f];
        [_btnCheck addTarget:self action:@selector(btnCheckClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCheck;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self KHSetUpSubviews];
    }
    return self;
}

-(void)KHSetUpSubviews{
    self.backgroundColor = HEXCOLOR(0xf0f3f8);
    [self addSubview:self.bottomHalfView];
    [self addSubview:self.topHalfContent];
    [self addSubview:self.subContent];
    [self.subContent addSubview:self.btnHead];
    [self.subContent addSubview:self.btnAttent];
    [self.subContent addSubview:self.btnKnowlege];
    [self.subContent addSubview:self.btnSkill];
    [self.subContent addSubview:self.line];
    [self.subContent addSubview:self.btnCheck];
    
    [_topHalfContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(154.0f);
    }];
    
    [_bottomHalfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topHalfContent.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(57.0f);
    }];
    [_subContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(20.0f, 22.0f, 22.0f+10.0f, 20.0f));
    }];
    
    [_btnHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(_subContent);
        make.height.mas_equalTo(40.0f);
    }];
    
    [_btnAttent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.subContent).with.offset(12.0f);
        make.top.mas_equalTo(self.btnHead.mas_bottom).with.offset(12.0f);
        make.height.mas_equalTo(68.0f);
        make.width.mas_equalTo(_btnKnowlege);
    }];
    
    [_btnKnowlege mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_btnAttent);
        make.width.mas_equalTo(_btnAttent);
        make.left.mas_equalTo(_btnAttent.mas_right);
    }];
    [_btnSkill mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_btnKnowlege);
        make.width.mas_equalTo(_btnKnowlege);
        make.left.mas_equalTo(_btnKnowlege.mas_right);
        make.right.mas_equalTo(self.subContent).with.offset(-12.0f);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btnAttent);
        make.right.mas_equalTo(_btnSkill);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(_subContent).with.offset(-40.0f);
    }];
    
    [_btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(_subContent);
        make.top.mas_equalTo(_line.mas_bottom);
    }];
    
}

#pragma mark - 富文本处理
-(NSMutableAttributedString*)getAtrstrWithUser:(NSString *)user Time:(NSString*)time{
    NSString *subStr = [NSString stringWithFormat:@"学习时长%@小时",time];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",user,subStr]];
    
    NSRange range0 = [[text string] rangeOfString:user options:NSCaseInsensitiveSearch];
    [text yy_setFont:[UIFont systemFontOfSize:15.0f] range:range0];
    [text yy_setColor:HEXCOLOR(kBlueColor) range:range0];
    
    NSRange range1 = [[text string] rangeOfString:subStr options:NSCaseInsensitiveSearch];
    [text yy_setFont:[UIFont systemFontOfSize:12.0f] range:range1];
    [text yy_setColor:HEXCOLOR(kBlueColor) range:range1];
    return text;
}


#pragma mark - 头按钮点击
-(void)btnHeadClick{

}

#pragma mark - 关注按钮点击
-(void)btnAttentClick{
  
}

#pragma mark - 我的知识按钮点击
-(void)btnKnowlegeClick{
 
}

#pragma mark - 技能值按钮点击
-(void)btnSkillClick{
 
}

#pragma mark - 查看
-(void)btnCheckClick{

}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
