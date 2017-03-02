//
//  RWTViewModelServices.h
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearch.h"

@protocol RWTViewModelServices <NSObject>
- (id<RWTFlickrSearch>)getFlickrSearchService;
- (void)pushViewModelVC:(UIViewController *)viewController;
@end
