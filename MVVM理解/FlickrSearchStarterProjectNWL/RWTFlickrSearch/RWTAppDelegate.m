//
//  RWTAppDelegate.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 20/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTAppDelegate.h"
#import "RWTFlickrSearchViewController.h"
#import "RWTFlickrSearchViewModel.h"
#import "RWTViewModelServicesImpl.h"
@interface RWTAppDelegate ()

@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, strong) RWTFlickrSearchViewModel *viewModel;//Viewmodel(搜索功能)
@property (nonatomic, strong) RWTViewModelServicesImpl *viewModelServices;//ViewModel跳转实现类

@end

@implementation RWTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // create a navigation controller and perform some simple styling
    self.navigationController = [UINavigationController new];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    // create and navigate to a view controller
    UIViewController *viewController = [self createInitialViewController];//根目录
    
    
    [self.navigationController pushViewController:viewController animated:NO];
  // show the navigation controller
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = self.navigationController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (UIViewController *)createInitialViewController {
       //model <-->viewmodel
        self.viewModelServices = [[RWTViewModelServicesImpl alloc]initWithNavigationController:self.navigationController];
        self.viewModel = [[RWTFlickrSearchViewModel alloc]initWithServices:self.viewModelServices];
          //view <-->viewmodel
        return [[RWTFlickrSearchViewController alloc] initWithViewModel:self.viewModel];
}
@end
