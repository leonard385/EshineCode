//
//  StoreAccount.h
//  jobCompany
//
//  Created by 陈广川 on 16/1/5.
//  Copyright © 2016年 liaolx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountPasswordMannger : NSObject
@property(nonatomic,strong,readonly)NSMutableArray *AllAccounts;

+(instancetype)ShareMannager;

- (NSDictionary *)GetLastAccountAndPassword;

- (NSDictionary *)GetAccountAndPasswordForAccount:(NSString *)Acount;//获取指定信息

- (void)SaveAccount:(NSString *)account andPassword:(NSString *)password;

- (BOOL)ClearLastPassWord;
-(BOOL)DeletePassWithAcount:(NSString*)acount;

@end
