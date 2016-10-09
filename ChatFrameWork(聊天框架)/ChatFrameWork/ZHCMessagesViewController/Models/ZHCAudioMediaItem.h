//
//  ZHCAudioMediaItem.h
//  ZHChat
//
//  Created by aimoke on 16/8/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMediaItem.h"
#import "ZHCAudioMediaViewAttributes.h"

#import <AVFoundation/AVFoundation.h>
@class ZHCAudioMediaItem;
NS_ASSUME_NONNULL_BEGIN

@protocol ZHCAudioMediaItemDelegate <NSObject>

/**
 *  Tells the delegate if the specified `ZHCAudioMediaItem` changes the sound category or categoryOptions, or if an error occurs.
 */
- (void)audioMediaItem:(ZHCAudioMediaItem *)audioMediaItem
didChangeAudioCategory:(NSString *)category
               options:(AVAudioSessionCategoryOptions)options
                 error:(nullable NSError *)error;

@end


/**
 *  The `ZHCAudioMediaItem` class is a concrete `ZHCMediaItem` subclass that implements the `ZHCMessageMediaData` protocol
 *  and represents an audio media message. An initialized `ZHCAudioMediaItem` object can be passed
 *  to a `ZHCMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `ZHCAudioMediaItem` to provide additional functionality or behavior.
 */
@interface ZHCAudioMediaItem : ZHCMediaItem<ZHCMessageMediaData, AVAudioPlayerDelegate, NSCoding, NSCopying>
/**
 *  The delegate object for audio event notifications.
 */
@property (nonatomic, weak, nullable) id<ZHCAudioMediaItemDelegate> delegate;

/**
 *  The view attributes to configure the appearance of the audio media view.
 */
@property (nonatomic, strong, readonly) ZHCAudioMediaViewAttributes *audioViewAttributes;

/**
 *  A data object that contains an audio resource.
 */
@property (nonatomic, strong, nullable) NSData *audioData;

/**
 *  Initializes and returns a audio media item having the given audioData.
 *
 *  @param audioData              The data object that contains the audio resource.
 *  @param audioViewConfiguration The view attributes to configure the appearance of the audio media view.
 *
 *  @return An initialized `ZHCAudioMediaItem`.
 *
 *  @discussion If the audio must be downloaded from the network,
 *  you may initialize a `ZHCVideoMediaItem` with a `nil` audioData.
 *  Once the audio is available you can set the `audioData` property.
 */
- (instancetype)initWithData:(nullable NSData *)audioData
         audioViewAttributes:(ZHCAudioMediaViewAttributes *)audioViewAttributes NS_DESIGNATED_INITIALIZER;

/**
 *  Initializes and returns a default audio media item.
 *
 *  @return An initialized `ZHCAudioMediaItem`.
 *
 *  @discussion You must set `audioData` to enable the play button.
 */
- (instancetype)init;

/**
 Initializes and returns a default audio media using the specified view attributes.
 
 @param audioViewAttributes The view attributes to configure the appearance of the audio media view.
 
 @return  An initialized `ZHCAudioMediaItem`.
 */
- (instancetype)initWithAudioViewAttributes:(ZHCAudioMediaViewAttributes *)audioViewAttributes;

/**
 *  Initializes and returns an audio media item having the given audioData.
 *
 *  @param audioData The data object that contains the audio resource.
 *
 *  @return An initialized `ZHCAudioMediaItem`.
 *
 *  @discussion If the audio must be downloaded from the network,
 *  you may initialize a `ZHCAudioMediaItem` with a `nil` audioData.
 *  Once the audio is available you can set the `audioData` property.
 */
- (instancetype)initWithData:(nullable NSData *)audioData;

/**
 *  Sets or updates the data object in an audio media item with the data specified at audioURL.
 *
 *  @param audioURL A File URL containing the location of the audio data.
 */
- (void)setAudioDataWithUrl:(nonnull NSURL *)audioURL;



@end
NS_ASSUME_NONNULL_END