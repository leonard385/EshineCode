//
//  ZHCMessagesCommonParameter.h
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#ifndef ZHCMessagesCommonParameter_h
#define ZHCMessagesCommonParameter_h

/**
 *  A constant that describes the default height for all label subviews in a `ZHCMessagesTableViewCell`.
 *
 *  @see ZHCMessagesTableViewCell.
 */
#ifndef kZHCMessagesTableViewCellLabelHeightDefault
#define kZHCMessagesTableViewCellLabelHeightDefault 20.0f
#endif


/**
 *  A constant that describes the default size for avatar images in a `ZHCMessagesTableViewCell`.
 */
#ifndef kZHCMessagesTableViewCellAvatarSizeDefault
#define kZHCMessagesTableViewCellAvatarSizeDefault  30.0f
#endif


/**
 *  A constant that describes the default size for cells space in a `ZHCMessagesTableViewCell`.
 */
#ifndef kZHCMessagesTableViewCellSpaceDefault
#define kZHCMessagesTableViewCellSpaceDefault  15.0f
#endif

/**
 *  A constant that describes the default Height for Show View in 'ZHCMessagesViewController'.
 */
#ifndef kZHCMessagesFunctionViewHeight
#define kZHCMessagesFunctionViewHeight 210.0f
#endif

/**
 *  A color that describes the back color of function View top Line.
 */
#ifndef kZHCTopLineBackGroudColor
#define kZHCTopLineBackGroudColor [UIColor colorWithRed:228.0/255 green:228.0/255 blue:228.0/255 alpha:1.0]
#endif


/**
 * References about his weak variable.
 */
#ifndef ZHCWeakSelf
#define ZHCWeakSelf  typeof(self) __weak weakSelf = self;
#endif

#endif /* ZHCMessagesCommonParameter_h */
