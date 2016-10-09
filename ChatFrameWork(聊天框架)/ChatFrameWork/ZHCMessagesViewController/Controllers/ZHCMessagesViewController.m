//
//  ZHCMessagesViewController.m
//  ZHChat
//
//  Created by aimoke on 16/8/12.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesViewController.h"
#import "ZHCMessage.h"
#import "ZHCMessagesTableviewLayoutAttributes.h"
#import "ZHCMessagesBubbleCalculator.h"
#import "ZHCMessagesTableViewCellOutcoming.h"
#import "ZHCMessageBubbleImageDataSource.h"
#import "ZHCMessageAvatarImageDataSource.h"
#import "ZHCMessagesTableviewLayoutAttributes.h"
#import "ZHCMessagesCommonParameter.h"
#import "ZHCMessagesComposerTextView.h"
#import "ZHCMessagesToolbarContentView.h"
#import "NSBundle+ZHCMessages.h"
#import "NSString+ZHCMessages.h"
#import "UIColor+ZHCMessages.h"
#import "UIView+ZHCMessages.h"
#import "ZHCMessagesCommonParameter.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <objc/runtime.h>

@interface ZHCMessagesViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet ZHCMessagesTableView *messageTableView;
@property (strong, nonatomic) IBOutlet ZHCMessagesInputToolbar *inputMessageBarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewBottomLayoutGuide;
@property (strong, nonatomic) NSIndexPath *selectedIndexPathForMenu;
@property (strong, nonatomic) NSLayoutConstraint *messagesMoreViewBottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *messagesEmojiViewBottomContraint;

@property (assign, nonatomic) BOOL showFunctionViewBool;
@end

@implementation ZHCMessagesViewController

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([ZHCMessagesViewController class])
                          bundle:[NSBundle bundleForClass:[ZHCMessagesViewController class]]];
}

+ (instancetype)messagesViewController
{
    return [[[self class] alloc] initWithNibName:NSStringFromClass([ZHCMessagesViewController class])
                                          bundle:[NSBundle bundleForClass:[ZHCMessagesViewController class]]];
}


#pragma mark - Initialization
- (void)zhc_configureMessagesViewController
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.modalPresentationCapturesStatusBarAppearance =NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.bubbleSizeCalculator = [[ZHCMessagesBubbleCalculator alloc]init];
    self.messageTableView.backgroundColor = [UIColor colorWithRed:243.0/255.0f
                                                            green:243.0/255.0f
                                                             blue:243.0/255.0f
                                                            alpha:1.0f];
    self.messageTableView.tableFooterView = [UIView new];
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    self.showFunctionViewBool = NO;
    
    
    
    self.inputViewHeightConstraint.constant = self.inputMessageBarView.preferredDefaultHeight;
    self.inputMessageBarView.delegate = self;
    self.inputMessageBarView.contentView.textView.placeHolder = [NSBundle zhc_localizedStringForKey:@"new_message"];
    self.inputMessageBarView.contentView.textView.accessibilityLabel = [NSBundle zhc_localizedStringForKey:@"new_message"];
    self.inputMessageBarView.contentView.textView.delegate = self;
    self.automaticallyScrollsToMostRecentMessage = YES;
    
    self.incomingCellIdentifier = [ZHCMessagesTableViewCellIncoming cellReuseIdentifier];
    self.outgoingCellIdentifier = [ZHCMessagesTableViewCellOutcoming cellReuseIdentifier];
    self.incomingMediaCellIdentifier = [ZHCMessagesTableViewCellIncoming mediaCellReuseIdentifier];
    self.outgoingMediaCellIdentifier = [ZHCMessagesTableViewCellOutcoming mediaCellReuseIdentifier];
    //self.messageTableView.estimatedRowHeight = 100.0;//This can't set
    
    self.topContentAdditionalInset = 0.0f;
    
    [self zhc_updateTableViewInsets];
}

- (void)dealloc
{
    [self zhc_registerForNotifications:NO];
    
    _messageTableView.dataSource = nil;
    _messageTableView.delegate = nil;
    _inputMessageBarView.contentView.textView.delegate = nil;
    _inputMessageBarView.delegate = nil;
    
    _messageMoreView.dataSource = nil;
    _messageMoreView.delegate = nil;
    
    _messageEmojiView.delegate = nil;
}


