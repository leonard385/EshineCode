//
//  BSEHttpTool.h
//  BSEM
//
//  Created by 逸信Mac on 16/3/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MMSFormData.h"
@interface BSEHttpTool : NSObject
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param progress 进度回掉
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params progress:(void (^)(id))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param progress 进度回调
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params progress:(void (^)(id))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formDataArray  文件参数
 *  @param progress  进度回调
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params progress:(void (^)(id))progress formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure;


//汉字gbk编码传输
+(void)PostHanZi:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


@end


