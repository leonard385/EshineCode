//
//  WFPhotoAlbum.m
//  WFPhotoPicker
//
//  Created by  Asura on 16/9/4.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import "WFPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PopView.h"

typedef void(^WFPhotoAlbumSuccess)(WFCacheModel *);
typedef void(^WFPhotoAlbumBlock)();

#define IPHONE_IOS [[[UIDevice currentDevice] systemVersion] floatValue]

@interface WFPhotoAlbum ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) ALAssetsLibrary *ssetLibrary;

@property (nonatomic, copy) WFPhotoAlbumSuccess success;
@property (nonatomic, copy) WFPhotoAlbumBlock modelBlock;

@end

@implementation WFPhotoAlbum

+ (WFPhotoAlbum *)standarWFPhotosAlbum{
    static WFPhotoAlbum *_photosAlbum = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _photosAlbum = [[self alloc] init];
    });
    return _photosAlbum;
}

- (void)getCameraSuccess:(void (^)(WFCacheModel *))success{
    _success = [success copy];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (IPHONE_IOS < 8.0) {
            [self wf_getPhotosBefore];
        }else{
            [self wf_getPhotosLater];
        }
    });
}

- (WFCacheModel *)modelWithResult:(id)result{
    WFCacheModel *model = [[WFCacheModel alloc] init];
    model.result = result;
    return model;
}
- (void)getAssetsFromFetchResult:(id)result
                         completion:(void (^)(NSArray<WFAlumbModel *> *))completion{
    NSMutableArray *photos = [NSMutableArray array];
    if ([result isKindOfClass:[ALAssetsLibrary class]]) {
        [_ssetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) {
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                if (group.numberOfAssets > 0) {
                    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                        //ALAsset的类型
                        NSString *assetType = [result valueForProperty:ALAssetPropertyType];                    if ([assetType isEqualToString:ALAssetTypePhoto]){

                            [photos addObject:[WFAlumbModel modelWithAsset:result]];
                        }
                    }];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion ? completion(photos) : nil;
                        _modelBlock ? _modelBlock() : nil;
                        [PopView dissmissPopview];
                    });
                }
            }else{
                //没有相册列表资源,输出提示
                dispatch_async(dispatch_get_main_queue(), ^{
                    [PopView dissmissPopview];
//                    [PopView initWithTitle:@"提示" content:@"没有相册资源" buttonTitle:@[@"知道了!"] success:^{
//
//                    } failure:^{
//
//                    }];
                });
            }
        } failureBlock:^(NSError *error) {
            
        }];
    }else{
        if ([result isKindOfClass:[PHFetchResult class]]) {
            PHFetchResult *fetchResult = (PHFetchResult *)result;
            [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                PHAsset *asset = (PHAsset *)obj;
                [photos addObject:[WFAlumbModel modelWithAsset:asset]];
                if (fetchResult.count == photos.count) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [PopView dissmissPopview];
                    });
                    completion ? completion(photos) : nil;
                }
            }];
        }
    }
}

- (PHImageRequestID)getPhotosWithAsset:(id)asset
                         originalImage:(BOOL)originalImage
                            completion:(void (^)(UIImage *))completion{
    CGSize size;
    if (originalImage) {
        size = PHImageManagerMaximumSize;
    }else{
        size = CGSizeMake(125 * [UIScreen mainScreen].scale, 125 * [UIScreen mainScreen].scale);
    }
    if ([asset isKindOfClass:[PHAsset class]]) {
        // 修复获取图片时出现的瞬间内存过高问题
        // 下面两行代码，来自hsjcom，他的github是：https://github.com/hsjcom 表示感谢
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        PHImageRequestID imageRequestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
            if (downloadFinined && result) {
                if (!originalImage) {
                    result = [self wf_thumbnailsCutfullPhoto:result];
                }
                completion ? completion(result) : nil;
            }
        }];
        return imageRequestID;
    }else{
        ALAssetRepresentation *assetRepresentation =[asset defaultRepresentation];
        CGImageRef imageReference;
        if (originalImage) {
            imageReference = [assetRepresentation fullScreenImage];
        }else{
            imageReference = ((ALAsset *)asset).thumbnail;
        }
        if (imageReference != nil) completion ? completion([UIImage imageWithCGImage:imageReference]) : nil;
    }
    return 0;
}

- (void)wf_getPhotosBefore{
    //获取当前应用对相册的访问授权状态
    ALAuthorizationStatus authorizationState = [ALAssetsLibrary authorizationStatus];
    // 如果没有获取访问授权，或者访问授权状态已经被明确禁止，则显示提示语，引导用户开启授权
    if (authorizationState == ALAuthorizationStatusRestricted || authorizationState == ALAuthorizationStatusDenied) {
        [self wf_alerPhotos];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [PopView initWithWaitingString:@"加载中..."];
        });
        _ssetLibrary  = [[ALAssetsLibrary alloc] init];
        __block WFCacheModel *model = [self modelWithResult:_ssetLibrary];
        __weak typeof(self)weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.modelBlock = ^(){
              weakSelf.success ? weakSelf.success(model) : nil;
            };
        });
    }
}

- (void)wf_getPhotosLater{
    
    //权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        [self wf_alerPhotos];
    }else{
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [PopView initWithWaitingString:@"加载中..."];
                });
                __block WFCacheModel *model;
                PHFetchOptions *option = [[PHFetchOptions alloc] init];
                option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:NO]];
                
                PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
                for (PHAssetCollection *collection in smartAlbums) {
                    if ([collection.localizedTitle isEqualToString:@"Camera Roll"] || [collection.localizedTitle isEqualToString:@"相机胶卷"] ||  [collection.localizedTitle isEqualToString:@"所有照片"] || [collection.localizedTitle isEqualToString:@"All Photos"]) {
                        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
                        model = [self modelWithResult:fetchResult];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _success ? _success(model) : nil;
                        });
                        break;
                    }
                }
            }
        }];
    }
}

- (void)wf_alerPhotos{
    NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *alerString = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
    // 展示提示语
    dispatch_async(dispatch_get_main_queue(), ^{
        [PopView initWithTitle:@"提示" content:alerString buttonTitle:@[@"知道了!"] success:^{
            
        } failure:^{
            
        }];
    });
}

//裁剪图片,此处裁剪为125*125大的图,即为我们的缩略图
- (UIImage *)wf_thumbnailsCutfullPhoto:(UIImage*)fullPhoto
{
    CGSize newSize;
    CGImageRef imageRef = nil;
    if ((fullPhoto.size.width / fullPhoto.size.height) < 1) {
        newSize.width = fullPhoto.size.width;
        newSize.height = fullPhoto.size.width * 1;
        imageRef = CGImageCreateWithImageInRect([fullPhoto CGImage], CGRectMake(0, fabs(fullPhoto.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = fullPhoto.size.height;
        newSize.width = fullPhoto.size.height * 1;
        imageRef = CGImageCreateWithImageInRect([fullPhoto CGImage], CGRectMake(fabs(fullPhoto.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}
#pragma clang diagnostic pop
@end
