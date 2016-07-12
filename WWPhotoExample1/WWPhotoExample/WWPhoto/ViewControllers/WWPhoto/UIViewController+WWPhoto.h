//
//  UIViewController+WWPhoto.h
//  WWPhotoExample
//
//  Created by eshine on 16/7/12.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^OpenPhotoBlock)(NSUInteger PhotoNum);
typedef void(^OpenCamreBlock)();
typedef void(^photoBlock)(UIImage *photo);

@interface UIViewController (WWPhoto)
/**
 *  图片路径数组
 */
@property(nonatomic,strong) NSMutableArray *ImgFilePaths;
/**
 *  压缩的图片数组（用于上传）
 */
@property(nonatomic,strong)NSMutableArray *SelectedPhotos;
/**
 *  图片路径
 */
@property(nonatomic,strong)NSString *DocumentsPath;
/**
 *  图片数组（用于展示）
 */
@property(nonatomic,strong)NSMutableArray *photosArray;

/**
 *  返回图片代理
 */
@property (nonatomic,copy)photoBlock photoBlock;

/**
 *  打开相机和相册的代理方法
 *
 *  @param openCamre 打开相机
 *  @param openPhoto 打开相册
 */
-(void)setOpenCamreBlock:(OpenCamreBlock)openCamre OpenPhotoBlock:(OpenPhotoBlock)openPhoto;

/**
 *  打开相册
 */
-(void)MMSOPenPotoLib;

/**
 *  打开相机
 */
-(void)OpenCamera;

@end
