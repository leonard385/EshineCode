//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  MLNavigationViewController.m
//  MLSelectPhoto
//
//  Created by 张磊 on 15/4/22.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "MLSelectPhotoNavigationViewController.h"
#import "MLSelectPhotoCommon.h"

@interface MLSelectPhotoNavigationViewController ()

@end

@implementation MLSelectPhotoNavigationViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    UINavigationController *rootVc = (UINavigationController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    
    if ([rootVc isKindOfClass:[UINavigationController class]]) {
        [self.navigationBar setValue:[rootVc.navigationBar valueForKeyPath:@"barTintColor"] forKeyPath:@"barTintColor"];
        [self.navigationBar setTintColor:rootVc.navigationBar.tintColor];
        [self.navigationBar setTitleTextAttributes:rootVc.navigationBar.titleTextAttributes];
        
    }else{
        [self.navigationBar setValue:DefaultNavbarTintColor forKeyPath:@"barTintColor"];
        [self.navigationBar setTintColor:DefaultNavTintColor];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:DefaultNavTitleColor}];
    }

}
@end
