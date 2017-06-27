//
//  WFCacheModel.m
//  WFPhotoPicker
//
//  Created by 赚发2 on 16/9/13.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import "WFCacheModel.h"
#import "WFPhotoAlbum.h"

@implementation WFAlumbModel

+ (instancetype)modelWithAsset:(id)asset{
    WFAlumbModel *model = [[WFAlumbModel alloc] init];
    model.asset = asset;
    return model;
}

@end

@implementation WFCacheModel

- (void)setResult:(id)result{
    _result = result;
    [[WFPhotoAlbum standarWFPhotosAlbum] getAssetsFromFetchResult:result completion:^(NSArray<WFAlumbModel *> *models) {
        _models = models;
    }];
}

@end
