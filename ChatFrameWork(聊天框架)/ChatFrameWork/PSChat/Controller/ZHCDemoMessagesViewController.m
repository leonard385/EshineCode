//
//  ZHCDemoMessagesViewController.m
//  ZHChat
//
//  Created by aimoke on 16/8/23.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCDemoMessagesViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "IQKeyboardManager.h"
#import "MessageSendHelper.h"
#import "MessageStoreHelper.h"
@interface ZHCDemoMessagesViewController ()<UIGestureRecognizerDelegate,MessageReceiveProtocol>
@property(nonatomic,strong)NSMutableArray *MessageArray;
@property (strong, nonatomic) ZHCMessagesBubbleImage *outgoingBubbleImageData;//发送的泡泡view
@property (strong, nonatomic) ZHCMessagesBubbleImage *incomingBubbleImageData;//接收的paopao
@property (strong, nonatomic) NSDictionary *avatars;//图片数据

@property(nonatomic,strong)NSString *TargetName;//发送人
@property(nonatomic,strong)NSString *TargetID;//发送人ID
@property(nonatomic,assign)NSUInteger pageNum;
@end

@implementation ZHCDemoMessagesViewController

-(NSMutableArray *)MessageArray
{
    if(_MessageArray == nil){
        _MessageArray = [NSMutableArray new];
        
    }
    return _MessageArray;
}

#pragma mark - life cycle

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.fd_interactivePopDisabled = NO;
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
    [IQKeyboardManager sharedManager].enable = YES;
}

-(instancetype)initWithChatName:(NSString *)Name ID:(NSString*)IDCode
{
    self = [super init];
    if(self){
        _TargetID = IDCode;
        _TargetName = Name;
        _pageNum = 1;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _TargetName;
    [self  UIInit];
    // Do any additional setup after loading the view.
}

-(void)UIInit
{
    ZHCMessagesBubbleImageFactory *bubbleFactory = [[ZHCMessagesBubbleImageFactory alloc] init];
    
    self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
    self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:HEXCOLOR(GlobalGreenColor)];

    ZHCMessagesAvatarImageFactory *avatarFactory = [[ZHCMessagesAvatarImageFactory alloc] initWithDiameter:kZHCMessagesTableViewCellAvatarSizeDefault];
    
    ZHCMessagesAvatarImage *cookImage = [avatarFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_cook"]];
    
    ZHCMessagesAvatarImage *jobsImage = [avatarFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]];
    
    NSString *UserID = [[BSEUserInfo shareMannager].StudentID stringValue];
    
    self.avatars = @{_TargetID : cookImage,
                     UserID : jobsImage};
    
    //最后十条记录加载
    NSMutableArray *LastTenMassages = [[MessageStoreHelper helper]readLastTenMessageFrinedName:_TargetName];
    [self.MessageArray addObjectsFromArray:LastTenMassages];
    
    
    self.messageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        NSMutableArray *HistoryMassages =[[MessageStoreHelper helper]readHistoryMessageWithPage:_pageNum PageSize:10.0f FrinedName:_TargetName];
        
        NSMutableIndexSet *IndecSet = [[NSMutableIndexSet alloc]init];
        [IndecSet addIndexesInRange:NSMakeRange(0, HistoryMassages.count)];
        [self.MessageArray insertObjects:HistoryMassages atIndexes:IndecSet];
        
        if(HistoryMassages.count != 0){
            _pageNum ++;
        }
        
        [self.messageTableView reloadData];
        [self.messageTableView.mj_header endRefreshing];
    }];
    
    [MessageSendHelper helper].delegate = self;
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   [IQKeyboardManager sharedManager].enable = NO;
    self.fd_interactivePopDisabled = YES;
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
    
    if (self.presentBool) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                              target:self
                                                                                              action:@selector(closePressed:)];
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark - ZHCMessagesTableViewDataSource

-(NSString *)senderDisplayName
{
    return _TargetName;
}


-(NSString *)senderId
{
    return _TargetID;
}