#pragma mark - Setters
- (void)setTopContentAdditionalInset:(CGFloat)topContentAdditionalInset
{
    _topContentAdditionalInset = topContentAdditionalInset;
    [self zhc_updateTableViewInsets];
}


-(ZHCMessagesMoreView *)messageMoreView
{
    if (!_messageMoreView) {
        _messageMoreView = [[ZHCMessagesMoreView alloc]init];
        _messageMoreView.dataSource = self;
        _messageMoreView.delegate = self;
        _messageMoreView.numberItemPerLine = 4;
        _messageMoreView.edgeInsets = UIEdgeInsetsMake(10.0f, 5.0f, 10.0f, 5.0f);
    }
    return _messageMoreView;
}


-(ZHCMessagesEmojiView *)messageEmojiView
{
    if (!_messageEmojiView) {
        _messageEmojiView = [[ZHCMessagesEmojiView alloc]init];
        _messageEmojiView.delegate = self;
    }
    return _messageEmojiView;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [[[self class] nib] instantiateWithOwner:self options:nil];
    [self zhc_configureMessagesViewController];
    [self zhc_registerForNotifications:YES];
    [self initialSubViews];
    // Do any additional setup after loading the view from its nib.
}


-(void)initialSubViews
{
    if (!_messageMoreView) {
        [self.view addSubview:self.messageMoreView];
        _messageMoreView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view zhc_pinSubview:_messageMoreView toEdge:NSLayoutAttributeLeading withConstant:0.0f];
        [self.view zhc_pinSubview:_messageMoreView toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_messageMoreView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kZHCMessagesFunctionViewHeight];
        [self.view addConstraint:constraint];
        [_messageMoreView zhc_pinSelfToEdge:NSLayoutAttributeHeight withConstant:kZHCMessagesFunctionViewHeight];
        
        self.messagesMoreViewBottomConstraint = constraint;
    }
    
    if (!_messageEmojiView) {
        [self.view addSubview:self.messageEmojiView];
        _messageEmojiView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view zhc_pinSubview:_messageEmojiView toEdge:NSLayoutAttributeLeading withConstant:0.0f];
        [self.view zhc_pinSubview:_messageEmojiView toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_messageEmojiView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kZHCMessagesFunctionViewHeight];
        [self.view addConstraint:constraint];
        [_messageEmojiView zhc_pinSelfToEdge:NSLayoutAttributeHeight withConstant:kZHCMessagesFunctionViewHeight];
        self.messagesEmojiViewBottomContraint = constraint;
        
    }
    
}


-(void)clickRightItem:(id)sender
{
    if (self.inputViewBottomLayoutGuide.constant == 0) {
        self.inputViewBottomLayoutGuide.constant = 100;
    }else{
        self.inputViewBottomLayoutGuide.constant = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.inputViewHeightConstraint.constant = self.inputMessageBarView.preferredDefaultHeight;
    [self.view layoutIfNeeded];
    ZHCWeakSelf;
    if (self.automaticallyScrollsToMostRecentMessage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf scrollToBottomAnimated:NO];
        });
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}



#pragma mark - View rotation

- (BOOL)shouldAutorotate
{
    return YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.bubbleSizeCalculator prepareForResettingLayoutWithTableView:self.messageTableView];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.messageTableView reloadData];
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self zhc_resetLayoutAndCaches];
}



- (void)zhc_resetLayoutAndCaches
{
    
    [self.bubbleSizeCalculator prepareForResettingLayoutWithTableView:self.messageTableView];
}



#pragma mark - Messages view controller

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    NSAssert(NO, @"Error! required method not implemented in subclass. Need to implement %s", __PRETTY_FUNCTION__);
}

- (void)didPressAccessoryButton:(UIButton *)sender
{
    NSAssert(NO, @"Error! required method not implemented in subclass. Need to implement %s", __PRETTY_FUNCTION__);
}

- (void)finishSendingMessage
{
    [self finishSendingMessageAnimated:YES];
}

- (void)finishSendingMessageAnimated:(BOOL)animated {
    
    UITextView *textView = self.inputMessageBarView.contentView.textView;
    textView.text = nil;
    [textView.undoManager removeAllActions];
    
    [self.inputMessageBarView toggleSendButtonEnabled];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:textView];
    
    [self.messageTableView reloadData];
    
    if (self.automaticallyScrollsToMostRecentMessage) {
        [self scrollToBottomAnimated:animated];
    }
}


