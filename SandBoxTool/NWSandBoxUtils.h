//
//  NSObject+LKUtils.h
//  LKDBHelper
//
//  Created by LJH on 13-4-15.
//  Copyright (c) 2013年 ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWSandBoxUtils : NSObject
///返回根目录路径 "document"
+ (NSString*)getDocumentPath;
///返回 "document/dir/" 文件夹路径
+ (NSString*)getDirectoryForDocuments:(NSString*)dir;
///返回 "document/filename" 路径
+ (NSString*)getPathForDocuments:(NSString*)filename;
///返回 "document/dir/filename" 路径
+ (NSString*)getPathForDocuments:(NSString*)filename inDir:(NSString*)dir;
///文件是否存在
+ (BOOL)isFileExists:(NSString*)filepath;
///删除文件
+ (BOOL)deleteWithFilepath:(NSString*)filepath;
///返回该文件目录下 所有文件名
+ (NSArray*)getFilenamesWithDir:(NSString*)dir;

@end

#ifdef DEBUG
#ifdef NSLog
#define LKErrorLog(fmt, ...) NSLog(@"#LKDBHelper ERROR:\n" fmt, ##__VA_ARGS__);
#else
#define LKErrorLog(fmt, ...) NSLog(@"\n#LKDBHelper ERROR: %s  [Line %d] \n" fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif
#else
#define LKErrorLog(...)
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0 || __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_7
#define LKDBWeak weak
#define __LKDBWeak __weak
#else
#define LKDBWeak unsafe_unretained
#define __LKDBWeak
#endif
