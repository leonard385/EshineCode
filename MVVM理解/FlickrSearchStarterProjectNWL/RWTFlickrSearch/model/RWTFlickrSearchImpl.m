//
//  RWTFlickrSearchImpl.m
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchImpl.h"

//数据模型
#import "RWTFlickrSearchResults.h"
#import "RWTFlickrPhoto.h"

//第三方库头文件
#import <objectiveflickr/ObjectiveFlickr.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>

#import "RWTFlickrPhotoMetadata.h"
#import <ReactiveCocoa/RACEXTScope.h>

@interface RWTFlickrSearchImpl()<OFFlickrAPIRequestDelegate>
@property (strong, nonatomic) NSMutableSet       *requests;
@property (strong, nonatomic) OFFlickrAPIContext *flickrContext;
@end

@implementation RWTFlickrSearchImpl
#pragma mark - 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self){
        _requests = [NSMutableSet new];
        NSString *OFSampleAppAPIKey = @"5a4d8cd6c0e2188a91548580b327cc11";
        NSString *OFSampleAppAPISharedSecret = @"abdffbad2557afd7";
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:OFSampleAppAPIKey sharedSecret:OFSampleAppAPISharedSecret];
    }
    return self;
}


#pragma mark - Filcker基本搜索方法
- (RACSignal *)signalFromAPIMethod:(NSString *)method arguments:(NSDictionary *)args transform:(id (^)(NSDictionary *response))block
{
    // 1. 创建请求信号
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // 2. 创建一个Flick请求对象
        OFFlickrAPIRequest *flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:self.flickrContext];
        flickrRequest.delegate = self;
        [self.requests addObject:flickrRequest];
        
        //错误信号
        RACSignal *errorSignal =
        [self rac_signalForSelector:@selector(flickrAPIRequest:didFailWithError:)
                       fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
        
        [errorSignal subscribeNext:^(RACTuple *tuple) {
            [subscriber sendError:tuple.second];
        }];
        
        //成功请求
        RACSignal *successSignal = [self rac_signalForSelector:@selector(flickrAPIRequest:didCompleteWithResponse:)
                                                  fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
        
        // 4. 处理响应
        @weakify(flickrRequest)
        
        [[[[successSignal
            filter:^BOOL(RACTuple *tuple) {
                @strongify(flickrRequest)
                return tuple.first == flickrRequest;
            }]
           map:^id(RACTuple *tuple) {
               return tuple.second;
           }]
          map:block]
         subscribeNext:^(id x) {  //next 方法(即请求成功)
             [subscriber sendNext:x];//执行next方法   将请求的模型数据传送出去
             [subscriber sendCompleted];
         }];
        // 5. 开始请求
        [flickrRequest callAPIMethodWithGET:method arguments:args];

        // 6. 完成后，移除请求的引用
        return [RACDisposable disposableWithBlock:^{
            [self.requests removeObject:flickrRequest];
        }];
    }];
}


#pragma mark - 图片喜好评论数加载  结果展示页
- (RACSignal *)flickrImageMetadata:(NSString *)photoId {
    
    RACSignal *favorites = [self signalFromAPIMethod:@"flickr.photos.getFavorites"
                                           arguments:@{@"photo_id": photoId}
                                           transform:^id(NSDictionary *response) {
                                               NSString *total = [response valueForKeyPath:@"photo.total"];//json字典数据
                                               return total;
                                           }];
    
    RACSignal *comments = [self signalFromAPIMethod:@"flickr.photos.getInfo"
                                          arguments:@{@"photo_id": photoId}
                                          transform:^id(NSDictionary *response) {
                                              NSString *total = [response valueForKeyPath:@"photo.comments._text"];//json字典数据
                                              return total;
                                          }];
    
    return [RACSignal combineLatest:@[favorites, comments] reduce:^id(NSString *favs, NSString *coms){
        RWTFlickrPhotoMetadata *meta = [RWTFlickrPhotoMetadata new];
        meta.comments = [coms integerValue];
        meta.favorites = [favs integerValue];
        return  meta;
    }];
}

#pragma mark - 首页搜索
- (RACSignal *)flickrSearchSignal:(NSString *)searchString
{
    
    return [self signalFromAPIMethod:@"flickr.photos.search"
                           arguments:@{@"text": searchString,
                                       @"sort": @"interestingness-desc"}
                           transform:^id(NSDictionary *response) {
                               //首页搜索结果
                               RWTFlickrSearchResults *results = [RWTFlickrSearchResults new];
                               results.searchString            = searchString;
                               results.totalResults = [[response valueForKeyPath:@"photos.total"] integerValue];
                               
                               NSArray *photos = [response valueForKeyPath:@"photos.photo"];
                               results.photos =
                                   [photos linq_select:^id(NSDictionary *jsonPhoto) {
                                   //结果展示model
                                   RWTFlickrPhoto *photo = [RWTFlickrPhoto new];
                                   photo.title           = [jsonPhoto objectForKey:@"title"];
                                   photo.identifier      = [jsonPhoto objectForKey:@"id"];
                                   photo.url = [self.flickrContext photoSourceURLFromDictionary:jsonPhoto
                                                                                           size:OFFlickrSmallSize];
                                   return photo;
                               }];
                               
                               return results;
                           }];
}
@end