- (void)finishReceivingMessage
{
    [self finishReceivingMessageAnimated:YES];
}

- (void)finishReceivingMessageAnimated:(BOOL)animated {
    
    
    [self.messageTableView reloadData];
    
    if (self.automaticallyScrollsToMostRecentMessage && ![self zhc_isMenuVisible]) {
        [self scrollToBottomAnimated:animated];
    }
    
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, [NSBundle zhc_localizedStringForKey:@"new_message_received_accessibility_announcement"]);
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    if ([self.messageTableView numberOfSections] == 0) {
        return;
    }
    NSInteger rows = [self.messageTableView numberOfRowsInSection:0];
    NSIndexPath *lastCellIndexPath = [NSIndexPath indexPathForItem:(rows - 1) inSection:0];
    [self scrollToIndexPath:lastCellIndexPath animated:animated];
}


- (void)scrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
{
    if ([self.messageTableView numberOfSections] <= indexPath.section) {
        return;
    }
    
    NSInteger numberOfItems = [self.messageTableView numberOfRowsInSection:indexPath.section];
    if (numberOfItems == 0) {
        return;
    }
    
    CGFloat tableViewContentHeight = self.messageTableView.contentSize.height;
    CGFloat tableViewHeight = CGRectGetHeight(self.messageTableView.bounds);
    BOOL isContentTooSmall = (tableViewContentHeight < tableViewHeight);
    if (isContentTooSmall) {
        //  workaround for the first few messages not scrolling
        //  when the TableView view content size is too small, `scrollToItemAtIndexPath:` doesn't work properly
        [self.messageTableView scrollRectToVisible:CGRectMake(0.0, tableViewContentHeight - 1.0f, 1.0f, 1.0f)
                                          animated:animated];
        return;
    }
    NSInteger row = MAX(MIN(indexPath.row, numberOfItems - 1), 0);
    indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    //  workaround for really long messages not scrolling
    //  if last message is too long, use scroll position bottom for better appearance, else use top
    CGFloat cellHeight = [self tableView:self.messageTableView heightForRowAtIndexPath:indexPath];
    CGFloat maxHeightForVisibleMessage = CGRectGetHeight(self.messageTableView.bounds)
    - self.messageTableView.contentInset.top
    - self.messageTableView.contentInset.bottom
    - CGRectGetHeight(self.inputMessageBarView.bounds);
    UITableViewScrollPosition scrollPosition = (cellHeight > maxHeightForVisibleMessage) ? UITableViewScrollPositionBottom : UITableViewScrollPositionTop;
    
    
    [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    
}


- (BOOL)isOutgoingMessage:(id<ZHCMessageData>)messageItem
{
    NSString *messageSenderId = [messageItem senderId];
    NSParameterAssert(messageSenderId != nil);
    
    return [messageSenderId isEqualToString:[self.messageTableView.dataSource senderId]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark － TableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


-(CGFloat)tableView:(ZHCMessagesTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHCMessage *message = (ZHCMessage *)[tableView.dataSource tableView:tableView messageDataForCellAtIndexPath:indexPath];
    CGFloat height = 0.0;
    CGSize size = [self.bubbleSizeCalculator messageBubbleSizeForMessageData:message atIndexPath:indexPath withTableView:tableView];
    
    CGFloat avatarHeight = 0.0f;
    BOOL isOutgoingMessage = [self isOutgoingMessage:message];
    if (isOutgoingMessage) {
        avatarHeight = tableView.tableViewLayout.outgoingAvatarViewSize.height;
    }else{
        avatarHeight = tableView.tableViewLayout.incomingAvatarViewSize.height;
    }
    
    CGFloat bubbleHeight = size.height>avatarHeight?size.height:avatarHeight;
    
    CGFloat cellsSpaceLabelHeight = [tableView.dataSource tableView:tableView tableViewCellSeparatorHeightAtIndexpath:indexPath];
    CGFloat cellTopLabelHeight = [tableView.dataSource tableView:tableView heightForCellTopLabelAtIndexPath:indexPath];
    CGFloat cellBubbleTopLabelHeight = [tableView.dataSource tableView:tableView  heightForMessageBubbleTopLabelAtIndexPath:indexPath];
    CGFloat cellBottomLabelHeight = [tableView.dataSource tableView:tableView heightForCellBottomLabelAtIndexPath:indexPath];
    
    height = cellsSpaceLabelHeight + cellTopLabelHeight + cellBubbleTopLabelHeight + cellBottomLabelHeight + bubbleHeight + 2.0*[UIScreen mainScreen].scale;
    return height;
    
}


-(UITableViewCell *)tableView:(ZHCMessagesTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    id<ZHCMessageData> messagecell = [tableView.dataSource tableView:tableView messageDataForCellAtIndexPath:indexPath];
    NSParameterAssert(messagecell != nil);
    BOOL isOutgoingMessage = [self isOutgoingMessage:messagecell];
    BOOL isMediaMessage = [messagecell isMediaMessage];
    
    NSString *cellIdentifier = nil;
    if (isMediaMessage) {
        cellIdentifier = isOutgoingMessage ? self.outgoingMediaCellIdentifier : self.incomingMediaCellIdentifier;
    }
    else {
        cellIdentifier = isOutgoingMessage ? self.outgoingCellIdentifier : self.incomingCellIdentifier;
    }
    
    ZHCMessagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = tableView;
    [cell applyLayoutAttributes];
    if (!isMediaMessage) {
        cell.textView.text = [messagecell text];
        NSParameterAssert(cell.textView.text != nil);
        id<ZHCMessageBubbleImageDataSource> bubbleImageDataSource = [tableView.dataSource tableView:tableView messageBubbleImageDataForCellAtIndexPath:indexPath];
        cell.messageBubbleImageView.image = [bubbleImageDataSource messageBubbleImage];
        cell.messageBubbleImageView.highlightedImage = [bubbleImageDataSource messageBubbleHighlightedImage];
        
    }else{
        id<ZHCMessageMediaData> messageMedia = [messagecell media];
        UIView *view = [messageMedia mediaView] ?:[messageMedia mediaPlaceholderView];
        [cell setMediaView:view withisOutgoingMessage:isOutgoingMessage];
        NSParameterAssert(cell.mediaView !=nil);
        
    }
    BOOL needsAvatar = YES;
    if (isOutgoingMessage && CGSizeEqualToSize(tableView.tableViewLayout.outgoingAvatarViewSize, CGSizeZero)) {
        needsAvatar = NO;
    }else if (!isOutgoingMessage && CGSizeEqualToSize(tableView.tableViewLayout.incomingAvatarViewSize, CGSizeZero)){
        needsAvatar = NO;
    }
    id<ZHCMessageAvatarImageDataSource> avatarImageDataSource = nil;
    if (needsAvatar) {
        avatarImageDataSource = [tableView.dataSource tableView:tableView avatarImageDataForCellAtIndexPath:indexPath];
        if (avatarImageDataSource != nil) {
            UIImage *avatarImage = [avatarImageDataSource avatarImage];
            if (avatarImage == nil) {
                cell.avatarImageView.image = [avatarImageDataSource avatarPlaceholderImage];
                cell.avatarImageView.highlightedImage = nil;
            }else{
                cell.avatarImageView.image = avatarImage;
                cell.avatarImageView.highlightedImage = [avatarImageDataSource avatarHighlightedImage];
            }
            
        }
    }
    
    cell.cellTopLabel.attributedText = [tableView.dataSource tableView:tableView attributedTextForCellTopLabelAtIndexPath:indexPath];
    cell.messageBubbleTopLabel.attributedText = [tableView.dataSource tableView:tableView attributedTextForMessageBubbleTopLabelAtIndexPath:indexPath];
    cell.cellBottomLabel.attributedText = [tableView.dataSource tableView:tableView attributedTextForCellBottomLabelAtIndexPath:indexPath];
    CGFloat cellsSpaceLabelHeight = [tableView.dataSource tableView:tableView tableViewCellSeparatorHeightAtIndexpath:indexPath];
    CGFloat cellTopLabelHeight = [tableView.dataSource tableView:tableView heightForCellTopLabelAtIndexPath:indexPath];
    CGFloat cellBubbleTopLabelHeight = [tableView.dataSource tableView:tableView  heightForMessageBubbleTopLabelAtIndexPath:indexPath];
    CGFloat cellBottomLabelHeight = [tableView.dataSource tableView:tableView heightForCellBottomLabelAtIndexPath:indexPath];
    
    cell.cellsSpaceLabelHeight = cellsSpaceLabelHeight;
    cell.cellTopLabelHeight = cellTopLabelHeight;
    cell.messageBubbleTopLabelHeight = cellBubbleTopLabelHeight;
    cell.cellBottomLabelHeight = cellBottomLabelHeight;
    
    CGFloat bubbleTopLableInset = (avatarImageDataSource != nil)? 60.0f: 15.0f;
    if (isOutgoingMessage) {
        cell.messageBubbleTopLabel.textInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, bubbleTopLableInset);
    }else{
        cell.messageBubbleTopLabel.textInsets = UIEdgeInsetsMake(0.0f, bubbleTopLableInset, 0.0f, 0.0f);
    }
    cell.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.layer.shouldRasterize = YES;
    return cell;
}

-(ZHCMessagesTableViewCell *)messageTableViewDequeueReusableCellWithIndexPath:(NSIndexPath *)indexPath
{
    id<ZHCMessageData> messagecell = [self.messageTableView.dataSource tableView:self.messageTableView messageDataForCellAtIndexPath:indexPath];
    NSParameterAssert(messagecell != nil);
    BOOL isOutgoingMessage = [self isOutgoingMessage:messagecell];
    BOOL isMediaMessage = [messagecell isMediaMessage];
    
    NSString *cellIdentifier = nil;
    if (isMediaMessage) {
        cellIdentifier = isOutgoingMessage ? self.outgoingMediaCellIdentifier : self.incomingMediaCellIdentifier;
    }
    else {
        cellIdentifier = isOutgoingMessage ? self.outgoingCellIdentifier : self.incomingCellIdentifier;
    }
    
    ZHCMessagesTableViewCell *cell = [self.messageTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!isMediaMessage) {
        cell.textView.text = [messagecell text];
        NSParameterAssert(cell.textView.text != nil);
    }
    return cell;
    
}



#pragma mark - TableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}





#pragma mark - ZHCMessagesTableViewDataSource

- (NSString *)senderDisplayName
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (NSString *)senderId
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (id<ZHCMessageData>)tableView:(ZHCMessagesTableView*)tableView messageDataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

-(void)tableView:(ZHCMessagesTableView *)tableView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
}




- (nullable id<ZHCMessageBubbleImageDataSource>)tableView:(ZHCMessagesTableView *)tableView messageBubbleImageDataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
    
}

