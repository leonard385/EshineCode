//
//  URLMacros.h
//  BSEM
//
//  Created by 逸信Mac on 16/2/29.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h
#define BsemURL_PREFIX  @"http://221.179.101.147:81/cop"

#define HTTP(x) [BsemURL_PREFIX stringByAppendingString:x]
//登陆
#define HTTP_LOGIN HTTP(@"/android/login/login.do?action=submit")

#endif /* URLMacros_h */


