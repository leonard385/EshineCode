//
//  RWTFlickrPhoto.h
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrPhoto : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *identifier;
@end
