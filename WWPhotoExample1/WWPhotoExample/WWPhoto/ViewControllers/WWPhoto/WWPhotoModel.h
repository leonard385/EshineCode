//
//  WWPhotoModel.h
//  WWPhotoExample
//
//  Created by eshine on 16/7/12.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWPhotoModel : NSObject
/**
 *  图片路径数组
 */
@property(nonatomic,strong) NSMutableArray *ImageFilePaths;
/**
 *  压缩的图片数组（用于上传）
 */
@property(nonatomic,strong)NSMutableArray *SelectedPhotosArray;
/**
 *  图片路径
 */
@property(nonatomic,strong)NSString *DocumentsPathString;
/**
 *  图片数组（用于展示）
 */
@property(nonatomic,strong)NSMutableArray *photoArray;

/**
 *  添加图片
 *
 *  @param image 图片
 */
- (void)addImage:(id)image;

/**
 *  添加压缩图片
 *
 *  @param image 压缩图片
 */
- (void)addSelectImage:(id)image;

/**
 *  添加图片路径
 *
 *  @param fileName 文件名
 */
- (void)addImageFilePath:(NSString*)fileName;

+(instancetype)shareMannager;

@end
