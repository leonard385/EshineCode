//
//  ZHCLocationMediaItem.h
//  ZHChat
//
//  Created by aimoke on 16/8/17.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMediaItem.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
/**
 *  A completion handler block for a `ZHCLocationMediaItem`. See `setLocation: withCompletionHandler:`.
 */
typedef void (^ZHCLocationMediaItemCompletionBlock)(void);


NS_ASSUME_NONNULL_BEGIN

/**
 *  The `ZHCLocationMediaItem` class is a concrete `ZHCMediaItem` subclass that implements the `ZHCMessageMediaData` protocol
 *  and represents a location media message. An initialized `ZHCLocationMediaItem` object can be passed
 *  to a `ZHCMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `ZHCLocationMediaItem` to provide additional functionality or behavior.
 */

@interface ZHCLocationMediaItem : ZHCMediaItem<ZHCMessageMediaData, MKAnnotation, NSCoding, NSCopying>

/**
 *  The location for the media item. The default value is `nil`.
 */
@property (copy, nonatomic, nullable) CLLocation *location;

/**
 *  The coordinate of the location property.
 */
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;

/**
 *  Initializes and returns a location media item object having the given location.
 *
 *  @param location The location for the media item. This value may be `nil`.
 *
 *  @return An initialized `ZHCLocationMediaItem`.
 *
 *  @discussion If the location data must be dowloaded from the network,
 *  you may initialize a `ZHCLocationMediaItem` object with a `nil` location.
 *  Once the location data has been retrieved, you can then set the location property
 *  using `setLocation: withCompletionHandler:`
 */
- (instancetype)initWithLocation:(nullable CLLocation *)location;

/**
 *  Sets the specified location for the location media item and immediately begins creating
 *  a map view snapshot image on a background thread. The map view zooms to a default region whose center point
 *  is the location coordinate and whose span is 500 meters for both the latitudinal and longitudinal meters.
 *
 *  The specified block is executed upon completion of creating the snapshot image and is executed on the app’s main thread.
 *
 *  @param location   The location for the media item.
 *  @param completion The block to call after the map view snapshot for the given location has been created.
 */
- (void)setLocation:(nullable CLLocation *)location withCompletionHandler:(nullable ZHCLocationMediaItemCompletionBlock)completion;

/**
 *  Sets the specified location for the location media item and immediately begins creating
 *  a map view snapshot image on a background thread.
 *
 *  The specified block is executed upon completion of creating the snapshot image and is executed on the app’s main thread.
 *
 *  @param location   The location for the media item.
 *  @param region     The map region that you want to capture.
 *  @param completion The block to call after the map view snapshot for the given location has been created.
 */
- (void)setLocation:(nullable CLLocation *)location
             region:(MKCoordinateRegion)region withCompletionHandler:(nullable ZHCLocationMediaItemCompletionBlock)completion;

@end
NS_ASSUME_NONNULL_END