#pragma mark -  消息数
- (id<ZHCMessageData>)tableView:(ZHCMessagesTableView*)tableView messageDataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.MessageArray objectAtIndex:indexPath.row];
}

#pragma mark -  消息删除
-(void)tableView:(ZHCMessagesTableView *)tableView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    [self.MessageArray removeObjectAtIndex:indexPath.row];
}

#pragma mark -  消息泡泡
- (nullable id<ZHCMessageBubbleImageDataSource>)tableView:(ZHCMessagesTableView *)tableView messageBubbleImageDataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  You may return nil here if you do not want bubbles.
     *  In this case, you should set the background color of your TableView view cell's textView.
     *
     *  Otherwise, return your previously created bubble image data objects.
     */
    
    ZHCMessage *message = [self.MessageArray objectAtIndex:indexPath.row];
    if (message.isMediaMessage) {
        NSLog(@"is mediaMessage");
    }
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.outgoingBubbleImageData;
    }
    
    
    return self.incomingBubbleImageData;
    
}

#pragma mark -  消息头像
- (nullable id<ZHCMessageAvatarImageDataSource>)tableView:(ZHCMessagesTableView *)tableView avatarImageDataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    
    /**
     *  Return your previously created avatar image data objects.
     *
     *  Note: these the avatars will be sized according to these values:
     *
     *  Override the defaults in `viewDidLoad`
     */
    
    ZHCMessage *message = [self.MessageArray objectAtIndex:indexPath.row];
    return [self.avatars objectForKey:message.senderId];
}


#pragma mark -  消息时间
-(NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
     *  The other label text delegate methods should follow a similar pattern.
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.row %3 == 0) {
        ZHCMessage *message = [self.MessageArray objectAtIndex:indexPath.row];
        return [[ZHCMessagesTimestampFormatter sharedFormatter]attributedTimestampForDate:message.date];
    }
    return nil;
}

#pragma mark -  消息发送人名称
-(NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    ZHCMessage *message = [self.MessageArray objectAtIndex:indexPath.row];
    /**
     *  iOS7-style sender name labels
     */
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if ((indexPath.row - 1) > 0) {
        ZHCMessage *preMessage = [self.MessageArray objectAtIndex:(indexPath.row - 1)];
        if ([preMessage.senderId isEqualToString:message.senderId]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
    
}

#pragma mark -  消息底部lable
- (NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


#pragma mark - Adjusting cell label heights
-(CGFloat)tableView:(ZHCMessagesTableView *)tableView heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
     */
    
    /**
     *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
     *  The other label height delegate methods should follow similarly
     *
     *  Show a timestamp for every 3rd message
     */
    CGFloat labelHeight = 0.0f;
    if (indexPath.item % 3 == 0) {
        labelHeight = kZHCMessagesTableViewCellLabelHeightDefault;
    }
    return labelHeight;
    
}


-(CGFloat)tableView:(ZHCMessagesTableView *)tableView  heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  iOS7-style sender name labels
     */
    CGFloat labelHeight = kZHCMessagesTableViewCellLabelHeightDefault;
    ZHCMessage *currentMessage = [self.MessageArray objectAtIndex:indexPath.item];
    if ([[currentMessage senderId] isEqualToString:self.senderId]) {
        labelHeight = 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        ZHCMessage *previousMessage = [self.MessageArray objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:[currentMessage senderId]]) {
            labelHeight = 0.0f;
        }
    }
    
    return labelHeight;
    
}


-(CGFloat)tableView:(ZHCMessagesTableView *)tableView  heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat labelHeight = 0.0f;
    return labelHeight;
}

#pragma mark - ZHCMessagesTableViewDelegate  点击事件
-(void)tableView:(ZHCMessagesTableView *)tableView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didTapAvatarImageView:avatarImageView atIndexPath:indexPath];
}


-(void)tableView:(ZHCMessagesTableView *)tableView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didTapMessageBubbleAtIndexPath:indexPath];
}


