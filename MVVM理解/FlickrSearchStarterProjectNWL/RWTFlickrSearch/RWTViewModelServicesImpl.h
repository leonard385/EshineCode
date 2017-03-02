//
//  RWTViewModelServicesImpl.h
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServices.h"
@interface RWTViewModelServicesImpl : NSObject<RWTViewModelServices>
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;
@end
