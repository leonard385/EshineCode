#URL Sheme解析
Url需要符合以下格式：

~~~
[scheme]//[host]?[Query]
~~~

举个例子：

~~~
xyjlab://www.xyj.com?token=1h12i3kj1l23lk23
~~~


使用DEMO

~~~
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if([[url scheme] isEqualToString:@"xyjstusafe"]){//青聘果调用
        
        NSMutableDictionary *UrlDic = [NSMutableDictionary getURLParameters:[url absoluteString]];
        NSString* tokenVal = UrlDic[@"token"];
        if(NotNilAndNull(tokenVal)){
            
        }
        return YES;
    }else{
       return [ShareSDK handleOpenURL:url wxDelegate:self];
    }
}

-(BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    if([[url scheme] isEqualToString:@"xyjstusafe"]){//青聘果调用
        
        NSMutableDictionary *UrlDic = [NSMutableDictionary getURLParameters:[url absoluteString]];
        NSString* tokenVal = UrlDic[@"token"];
        if(NotNilAndNull(tokenVal)){
            
            NSMutableDictionary *paras = [NSMutableDictionary new];
            paras[@"accessToken"] = tokenVal;
            
            [BSEHttpTool getWithURL:KQingpinwoEntry
                             params:paras
                            success:^(id json) {
                                
                            } failure:^(NSError *error) {
                                
                            }];
            
        }
        return YES;
    }else{
     [ShareSDK handleOpenURL:url
          sourceApplication:sourceApplication
                 annotation:annotation
                 wxDelegate:self];
     if ([OpenShare handleOpenURL:url]) {
        return YES;
      }
    }
    return YES;
}
~~~