-(void)tableView:(ZHCMessagesTableView *)tableView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    [super tableView:tableView didTapCellAtIndexPath:indexPath touchLocation:touchLocation];
}


-(void)tableView:(ZHCMessagesTableView *)tableView performAction:(SEL)action forcellAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    [super tableView:tableView performAction:action forcellAtIndexPath:indexPath withSender:sender];
    
    NSLog(@"performAction:%ld",(long)indexPath.row);
}


#pragma mark － TableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MessageArray.count;
}

-(UITableViewCell *)tableView:(ZHCMessagesTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHCMessagesTableViewCell *cell = (ZHCMessagesTableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}



#pragma mark Configure Cell Data
- (void)configureCell:(ZHCMessagesTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ZHCMessage *message = [self.MessageArray objectAtIndex:indexPath.row];
    if (!message.isMediaMessage) {
        if ([message.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor blackColor];
        }else{
            cell.textView.textColor = [UIColor whiteColor];
        }
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
}

#pragma mark - 消息发送代理
#pragma mark - Messages view controller

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Play sound (optional)
     *  2. Add new id<ZHCMessageData> object to your data source
     *  3. Call `finishSendingMessage`
     */
    
    ZHCMessage *message = [[ZHCMessage alloc] initWithSenderId:senderId
                                             senderDisplayName:senderDisplayName
                                                          date:date
                                                          text:text];
    //发送消息
    [[MessageSendHelper helper]sendMessage:message completion:^(ZHCMessage *model) {
        
    }];
    
    [self.MessageArray addObject:message];
    
    [self finishSendingMessageAnimated:YES];
    
    
    
}


#pragma mark - ZHCMessagesInputToolbarDelegate
-(void)messagesInputToolbar:(ZHCMessagesInputToolbar *)toolbar sendVoice:(NSString *)voiceFilePath seconds:(NSTimeInterval)senconds
{
    NSData * audioData = [NSData dataWithContentsOfFile:voiceFilePath];
    ZHCAudioMediaItem *audioItem = [[ZHCAudioMediaItem alloc] initWithData:audioData];
    
    ZHCMessage *audioMessage = [ZHCMessage messageWithSenderId:self.senderId
                                                   displayName:self.senderDisplayName
                                                         media:audioItem];
    [self.MessageArray addObject:audioMessage];
    
    [self finishSendingMessageAnimated:YES];

}


#pragma mark - 更多
#pragma mark - ZHCMessagesMoreViewDelegate

-(void)messagesMoreView:(ZHCMessagesMoreView *)moreView selectedMoreViewItemWithIndex:(NSInteger)index
{
   
    switch (index) {
        case 0:{//Camera
//            [self.demoData addVideoMediaMessage];
            [self.messageTableView reloadData];
            [self finishSendingMessage];
        }
            break;
            
        case 1:{//Photos
//            [self.demoData addPhotoMediaMessage];
            [self.messageTableView reloadData];
            [self finishSendingMessage];
        }
            break;
            
        case 2:{//Location
            typeof(self) __weak weakSelf = self;
            __weak ZHCMessagesTableView *weakView = self.messageTableView;
//            [self.demoData addLocationMediaMessageCompletion:^{
//                [weakView reloadData];
//                [weakSelf finishSendingMessage];
//                
//            }];
        }

            break;
            
        default:
            break;
    }
}



#pragma mark - ZHCMessagesMoreViewDataSource
-(NSArray *)messagesMoreViewTitles:(ZHCMessagesMoreView *)moreView
{
    return @[@"Camera",@"Photos",@"Location"];
}

-(NSArray *)messagesMoreViewImgNames:(ZHCMessagesMoreView *)moreView
{
    return @[@"chat_bar_icons_camera",@"chat_bar_icons_location",@"chat_bar_icons_pic"];
}


-(void)didReceiveMessages:(NSMutableArray *)Array
{
    [self.MessageArray addObjectsFromArray:Array];
    [self finishReceivingMessageAnimated:YES];
}


#pragma mark - PrivateMethods
-(void)closePressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
