//
//  RWTFlickrPhotoMetadata.m
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrPhotoMetadata.h"

@implementation RWTFlickrPhotoMetadata
- (NSString *)description {
    return [NSString stringWithFormat:@"metadata: comments=%lU, faves=%lU",
            self.comments , self.favorites];
}
@end
