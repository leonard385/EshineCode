//
//  ZHCMessagesTableView.m
//  ZHChat
//
//  Created by aimoke on 16/8/11.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesTableView.h"
#import "ZHCMessagesTableViewCellIncoming.h"
#import "ZHCMessagesTableViewCellOutcoming.h"


@implementation ZHCMessagesTableView
@dynamic delegate;
@dynamic dataSource;

#pragma mark - Initialization

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self zhc_configureTableView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self zhc_configureTableView];
    }
    return self;
}



-(void)awakeFromNib
{
    [super awakeFromNib];
    [self zhc_configureTableView];
    
}

- (void)zhc_configureTableView
{
    //self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.alwaysBounceVertical = YES;
    self.bounces = YES;
    self.tableHeaderView = [UIView new];
    
    [self registerNib:[ZHCMessagesTableViewCellIncoming nib] forCellReuseIdentifier:[ZHCMessagesTableViewCellIncoming cellReuseIdentifier]];
    [self registerNib:[ZHCMessagesTableViewCellOutcoming nib] forCellReuseIdentifier:[ZHCMessagesTableViewCellOutcoming cellReuseIdentifier]];
    
    [self registerNib:[ZHCMessagesTableViewCellIncoming nib] forCellReuseIdentifier:[ZHCMessagesTableViewCellIncoming mediaCellReuseIdentifier]];
    [self registerNib:[ZHCMessagesTableViewCellOutcoming nib] forCellReuseIdentifier:[ZHCMessagesTableViewCellOutcoming mediaCellReuseIdentifier]];
    self.tableViewLayout = [[ZHCMessagesTableviewLayoutAttributes alloc]init];
}


#pragma mark - TableView cell delegate

-(ZHCMessagesTableviewLayoutAttributes *)messagesTableViewCellAttributes
{
    return self.tableViewLayout;
}

-(void)messagesTableViewCellDidTapAvatar:(ZHCMessagesTableViewCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    [self.delegate tableView:self didTapAvatarImageView:cell.avatarImageView atIndexPath:indexPath];
}

-(void)messagesTableViewCellDidTapMessageBubble:(ZHCMessagesTableViewCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    [self.delegate tableView:self didTapMessageBubbleAtIndexPath:indexPath];
}


-(void)messagesTableViewCellDidTapCell:(ZHCMessagesTableViewCell *)cell atPosition:(CGPoint)position
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    [self.delegate tableView:self didTapCellAtIndexPath:indexPath touchLocation:position];
}

-(void)messagesTableViewCell:(ZHCMessagesTableViewCell *)cell didPerformAction:(SEL)action withSender:(id)sender
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath == nil) {
        return;
    }
    
    [self.delegate tableView:self performAction:action forcellAtIndexPath:indexPath withSender:sender];
}

-(ZHCMessagesTableViewCell *)messageTableViewDequeueReusableCellWithIndexPath:(NSIndexPath *)indexPath
{
 
    return [self.dataSource messageTableViewDequeueReusableCellWithIndexPath:indexPath];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
