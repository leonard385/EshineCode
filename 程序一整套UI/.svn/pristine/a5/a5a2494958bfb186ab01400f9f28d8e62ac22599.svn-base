//
//  MMTrainItemSubCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainItemSubCell.h"
@interface MMTrainItemSubCell()
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *lableTitle;
@end
@implementation MMTrainItemSubCell

-(UIImageView *)iconImageView{
    if(_iconImageView == nil){
        _iconImageView = [UIImageView new];
        _iconImageView.backgroundColor = [UIColor redColor];
        _iconImageView.layer.cornerRadius = 6.5f;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x666666)];
        [_lableTitle setFont:[UIFont systemFontOfSize:12.0f]];
        _lableTitle.numberOfLines = 0.0f;
        _lableTitle.text = @"店长岗位与职责";
    }
    return _lableTitle;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self TSSetUpSubviews];
    }
    return self;
}

-(void)TSSetUpSubviews{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.lableTitle];
}

-(void)setFrameModel:(MMTrainItemFileFrame *)frameModel{
    _frameModel = frameModel;
    [self setFrameWithFrameModel:frameModel];
    [self setCellModelWithModel:frameModel.cellModel];
}

-(void)setFrameWithFrameModel:(MMTrainItemFileFrame *)frameModel{
    _iconImageView.frame = frameModel.iconFrame;
    _lableTitle.frame = frameModel.contentFrame;
}

-(void)setCellModelWithModel:(MMTrainItemFileModel *)model{
    NSUInteger type = [model.fileType unsignedIntegerValue];
    switch (type) {
        case fileType:{
        }
            break;
        case videoType:{
         
        }break;
        case linkType:{
            
        }break;
            
        default:
            break;
    }
    
    _lableTitle.text = [NSString stringWithFormat:@"%lu.%@",_index,model.fileTitles];
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
