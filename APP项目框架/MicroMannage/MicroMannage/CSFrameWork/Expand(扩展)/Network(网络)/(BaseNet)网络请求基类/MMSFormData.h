//
//  MMSFormData.h
//  qosIos
//
//  Created by 逸信Mac on 15/12/28.
//  Copyright © 2015年 eshine. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  用来封装文件数据的模型
 */


@interface MMSFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end


