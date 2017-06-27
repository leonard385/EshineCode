//
//  WFCacheModel.h
//  WFPhotoPicker
//
//  Created by 赚发2 on 16/9/13.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WFAlumbModel : NSObject

/**
 存储 PHAsset/ALAsset 对象
 */
@property (nonatomic, strong) id asset;

/**
 实例方法

 @param asset PHAsset/ALAsset 对象

 @return 返回一个实例
 */
+ (instancetype)modelWithAsset:(id)asset;

@end

@interface WFCacheModel : NSObject

/**
 存储 PHFetchResult/ALAssetsLibrary 对象
 */
@property (nonatomic, strong) id result;

/**
 存储 WFAlumbMode的 数组
 */
@property (nonatomic, strong) NSArray *models;


@end
