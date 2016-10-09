//
//  ZHCMessagesBubbleCalculator.m
//  ZHChat
//
//  Created by aimoke on 16/8/11.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesBubbleCalculator.h"
#import "UIImage+ZHCMessages.h"
#import "ZHCMessagesTableviewLayoutAttributes.h"
#import "ZHCMessagesTableViewCell.h"

@interface ZHCMessagesBubbleCalculator()
@property (strong, nonatomic, readonly) NSCache *cache;

@property (assign, nonatomic, readonly) NSUInteger minimumBubbleWidth;

@property (assign, nonatomic, readonly) BOOL usesFixedWidthBubbles;

@property (assign, nonatomic, readonly) NSInteger additionalInset;

@property (assign, nonatomic) CGFloat layoutWidthForFixedWidthBubbles;
@end


@implementation ZHCMessagesBubbleCalculator
#pragma mark - Init

- (instancetype)initWithCache:(NSCache *)cache
           minimumBubbleWidth:(NSUInteger)minimumBubbleWidth
        usesFixedWidthBubbles:(BOOL)usesFixedWidthBubbles
{
    NSParameterAssert(cache != nil);
    NSParameterAssert(minimumBubbleWidth > 0);
    
    self = [super init];
    if (self) {
        _cache = cache;
        _minimumBubbleWidth = minimumBubbleWidth;
        _usesFixedWidthBubbles = usesFixedWidthBubbles;
        _layoutWidthForFixedWidthBubbles = 0.0f;
        
        // this extra inset value is needed because `boundingRectWithSize:` is slightly off
        // see comment below
        _additionalInset = 4;
    }
    return self;
}

- (instancetype)init
{
    NSCache *cache = [NSCache new];
    cache.name = @"ZHCMessagesBubblesSizeCalculator.cache";
    cache.countLimit = 200;
    return [self initWithCache:cache
            minimumBubbleWidth:[UIImage zhc_getBubbleCommpactImage].size.width
         usesFixedWidthBubbles:NO];
}



#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: cache=%@, minimumBubbleWidth=%@ usesFixedWidthBubbles=%@>",
            [self class], self.cache, @(self.minimumBubbleWidth), @(self.usesFixedWidthBubbles)];
}

#pragma mark - Public Methds
-(void)prepareForResettingLayoutWithTableView:(ZHCMessagesTableView *)tableView
{
    [self.cache removeAllObjects];
}

-(CGSize)messageBubbleSizeForMessageData:(id<ZHCMessageData>)messageData atIndexPath:(NSIndexPath *)indexPath withTableView:(ZHCMessagesTableView *)tableView
{
    NSValue *cachedSize = [self.cache objectForKey:@([messageData messageHash])];
    if (cachedSize != nil) {
        return [cachedSize CGSizeValue];
    }
     CGSize finalSize = CGSizeZero;
    if ([messageData isMediaMessage]) {
        finalSize = [[messageData media] mediaViewDisplaySize];
    }else{
        ZHCMessagesTableviewLayoutAttributes *attributes = tableView.tableViewLayout;
        
        CGFloat textViewHorizontallySpaceWithAvatar = attributes.textViewTextFrameInsets.right;
       
        CGFloat bubbleWidth = attributes.messageBubbleContainerViewWidth;
        CGFloat maxTextViewWidth = 0.0;
        maxTextViewWidth = bubbleWidth - (textViewHorizontallySpaceWithAvatar + attributes.textViewTextContainerInsets.left + attributes.textViewTextContainerInsets.right);
       
      CGRect stringRect = [[messageData text]boundingRectWithSize:CGSizeMake(maxTextViewWidth, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{ NSFontAttributeName : attributes.messageBubbleFont } context:nil];
        
//        ZHCMessagesTableViewCell *cell = [tableView messageTableViewDequeueReusableCellWithIndexPath:indexPath];
//        cell.textView.font = attributes.messageBubbleFont;
//        CGSize stringSize = [cell.textView sizeThatFits:CGSizeMake(maxTextViewWidth, CGFLOAT_MAX)];
//        stringSize.height = cell.textView.contentSize.height;
//        NSLog(@"stringSize:%f",stringSize.height);
        
        
        CGSize stringSize = CGRectIntegral(stringRect).size;
        
        CGFloat verticalContainerInsets = attributes.textViewTextFrameInsets.top + attributes.textViewTextFrameInsets.bottom  + attributes.textViewTextContainerInsets.bottom + attributes.textViewTextContainerInsets.top;
        
        //  same as above, an extra 2 points of magix
        CGFloat verticalInsets = verticalContainerInsets + self.additionalInset;
        
        CGFloat horizontalInsetsTotal = attributes.textViewTextFrameInsets.right + attributes.textViewTextFrameInsets.left + attributes.textViewTextContainerInsets.left + attributes.textViewTextContainerInsets.right;
        
        
        CGFloat finalWidth = MAX(stringSize.width + horizontalInsetsTotal, self.minimumBubbleWidth) + self.additionalInset;
        
         finalSize = CGSizeMake(finalWidth, stringSize.height + verticalInsets);
         
    }
    [self.cache setObject:[NSValue valueWithCGSize:finalSize] forKey:@([messageData messageHash])];
    
    return finalSize;


}


#pragma mark Utilities
- (CGSize)zhc_avatarSizeForMessageData:(id<ZHCMessageData>)messageData withTableView:(ZHCMessagesTableView *)tableView

{
    NSString *messageSender = [messageData senderId];
    ZHCMessagesTableviewLayoutAttributes *attributes = tableView.tableViewLayout;
    
    if ([messageSender isEqualToString:[tableView.dataSource senderId]]) {
        return attributes.outgoingAvatarViewSize;
    }
    
    return attributes.incomingAvatarViewSize;
}

@end
