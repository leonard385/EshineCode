//
//  ZHCMessagesTableViewCellIncoming.m
//  ZHChat
//
//  Created by aimoke on 16/8/9.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesTableViewCellIncoming.h"
#import "ZHCMessagesTableviewLayoutAttributes.h"
@implementation ZHCMessagesTableViewCellIncoming


#pragma mark - Initialzition
- (void)awakeFromNib {
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentLeft;
    self.cellBottomLabel.textAlignment = NSTextAlignmentLeft;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
