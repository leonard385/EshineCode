//
//  StoreAccount.h
//  jobCompany
//
//  Created by 陈广川 on 16/1/5.
//  Copyright © 2016年 liaolx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountPasswordMannger : NSObject

+ (NSDictionary *)GetAccountAndPassword;
+ (NSDictionary *)GetAccountAndUserProp;

+ (void)SaveAccount:(NSString *)account andPassword:(NSString *)password andUserProp:(NSNumber *)userProp;

+ (BOOL)ClearPassWord;

+(BOOL)DeletePassWithAcount:(NSString*)acount;

@end
