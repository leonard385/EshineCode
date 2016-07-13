//
//  WWPhotoModel.m
//  WWPhotoExample
//
//  Created by eshine on 16/7/12.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "WWPhotoModel.h"

@implementation WWPhotoModel
+(instancetype)shareMannager
{
    static WWPhotoModel *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[[self class]alloc]init];
    });
    return share;
}

-(instancetype)init
{
    self = [super init];
    if(self){
        //数据初始化
    }
    return self;
}

- (NSMutableArray *)photoArray
{
    if (!_photoArray) {
        _photoArray = [NSMutableArray new];
    }
    
    return _photoArray;
}

- (NSMutableArray *)ImageFilePaths
{
    if (!_ImageFilePaths) {
        _ImageFilePaths = [NSMutableArray new];
    }
    
    return _ImageFilePaths;
}

- (NSMutableArray *)SelectedPhotosArray
{
    if (!_SelectedPhotosArray) {
        _SelectedPhotosArray = [NSMutableArray new];
    }
    
    return _SelectedPhotosArray;
}

- (void)addImage:(id)image
{
    [self.photoArray addObject:image];
}

- (void)addSelectImage:(id)image
{
    [self.SelectedPhotosArray addObject:image];
}

- (void)addImageFilePath:(NSString*)fileName
{
    [self.ImageFilePaths addObject:fileName];

}


@end
