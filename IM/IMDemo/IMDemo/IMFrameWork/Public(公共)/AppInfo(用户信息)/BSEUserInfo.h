//
//  BSEUserInfo.h
//  BSEM
//
//  Created by 逸信Mac on 16/3/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSEUserInfo : NSObject
//学生ID信息
@property(nonatomic,strong)NSNumber *StudentID;
//学生学校信息ID
@property(nonatomic,strong)NSNumber *schoolId;
//学校名称
@property(nonatomic,strong)NSString *schoolName;
//班级信息ID
@property(nonatomic,strong)NSNumber *classId;
//用户名称
@property(nonatomic,strong)NSString *userName;//学生名
//密码
@property(nonatomic,strong)NSString *PassWord;
//用户名
@property(nonatomic,strong)NSString *userCode;
//sessionID
@property(nonatomic,strong)NSString *sessionID;

//用户头像图片地址
@property(nonatomic,strong)NSString *headPicPath;
// email
@property (nonatomic, strong) NSString *email;
// mobile
@property (nonatomic, strong) NSString *mobile;

//班级
@property (nonatomic, strong) NSString *className;


+(instancetype)shareMannager;
-(instancetype)initWithDic:(NSDictionary *)Dic;

//用户相关数据存入本地


@end
