//
//  AppDelegate.m
//  ComplainSYS
//
//  Created by 逸信Mac on 16/5/4.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "BSELoginViewController.h"
#import <KSCrash/KSCrashInstallationStandard.h>
#import "BaiDuKitHeader.h"
#import "IQKeyboardManager.h"
#import "ShareSDKHeader.h"
#import "BSENavigationController.h"
#import "LCTabBarController.h"
@interface AppDelegate ()<BMKGeneralDelegate>
@property (nonatomic , strong)BMKMapManager *mapManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //第三方组件初始化
    [self ADThirdPartInit];
//    BSELoginViewController *vc = [[BSELoginViewController alloc] initWithNibName:@"BSELoginViewController" bundle:nil];
    
//    self.window.rootViewController = vc;
    [self ADSetRootTabBarController];
    [self.window makeKeyAndVisible];
    
    
    // Override point for customization after application launch.
    return YES;
}

#pragma mark  - 第三方库初始化
-(void)ADThirdPartInit
{
    [self ADBugHDInit];
    [self ADBMKMapInit];
    [self ADShareSDKInit];
}
#pragma mark  - BUGHD
-(void)ADBugHDInit
{
    KSCrashInstallationStandard* installation = [KSCrashInstallationStandard sharedInstance];
    NSString *UrlStr = [NSString stringWithFormat:@"%@?key=%@",@"https://collector.bughd.com/kscrash",BugHdKey];
    installation.url = [NSURL URLWithString:UrlStr];
    [installation install];
    [installation sendAllReportsWithCompletion:nil];
}

#pragma mark  - BMKMAP
-(void)ADBMKMapInit
{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:kBaiduMapKey  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
}
#pragma mark  - KeyBoardInit
-(void)IQKeyboardManagerInit
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
}
#pragma mark  - ShareSDKInit
- (void)ADShareSDKInit {
    [ShareSDK registerApp:ShareSDKKey
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                           @(SSDKPlatformTypeSMS),
                           @(SSDKPlatformTypeWechat),
                           @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     switch (platformType)
                     {
                         case SSDKPlatformTypeSinaWeibo:
                             [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                       appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                                     redirectUri:@"http://www.sharesdk.cn"
                                                        authType:SSDKAuthTypeBoth];
                             break;
                         case SSDKPlatformTypeWechat:
                             [appInfo SSDKSetupWeChatByAppId:kSocial_WX_ID
                                                   appSecret:kSocial_WX_Secret];
                             break;
                         case SSDKPlatformTypeQQ:
                             [appInfo SSDKSetupQQByAppId:kSocial_QQ_ID
                                                  appKey:kSocial_QQ_Secret
                                                authType:SSDKAuthTypeBoth];
                             break;
                         default:
                             break;
                     }
     }];
}
#pragma mark  - AFNetWorkingInit
-(void)AFNetWorkingInit
{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    //网络状态监测
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[BSEUserInfo shareMannager]setNetworkStatus:status];
    }];
}

#pragma mark  - 设置根TabBarController
-(void)ADSetRootTabBarController
{
    
    UIViewController *HomeVC = [[UIViewController alloc]init];
    BSENavigationController *HomeNav = [self ChildVC:HomeVC
                                         WithTitle:@"首页"
                                             image:@"kqin"
                                     selectedImage:@"current1"];
    
    UIViewController *knowledgeVC = [UIViewController new];
    BSENavigationController *knowledgeNav = [self ChildVC:knowledgeVC
                                       WithTitle:@"知识库"
                                           image:@"SOS"
                                   selectedImage:@"current2"];
    
    
    
    UIViewController *MessagerVC = [UIViewController new];
    BSENavigationController *MessagerNav = [self ChildVC:MessagerVC
                                          WithTitle:@"消息"
                                              image:@"baogao"
                                      selectedImage:@"current3"];
    
    UIViewController *MyVC = [UIViewController new];
    BSENavigationController *MyNav = [self ChildVC:MyVC
                                            WithTitle:@"我的"
                                                image:@"message"
                                        selectedImage:@"current4"];

    
    
    LCTabBarController *tabBarVC = [[LCTabBarController alloc] init];
    tabBarVC.tabBar.barTintColor = [UIColor whiteColor];//tabbar 背景色
    tabBarVC.tabBar.translucent = NO;
    tabBarVC.itemTitleColor = HEXCOLOR(0x999999);
    tabBarVC.itemTitleFont = [UIFont systemFontOfSize:11.0f];
    tabBarVC.selectedItemTitleColor = HEXCOLOR(0x44BE73);
    
    tabBarVC.viewControllers = @[HomeNav, knowledgeNav,MessagerNav,MyNav];
    
    self.window.rootViewController = tabBarVC;
    
}

#pragma mark  - 根TabBarController 添加子视图

-(BSENavigationController *)ChildVC:(UIViewController *)VC WithTitle:(NSString *)title image:(NSString *)imagename selectedImage:(NSString *)selectedImageName
{
    VC.title = title;
    VC.view.backgroundColor = [UIColor whiteColor];
    VC.tabBarItem.image = [UIImage imageNamed:imagename];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    BSENavigationController *Nav = [[BSENavigationController alloc]initWithRootViewController:VC];
    return Nav;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
