//
//  MMExamContentChooseCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamContentChooseCell.h"
#import "NSString+Size.h"
@interface MMExamContentChooseCell()
@property(nonatomic,strong)UILabel *lableChooseName;
@property(nonatomic,strong)UIImageView *tipImageView;
@property(nonatomic,strong)UILabel *lableAnswer;
@property(nonatomic,assign)CGFloat answerH;
@end
@implementation MMExamContentChooseCell
-(UILabel *)lableChooseName{
    if(_lableChooseName == nil){
        _lableChooseName = [UILabel new];
        _lableChooseName.textColor = HEXCOLOR(0x666666);
        _lableChooseName.font = [UIFont systemFontOfSize:13.0f];
        _lableChooseName.textAlignment = NSTextAlignmentCenter;
        _lableChooseName.layer.borderWidth = 1.0f;
        _lableChooseName.layer.borderColor = HEXCOLOR(0x989898).CGColor;
        _lableChooseName.layer.cornerRadius = 12.5f;
        _lableChooseName.layer.masksToBounds = YES;
    }
    return _lableChooseName;
}
-(UIImageView *)tipImageView{
    if(_tipImageView == nil){
        _tipImageView = [UIImageView new];
        _tipImageView.layer.cornerRadius = 12.5f;
        _tipImageView.layer.masksToBounds = YES;
        _tipImageView.hidden = YES;
    }
    return _tipImageView;
}

-(UILabel *)lableAnswer{
    if(_lableAnswer == nil){
        _lableAnswer = [UILabel new];
        _lableAnswer.textColor = HEXCOLOR(0x666666);
        _lableAnswer.numberOfLines = 0;
        _lableAnswer.lineBreakMode = NSLineBreakByCharWrapping;
        _lableAnswer.font = [UIFont systemFontOfSize:16.0f];
    }
    return _lableAnswer;
}

-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(kLineColor);
    }
    return _cellLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _answerH = 30.0f;
        [self ECSetUpSubviews];
    }
    return self;
}

-(void)ECSetUpSubviews{
    [self.contentView addSubview:self.lableChooseName];
    [self.contentView addSubview:self.tipImageView];
    [self.contentView addSubview:self.lableAnswer];
    [self.contentView addSubview:self.cellLine];
    
    [_lableChooseName mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(15.0f);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0f));
    }];
    
    [_tipImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(_lableChooseName);
    }];
    
    [_lableAnswer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableChooseName);
        make.left.mas_equalTo(_lableChooseName.mas_right).with.offset(8.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.height.mas_greaterThanOrEqualTo(25.0f);
        make.bottom.mas_equalTo(self.contentView).with.offset(-15.0f);
    }];
    [_cellLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 15.0f;
    totalHeight += [self.lableAnswer sizeThatFits:size].height;
    totalHeight += 15.0f + 0.5f;
    return CGSizeMake(size.width,totalHeight);
}


-(void)setChooseStr:(NSString *)chooseStr ChooseContent:(NSString *)chooseContent{
    _chooseStr = chooseStr;
    _lableChooseName.text = _chooseStr;
    _tipImageView.hidden = YES;
    _chooseContent = chooseContent;
    _lableAnswer.text = chooseContent;
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