- (nullable id<ZHCMessageAvatarImageDataSource>)tableView:(ZHCMessagesTableView *)tableView avatarImageDataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}


-(NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}


-(NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}


- (NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
    
}

#pragma mark - Adjusting cell label heights

-(CGFloat)tableView:(ZHCMessagesTableView *)tableView tableViewCellSeparatorHeightAtIndexpath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 5.0f;
    }else{
        return kZHCMessagesTableViewCellSpaceDefault;
    }
}


-(CGFloat)tableView:(ZHCMessagesTableView *)tableView heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}


-(CGFloat)tableView:(ZHCMessagesTableView *)tableView  heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
    
}


-(CGFloat)tableView:(ZHCMessagesTableView *)tableView  heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0.0f;
}


#pragma mark - ZHCMessagesTableViewDelegate
-(void)tableView:(ZHCMessagesTableView *)tableView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath
{
    [self recoverMessageInputToolBar];
}


-(void)tableView:(ZHCMessagesTableView *)tableView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath
{
    [self recoverMessageInputToolBar];
    
    
}


-(void)tableView:(ZHCMessagesTableView *)tableView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    [self recoverMessageInputToolBar];
}


-(void)tableView:(ZHCMessagesTableView *)tableView performAction:(SEL)action forcellAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    
    
}


