//
//  ZHCMessagesLabel.h
//  ZHChat
//
//  Created by aimoke on 16/8/9.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHCMessagesLabel : UILabel
/**
 *  The inset of the text layout area within the label's content area. The default value is `UIEdgeInsetsZero`.
 *
 *  @discussion This property provides text margins for the text laid out in the label.
 *  The inset values provided must be greater than or equal to `0.0f`.
 */
@property (assign, nonatomic) UIEdgeInsets textInsets;
@end
