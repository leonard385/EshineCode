//
//  WFPhotoAlbum.h
//  WFPhotoPicker
//
//  Created by  Asura on 16/9/4.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFCacheModel.h"
#import <Photos/Photos.h>

@interface WFPhotoAlbum : NSObject


/**
 单例

 @return 返回一个单例
 */
+ (WFPhotoAlbum *)standarWFPhotosAlbum;

/**
 获取相册的方法

 @param success 成功获取到模型 model
 */
- (void)getCameraSuccess:(void (^)(WFCacheModel *))success;

/**
 用一个 result 对象获取关系到模型中的模型数组

 @param result     PHFetchResult/ALAssetsLibrary 对象
 @param completion 成功回调
 */
- (void)getAssetsFromFetchResult:(id)result
                         completion:(void (^)(NSArray <WFAlumbModel *> *))completion;

/**
 获取具体的图片

 @param asset         PHAsset/ALAsset 对象
 @param originalImage 是否是原图(YES为原图. NO 为缩略图.默认我 NO)
 @param completion     成功的回调

 @return 唯一地标识一个可删除的异步请求
 */
- (PHImageRequestID)getPhotosWithAsset:(id)asset
                         originalImage:(BOOL)originalImage
                            completion:(void (^)(UIImage *image))completion;


@end
