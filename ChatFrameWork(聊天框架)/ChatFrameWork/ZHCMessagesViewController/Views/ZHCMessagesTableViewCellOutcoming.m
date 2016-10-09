//
//  ZHCMessagesTableViewCellIncoming.m
//  ZHChat
//
//  Created by aimoke on 16/8/9.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesTableViewCellOutcoming.h"
#import "ZHCMessagesTableviewLayoutAttributes.h"
@implementation ZHCMessagesTableViewCellOutcoming


#pragma mark - Initialzition
- (void)awakeFromNib {
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentRight;
    self.cellBottomLabel.textAlignment = NSTextAlignmentRight;
    self.textView.backgroundColor = [UIColor grayColor];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