#pragma mark - Public Methods
-(void)recoverMessageInputToolBar
{
    if (self.messagesMoreViewBottomConstraint.constant != kZHCMessagesFunctionViewHeight) {
        self.messagesMoreViewBottomConstraint.constant = kZHCMessagesFunctionViewHeight;
    }
    if (self.messagesEmojiViewBottomContraint.constant != kZHCMessagesFunctionViewHeight) {
        self.messagesEmojiViewBottomContraint.constant = kZHCMessagesFunctionViewHeight;
    }
    if ([self.inputMessageBarView.contentView.textView isFirstResponder]) {
        [self.inputMessageBarView.contentView.textView resignFirstResponder];
    }else{
        [self zhc_updateInputViewBottomConstraint:0];
        
    }
    ZHCWeakSelf;
    [UIView animateWithDuration:0.25 animations:^{
        [weakSelf zhc_setTableViewInsetsTopValue:self.messageTableView.contentInset.top bottomValue:self.inputMessageBarView.preferredDefaultHeight];
        [weakSelf.view layoutIfNeeded];
    }];
    
}



-(void)showEmojiView
{
    self.showFunctionViewBool = YES;
    self.messagesEmojiViewBottomContraint.constant = 0.0f;
    [self.view bringSubviewToFront:self.messageEmojiView];
    self.inputViewBottomLayoutGuide.constant = kZHCMessagesFunctionViewHeight;
    if (self.messagesMoreViewBottomConstraint.constant != kZHCMessagesFunctionViewHeight) {
        self.messagesMoreViewBottomConstraint.constant = kZHCMessagesFunctionViewHeight;
    }
    ZHCWeakSelf;
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [weakSelf zhc_setTableViewInsetsTopValue:self.messageTableView.contentInset.top
                                                      bottomValue:(kZHCMessagesFunctionViewHeight+self.inputMessageBarView.preferredDefaultHeight)];
                         [weakSelf.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         weakSelf.showFunctionViewBool = NO;
                         [weakSelf scrollToBottomAnimated:YES];
                     }];
    
}

