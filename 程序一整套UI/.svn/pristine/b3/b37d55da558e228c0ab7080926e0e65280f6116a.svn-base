//
//  AppInfoMacros.h
//  BSEM
//
//  Created by 逸信Mac on 16/3/14.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#ifndef AppInfoMacros_h
#define AppInfoMacros_h
#import <Foundation/Foundation.h>

#define kUserPath   [NSString stringWithFormat:@"%@/%@",[NSFileManager documentsPath],[BSEUserInfo shareMannager].userName]

//考试考题类型
typedef enum : NSUInteger {
    singleSelectionType = 0,//单选
    multipleSelectionType,//多选
     trueOrFalseType,//判断题
} MMExamType;

//考试菜单
typedef enum : NSUInteger {
    ECundoType = 0,//没做
    ECdoAlreadyType,//做了
    ECcurrentType,//当前
} ExamCardCellType;

//测试菜单
typedef enum : NSUInteger {
    TCundoType = 0,//没做
    TCrightType,//正确
    TCfalseType,//错误
    TCcurrentType,//当前
} TestCardCellType;

//工作完成情况
typedef enum : NSUInteger {
    TaskUndoType = 0,//未完成
    TaskProgressType,//进行中
    TaskDoneType,//已完成
} DDTaskType;

//培训文件类型
typedef enum : NSUInteger {
    fileType = 0,//文件类型
    videoType,//视频类型
    linkType,//知识库连接
} trainFileType;

//培训文件类型
typedef enum : NSUInteger {
    normalType = 0,//正常
    lateType,//迟到
    absentType,//缺勤
} OfflineCardType;

#endif /* AppInfoMacros_h */
