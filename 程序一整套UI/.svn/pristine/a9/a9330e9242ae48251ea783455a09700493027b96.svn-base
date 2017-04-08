//
//  BSEHttpTool.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//
#import "BSEHttpTool.h"
#import "AFNetworking.h"
@implementation BSEHttpTool
#pragma mark - post请求
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params progress:(void (^)(id))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 20.0f;
    NSLog(@"url:%@\nparas:%@",url,params);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        progress?progress(uploadProgress):nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success?success(responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure?failure(error):nil;
        
    }];
}

#pragma mark - get请求
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params progress:(void (^)(id))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 20.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
         progress?progress(downloadProgress):nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success?success(responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure?failure(error):nil;
    }];
}


#pragma mark  - 上传文件
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params progress:(void (^)(id))progress formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 20.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        for(MMSFormData *formData in formDataArray){
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress?progress(uploadProgress):nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success?success(responseObject):nil;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure?failure(error):nil;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

#pragma mark  - 上传gbk 汉字
+(void)PostHanZi:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"URLString: %@, parameters: %@", URLString, parameters);
    NSString *paras = [self DictionaryToCustomString:parameters];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [urlRequest setHTTPMethod: @"POST"];
    [urlRequest setHTTPBody:[paras dataUsingEncoding:enc]];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(),
        ^{
        if (success) {
            id JsonDate = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            success(JsonDate);
            
        } else {
                   failure(error);
                }
        });
    }];
    [task resume];
}


#pragma mark - 字典转化成 xxx=value &B=value格式字符串
+(NSString *)DictionaryToCustomString:(NSDictionary *)dic
{
    NSArray *keys;
    NSUInteger i, count;
    id key, value;
    
    
    keys = [dic allKeys];
    count = [keys count];
    NSMutableString *totalstr = [[NSMutableString alloc]initWithCapacity:count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dic objectForKey: key];
        if(i==0){
            [totalstr appendFormat:@"%@=%@",key,value];
        }
        else{
            [totalstr appendFormat:@"&%@=%@",key,value];
        }
        NSLog (@"%@",totalstr);
    }
    return totalstr;
}




@end