-(void)hiddenEmojiView
{
    if (_messageEmojiView && self.messagesEmojiViewBottomContraint.constant != kZHCMessagesFunctionViewHeight) {
        self.messagesEmojiViewBottomContraint.constant = kZHCMessagesFunctionViewHeight;
        ZHCWeakSelf;
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf.view layoutIfNeeded];
        }];
    }
    
}



-(void)showMoreView
{
    self.showFunctionViewBool = YES;
    self.messagesMoreViewBottomConstraint.constant = 0.0f;
    [self.view bringSubviewToFront:self.messageMoreView];
    self.inputViewBottomLayoutGuide.constant = kZHCMessagesFunctionViewHeight;
    if (self.messagesEmojiViewBottomContraint.constant != kZHCMessagesFunctionViewHeight) {
        self.messagesEmojiViewBottomContraint.constant = kZHCMessagesFunctionViewHeight;
    }
    ZHCWeakSelf;
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [weakSelf zhc_setTableViewInsetsTopValue:self.messageTableView.contentInset.top
                                                      bottomValue:(kZHCMessagesFunctionViewHeight+self.inputMessageBarView.preferredDefaultHeight)];
                         [weakSelf.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         weakSelf.showFunctionViewBool = NO;
                         [weakSelf scrollToBottomAnimated:YES];
                     }];
}

-(void)hiddenMoreView
{
    if (_messageMoreView &&  self.messagesMoreViewBottomConstraint.constant != kZHCMessagesFunctionViewHeight) {
        self.messagesMoreViewBottomConstraint.constant = kZHCMessagesFunctionViewHeight;
        ZHCWeakSelf;
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf.view layoutIfNeeded];
        }];
    }
}


#pragma mark ScrollView delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.messageTableView) {
        [self recoverMessageInputToolBar];
    }
}


#pragma mark - InputView utilities
-(void)zhc_updateInputViewBottomConstraint:(CGFloat)constant
{
    self.inputViewBottomLayoutGuide.constant = constant;
}

#pragma mark - TableView utilities

- (void)zhc_updateTableViewInsets
{
    [self zhc_setTableViewInsetsTopValue:self.topLayoutGuide.length + self.topContentAdditionalInset
                             bottomValue:CGRectGetMaxY(self.messageTableView.frame) - CGRectGetMinY(self.inputMessageBarView.frame)];
}

- (void)zhc_setTableViewInsetsTopValue:(CGFloat)top bottomValue:(CGFloat)bottom
{
    bottom = bottom +10;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, 0.0f, bottom, 0.0f);
    self.messageTableView.contentInset = insets;
    self.messageTableView.scrollIndicatorInsets = insets;
    
}

- (BOOL)zhc_isMenuVisible
{
    //  check if cell copy menu is showing
    //  it is only our menu if `selectedIndexPathForMenu` is not `nil`
    return self.selectedIndexPathForMenu != nil && [[UIMenuController sharedMenuController] isMenuVisible];
}



