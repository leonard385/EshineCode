//
//  ThirdMacros.h
//  MobileProject 第三方SDK的Key及配置
//
//  Created by wujunyang on 16/1/5.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h



//百度地图SDK的Key
// 东莞理工版本
#if TARGET_DGLG == 1
#define  kBaiduMapKey @"VTesXvhxjr3sqoc9lI9IV6OV8lVg1KN6"
#define  kBaiduMapAppStoreKey @"apIgEv3jbAhRSgmP3U7filGsT3Es1aVB"
//BUGHD Key
#define BugHdKey  @"9c6eff3707ba576c486e1dda46b77aa8"
// 通用发布版本
#elif TARGET_DGLG == 0
#define  kBaiduMapKey @"z2AbwcObSrGdiz2slrdxGfsmghuvP9Qq"
#define  kBaiduMapAppStoreKey @"W2CL02q7bCG8ZqzN6XRwIard5tt3ZyuE"
//BUGHD Key
#define BugHdKey  @"544e1c40d13cfe5984f61c66201ca063"
#endif

//友盟统计SDK的key
#define kUmengKey @"53290df956240b6b4a0084b3"

//友盟分享
//--微信
#define kSocial_WX_ID @"wxdc1e388c3822c80b"
#define kSocial_WX_Secret @"a393c1527aaccb95f3a4c88d6d1455f6"
#define kSocial_WX_Url @"http://www.umeng.com/social"
//--QQ
#define kSocial_QQ_ID  @"100424468"
#define kSocial_QQ_Secret @"c7394704798a158208a74ab60104f0ba"
#define kSocial_QQ_Url @"http://www.umeng.com/social"
//--新浪微博
#define kSocial_Sina_Account @"3921700954"
#define kSocial_Sina_RedirectURL @"http://sns.whalecloud.com/sina2/callback"


//个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId           @"0uuwznWonIANoK07JeRWgA"
#define kGtAppKey          @"6LeO4stbrA7TeyMUJdXlx3"
#define kGtAppSecret       @"282vl0IwZd9KL3ZpDyoUL7"

//蒲公英
#define kPGYAppID   @"9ae13fae2bca4cdaacac2fafaa3fbe56"

#endif /* ThirdMacros_h */
