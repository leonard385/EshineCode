//
//  StoreAccount.m
//  jobCompany
//
//  Created by 陈广川 on 16/1/5.
//  Copyright © 2016年 liaolx. All rights reserved.
//

#import "AccountPasswordMannger.h"
#import <SSKeychain/SSKeychain.h>

#define kService @"com.eshine.PraticeSaftTeacher"
#define kAccount @"account"


@implementation AccountPasswordMannger

+(instancetype)ShareMannager
{
    static AccountPasswordMannger *mannager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mannager = [[self class]new];
    });
    return mannager;
}

-(NSMutableArray *)AllAccounts
{
    NSArray *Acounts = [SSKeychain accountsForService:kService];
    
    __block NSMutableArray *CountsArray  = [NSMutableArray new];
    [Acounts enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull AcountDic, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *acountTemp = AcountDic[@"acct"];
        if(acountTemp){
            [CountsArray addObject:acountTemp];
        }
    }];
    return CountsArray;
}

- (void)SaveAccount:(NSString *)account andPassword:(NSString *)password{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:account forKey:kAccount];
    [defaults synchronize];
    [SSKeychain setPassword:password forService:kService account:account];
}


- (NSDictionary *)GetAccountAndPasswordForAccount:(NSString *)Acount
{
    if (Acount) {
        NSString *password = [SSKeychain passwordForService:kService account:Acount] ? [SSKeychain passwordForService:kService account:Acount] : @"";
        return @{Acount:password};
    } else {
        return @{@"": @""};
    }

}

- (NSDictionary *)GetLastAccountAndPassword {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *account = [defaults objectForKey:kAccount];
    if (account) {
        NSString *password = [SSKeychain passwordForService:kService account:account] ? [SSKeychain passwordForService:kService account:account] : @"";
        return @{account:password};
    } else {
        return @{@"": @""};
    }
}

- (BOOL)ClearPassWord {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:kAccount] ? [userDefaults objectForKey:kAccount] : @"";
    
    NSError *error;
    
    [SSKeychain deletePasswordForService:kService account:account error:&error];
    
    if (error) {
        return NO;
    } else {
        return YES;
    }
}


-(BOOL)DeletePassWithAcount:(NSString*)acount
{
    NSError *error;
    
    [SSKeychain deletePasswordForService:kService account:acount error:&error];
    
    if (error) {
        return NO;
    } else {
        return YES;
    }
 
}

@end
