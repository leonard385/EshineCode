//
//  MMMyTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/6.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMMyTableViewCell.h"

@implementation MMMyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellModel:(MMMineModel *)cellModel{
    _cellModel = cellModel;
    self.imageView.image = [UIImage imageNamed:cellModel.icon];
    self.labletitle.text = cellModel.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
