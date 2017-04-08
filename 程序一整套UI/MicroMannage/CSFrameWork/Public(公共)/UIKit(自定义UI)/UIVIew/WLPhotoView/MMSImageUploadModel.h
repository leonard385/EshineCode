//
//  MMSImageUploadModel.h
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/27.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMSImageUploadModel : NSObject
@property(nonatomic,strong)UIImage *Photo;//图片数据
@property(nonatomic,strong)NSString *PhotoUrl;//图片url

@property(nonatomic,strong)NSNumber* isCommit;//上传状态

@property(nonatomic,strong)NSNumber *ImageID;//图片上传ID

-(instancetype)initWithDic:(NSDictionary *)Dic;
@end
