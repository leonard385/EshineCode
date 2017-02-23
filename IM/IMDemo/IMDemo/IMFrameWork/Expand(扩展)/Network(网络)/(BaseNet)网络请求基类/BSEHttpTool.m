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
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSLog(@"url:%@\nparas:%@",url,params);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    mgr.requestSerializer.timeoutInterval = 60.0f;

    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success)
        {
            success(responseObject);
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
        {
            failure(error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        for(MMSFormData *formData in formDataArray)
        {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success)
        {
            success(responseObject);
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
        {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }];
    
}

+(void)postImageWithURL:(NSString *)url
            params:(NSDictionary *)params
          formData:(MMSFormData *)formDate
           success:(void (^)(id))success
          progress:(void (^)(long long totalBytesWritten,long long totalBytesExpectedToWrite))progress
           failure:(void (^)(NSError *))failure
{
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    // 2. Create an `NSMutableURLRequest`.
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST"
                                     URLString:url
                                    parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                         [formData appendPartWithFileData:formDate.data
                                                     name:formDate.name
                                                 fileName:formDate.filename
                                                 mimeType:formDate.mimeType];
                     }];
    
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         NSLog(@"Success %@", responseObject);
                                         success?success(responseObject):nil;
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Failure %@", error.description);
                                         failure?failure(error):nil;
                                     }];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);//所有的  剩下的
        progress?progress(totalBytesWritten,totalBytesExpectedToWrite):nil;
    }];
    
    // 5. Begin!
    [operation start];
}


+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    mgr.requestSerializer.timeoutInterval = 10.0f;
    // 2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation);
        if(success)
        {
            success(responseObject);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
        responseObject = nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
        {
            failure(error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }];
}

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

//字典类型转化成 xxx=value &B=value格式字符串
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