#pragma mark - ZHCMessagesInputToolbarDelegate
- (void)messagesInputToolbar:(ZHCMessagesInputToolbar *)toolbar didPressRightBarButton:(UIButton *)sender
{
    if (sender.selected) {
        [self showMoreView];
    }else{
        [self hiddenMoreView];
        [self.inputMessageBarView.contentView.textView becomeFirstResponder];
    }
    
    
}

- (void)messagesInputToolbar:(ZHCMessagesInputToolbar *)toolbar didPressLeftBarButton:(UIButton *)sender
{
    [self recoverMessageInputToolBar];
}


-(void)messagesInputToolbar:(ZHCMessagesInputToolbar *)toolbar didPressMiddelBarButton:(UIButton *)sender
{
    if (sender.selected) {
        [self showEmojiView];
    }else{
        [self hiddenEmojiView];
        [self.inputMessageBarView.contentView.textView becomeFirstResponder];
    }
}

-(void)messagesInputToolbar:(ZHCMessagesInputToolbar *)toolbar sendVoice:(NSString *)voiceFilePath seconds:(NSTimeInterval)senconds
{
    
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
}

- (NSString *)zhc_currentlyComposedMessageText
{
    //  auto-accept any auto-correct suggestions
    [self.inputMessageBarView.contentView.textView.inputDelegate selectionWillChange:self.inputMessageBarView.contentView.textView];
    [self.inputMessageBarView.contentView.textView.inputDelegate selectionDidChange:self.inputMessageBarView.contentView.textView];
    
    return [self.inputMessageBarView.contentView.textView.text zhc_stringByTrimingWhitespace];
}

#pragma mark - Input
/**
 *  This can't set
 */
//- (UIView *)inputAccessoryView
//{
//    return self.inputMessageBarView;
//}
//
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}


#pragma mark - ZHCMessagesMoreViewDataSource
-(NSArray *)messagesMoreViewTitles:(ZHCMessagesMoreView *)moreView
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}


-(NSArray *)messagesMoreViewImgNames:(ZHCMessagesMoreView *)moreView
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

#pragma mark - ZHCMessagesMoreViewDelegate

-(void)messagesMoreView:(ZHCMessagesMoreView *)moreView selectedMoreViewItemWithIndex:(NSInteger)index
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    
}


#pragma mark - ZHCEmojiViewDelegate
-(void)emojiView:(ZHCMessagesEmojiView *)emojiView didSelectEmoji:(NSString *)emoji
{
    self.inputMessageBarView.contentView.textView.text = [self.inputMessageBarView.contentView.textView.text stringByAppendingString:emoji];
}


-(void)emojiView:(ZHCMessagesEmojiView *)emojiView didPressDeleteButton:(UIButton *)deletebutton
{
    if (self.inputMessageBarView.contentView.textView.text.length > 0) {
        NSRange lastRange = [self.inputMessageBarView.contentView.textView.text rangeOfComposedCharacterSequenceAtIndex:(self.inputMessageBarView.contentView.textView.text.length-1)];
        self.inputMessageBarView.contentView.textView.text = [self.inputMessageBarView.contentView.textView.text substringToIndex:lastRange.location];
    }
    
}

-(void)emojiView:(ZHCMessagesEmojiView *)emojiView didPressSendButton:(UIButton *)sendButton
{
    if ([self.inputMessageBarView.contentView.textView.text zhc_stringByTrimingWhitespace].length>0) {
        [self didPressSendButton:nil
                 withMessageText:[self zhc_currentlyComposedMessageText]
                        senderId:[self.messageTableView.dataSource senderId]
               senderDisplayName:[self.messageTableView.dataSource senderDisplayName]
                            date:[NSDate date]];
    }
    
    
}



#pragma mark - Text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView != self.inputMessageBarView.contentView.textView) {
        return;
    }
    
    [textView becomeFirstResponder];
    
    if (self.automaticallyScrollsToMostRecentMessage) {
        [self scrollToBottomAnimated:YES];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView != self.inputMessageBarView.contentView.textView) {
        return;
    }
    
    [self.inputMessageBarView toggleSendButtonEnabled];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView != self.inputMessageBarView.contentView.textView) {
        return;
    }
    
    [textView resignFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if ([textView.text zhc_stringByTrimingWhitespace].length>0) {
            [self didPressSendButton:nil
                     withMessageText:[self zhc_currentlyComposedMessageText]
                            senderId:[self.messageTableView.dataSource senderId]
                   senderDisplayName:[self.messageTableView.dataSource senderDisplayName]
                                date:[NSDate date]];
        }
        
        return NO;
    }
    return YES;
}

