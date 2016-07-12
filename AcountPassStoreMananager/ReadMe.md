#登陆 账号密码保存
##简介
* 账号   使用NSUserDefault 存储
* 密码   使用KeyChain存储

适用于单账号密码的存储，多账号密码的存储可以参考SSKeychain第三方提供的API函数

##API函数
```objectivec
+ (NSDictionary *)GetAccountAndPassword;

+ (void)SaveAccount:(NSString *)account andPassword:(NSString *)password;

+ (BOOL)ClearPassWord;
```

##依赖的第三方库
pod 'SSKeychain’



