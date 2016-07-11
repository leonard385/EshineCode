//
//  ESAlertSelectorStringCell.m
//  弹出对话框选择器
//
//  Created by eshine_lsc on 16/4/5.
//  Copyright © 2016年 eshine_lsc. All rights reserved.
//

#import "ESAlertSelectorStringCell.h"

@implementation ESAlertSelectorStringCell

- (void)awakeFromNib {
    // Initialization code
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 *  创建文本
 */
-(void)setUI{
    
    self.labelText = [[UILabel alloc] init];
    self.labelText.numberOfLines = 0;
    self.labelText.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.labelText];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 40-1, self.bounds.size.width, 1)];
    self.bottomView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.bottomView];
}

@end