#pragma mark - Notifications

- (void)didReceiveMenuWillShowNotification:(NSNotification *)notification
{
    if (!self.selectedIndexPathForMenu) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillShowMenuNotification
                                                  object:nil];
    
    UIMenuController *menu = [notification object];
    [menu setMenuVisible:NO animated:NO];
    
    ZHCMessagesTableViewCell *selectedCell = (ZHCMessagesTableViewCell *)[self.messageTableView cellForRowAtIndexPath:self.selectedIndexPathForMenu];
    CGRect selectedCellMessageBubbleFrame = [selectedCell convertRect:selectedCell.messageBubbleContainerView.frame toView:self.view];
    
    [menu setTargetRect:selectedCellMessageBubbleFrame inView:self.view];
    [menu setMenuVisible:YES animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMenuWillShowNotification:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:nil];
}

- (void)didReceiveMenuWillHideNotification:(NSNotification *)notification
{
    if (!self.selectedIndexPathForMenu) {
        return;
    }
    
    //  per comment above in 'shouldShowMenuForItemAtIndexPath:'
    //  re-enable 'selectable', thus re-enabling data detectors if present
    ZHCMessagesTableViewCell *selectedCell = (ZHCMessagesTableViewCell *)[self.messageTableView cellForRowAtIndexPath:self.selectedIndexPathForMenu];
    selectedCell.textView.selectable = YES;
    self.selectedIndexPathForMenu = nil;
}



#pragma mark - Utilities
- (void)zhc_registerForNotifications:(BOOL)registerForNotifications
{
    if (registerForNotifications) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhc_keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhc_keyboardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(zhc_didReceiveKeyboardWillChangeFrameNotification:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMenuWillShowNotification:)
                                                     name:UIMenuControllerWillShowMenuNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMenuWillHideNotification:)
                                                     name:UIMenuControllerWillHideMenuNotification
                                                   object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillShowNotification
                                                      object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillHideNotification
                                                      object:nil];
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillChangeFrameNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIMenuControllerWillShowMenuNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIMenuControllerWillHideMenuNotification
                                                      object:nil];
    }
}

-(void)zhc_keyboardWillShown:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGSize size = keyboardEndFrame.size;
    if (CGRectIsNull(keyboardEndFrame)) {
        return;
    }
    
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSInteger animationCurveOption = (animationCurve << 16);
    
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    ZHCWeakSelf;
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurveOption
                     animations:^{
                         [weakSelf zhc_updateInputViewBottomConstraint:size.height];
                         [weakSelf zhc_setTableViewInsetsTopValue:self.messageTableView.contentInset.top
                                                      bottomValue:self.inputMessageBarView.preferredDefaultHeight+size.height];
                         [weakSelf.view layoutIfNeeded];
                         
                     }
                     completion:nil];
    
}


-(void)zhc_keyboardWillHiden:(NSNotification *)notification
{
    if (self.showFunctionViewBool) {
        return;
    }
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (CGRectIsNull(keyboardEndFrame)) {
        return;
    }
    
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSInteger animationCurveOption = (animationCurve << 16);
    
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    ZHCWeakSelf;
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurveOption
                     animations:^{
                         [weakSelf zhc_updateInputViewBottomConstraint:0];
                         [weakSelf zhc_setTableViewInsetsTopValue:self.messageTableView.contentInset.top
                                                  bottomValue:self.inputMessageBarView.preferredDefaultHeight];
                         [weakSelf.view layoutIfNeeded];
                         
                     }
                     completion:nil];
}

- (void)zhc_didReceiveKeyboardWillChangeFrameNotification:(NSNotification *)notification
{
    if (self.showFunctionViewBool) {
        return;
    }
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (CGRectIsNull(keyboardEndFrame)) {
        return;
    }
    
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSInteger animationCurveOption = (animationCurve << 16);
    
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    ZHCWeakSelf;
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurveOption
                     animations:^{
                         [weakSelf zhc_updateInputViewBottomConstraint:CGRectGetHeight(keyboardEndFrame)];
                         [weakSelf zhc_setTableViewInsetsTopValue:self.messageTableView.contentInset.top
                                                  bottomValue:CGRectGetHeight(keyboardEndFrame)];
                         [weakSelf.view layoutIfNeeded];
                     }
                     completion:nil];
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
