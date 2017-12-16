//
//  UIImage+WLCompress.h
//  JYParent
//
//  Created by 倪望龙 on 2017/12/16.
//  Copyright © 2017年 互动家园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WLCompress)
/*
 *  压缩图片方法(先压缩质量再压缩尺寸)
 */
-(NSData *)compressWithLengthLimit:(NSUInteger)maxLength;
/*
 *  压缩图片方法(压缩质量)
 */
-(NSData *)compressQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩质量二分法)
 */
-(NSData *)compressMidQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩尺寸)
 */
-(NSData *)compressBySizeWithLengthLimit:(NSUInteger)maxLength;
@end
