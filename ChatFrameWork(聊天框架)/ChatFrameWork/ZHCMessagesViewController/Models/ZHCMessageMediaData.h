//
//  ZHCMessageMediaData.h
//  ZHChat
//
//  Created by aimoke on 16/8/11.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZHCMessageMediaData <NSObject>

@required
/**
 *  @return An initialized `UIView` object that represents the data for this media object.
 *
 *  @discussion You may return `nil` from this method while the media data is being downloaded.
 */
- (nullable UIView *)mediaView;


/**
 *  @return The frame size for the mediaView when displayed in a `ZHCMessagesTableViewCell`.
 *
 *  @discussion You should return an appropriate size value to be set for the mediaView's frame
 *  based on the contents of the view, and the frame and layout of the `ZHCMessagesTableViewCell`
 *  in which mediaView will be displayed.
 *
 *  @warning You must return a size with non-zero, positive width and height values.
 */
- (CGSize)mediaViewDisplaySize;


/**
 *  @return A placeholder media view to be displayed if mediaView is not yet available, or `nil`.
 *  For example, if mediaView will be constructed based on media data that must be downloaded,
 *  this placeholder view will be used until mediaView is not `nil`.
 *
 *  @discussion If you do not need support for a placeholder view, then you may simply return the
 *  same value here as mediaView. Otherwise, consider using `ZHCMessagesMediaPlaceholderView`.
 *
 *  @warning You must not return `nil` from this method.
 *
 *  @see ZHCMessagesMediaPlaceholderView.
 */
- (UIView *)mediaPlaceholderView;


/**
 *  @return An integer that can be used as a table address in a hash table structure.
 *
 *  @discussion This value must be unique for each media item with distinct contents.
 *  This value is used to cache layout information in the TableView view.
 */
- (NSUInteger)mediaHash;

@optional
/**
 *  @return String which identifies type of the data returned by `mediaData` method.
 *
 *  @discussion If implemented, you must not return `nil` from this, as well as `copyableData`, method.
 *  This type is frequently, but not necessarily, a UTI (Uniform Type Identifier). It identifies a
 *  representation of the data on the pasteboard. Apps can define their own types for custom data,
 *  however, in this case, only those apps that know of the type could understand the data written to the pasteboard.
 */
- (NSString *)mediaDataType;

/**
 *  @return Data object of class corresponding to type returned by `mediaDataType`.
 *
 *  @discussion You should return an object that is of a class type appropriate to the representation type,
 *  which typically is a UTI.
 */
- (id)mediaData;

@end

NS_ASSUME_NONNULL_END

