//
//  MMKVPracticeTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/11.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKVPracticeTableViewCell.h"
#import "YYText.h"
@interface MMKVPracticeTableViewCell ()
@property(nonatomic,strong)YYLabel *lableTitle;
@property(nonatomic,strong)UILabel *lablePeople;//参加考试人数
@end

@implementation MMKVPracticeTableViewCell
-(YYLabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [YYLabel new];
        _lableTitle.numberOfLines = 2.0f;
    }
    return _lableTitle;
}

-(UILabel *)lablePeople{
    if(_lablePeople == nil){
        _lablePeople = [UILabel new];
        [_lablePeople setTextColor:HEXCOLOR(0x999999)];
        [_lablePeople setFont:[UIFont systemFontOfSize:11.0f]];
        _lablePeople.text = @"299已考试";
    }
    return _lablePeople;
}

-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _cellLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self PTSetUpSubviews];
    }
    return self;
}

-(void)PTSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lablePeople];
    [self.contentView addSubview:self.cellLine];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.height.mas_equalTo(60.0f);
    }];
    
    [_lablePeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_lableTitle);
        make.width.mas_equalTo(80.0f);
        make.height.mas_equalTo(14.0f);
        make.bottom.mas_equalTo(self).with.offset(-12.0f);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
    
}

-(NSMutableAttributedString*)getAttributeStrClass:(NSString *)class title:(NSString *)title{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@  %@",class,title]];
    NSRange range0 = [[text string] rangeOfString:class options:NSCaseInsensitiveSearch];
    [text yy_setFont:[UIFont systemFontOfSize:10.0f] range:range0];
    [text yy_setColor:HEXCOLOR(kBlueColor) range:range0];
    
    YYTextBorder *border = [YYTextBorder new];
    border.strokeWidth = 1.5;
    border.strokeColor = HEXCOLOR(kBlueColor);
    border.fillColor = [UIColor whiteColor];
    border.cornerRadius = 2.5f;
    border.lineJoin = kCGLineJoinRound;
    [text yy_setTextBackgroundBorder:border range:range0];
    
    NSRange range1 = [[text string] rangeOfString:title options:NSCaseInsensitiveSearch];
    [text yy_setFont:[UIFont systemFontOfSize:16] range:range1];
    [text yy_setColor:HEXCOLOR(0x333333) range:range1];
    text.yy_lineSpacing = 5.0f;
    return text;
}

-(void)setType:(MMExamType)type examTitle:(NSString *)title{
    NSString *classStr;
    switch (type) {
        case singleSelectionType:{
            classStr = @"  单选题  ";
        }
            break;
        case multipleSelectionType:{
            classStr = @"  多选题  ";
        }
            break;
        case trueOrFalseType:{
            classStr = @"  判断题  ";
        }
            break;
        default:{
            classStr = @"  单选题  ";
        }
            break;
    }
    NSMutableAttributedString *attr = [self getAttributeStrClass:classStr title:title];
    _lableTitle.attributedText = attr;
}

-(void)setCellModel:(MMKVPraticeModel *)cellModel{
    _cellModel = cellModel;
    [self setType:[cellModel.examType unsignedIntegerValue] examTitle:cellModel.title];
    _lablePeople.text = [NSString stringWithFormat:@"%@人已练习",[cellModel.completeNum stringValue]];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
