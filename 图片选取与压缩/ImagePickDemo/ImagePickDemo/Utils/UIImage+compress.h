//
//  UIImage+compress.h
//  ImagePickDemo
//
//  Created by 倪望龙 on 2017/6/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (compress)
/**
 *  图片压缩
 *
 *  @param image     要被压缩的图片
 *  @param maxLength 目标大小
 *
 *  @return 最终图片
 */
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
@end
