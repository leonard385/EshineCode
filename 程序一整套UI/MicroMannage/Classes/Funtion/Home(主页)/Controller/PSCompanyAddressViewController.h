//
//  PSCompanyAddressViewController.h
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/29.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "CSBaseFuncVc.h"
@protocol PSCompanyAddressViewControllerDelegate <NSObject>

- (void)didSelectCompanyAddress:(NSString *)addr coordinate:(CLLocationCoordinate2D)locationCoordinate;

@end

@interface PSCompanyAddressViewController : CSBaseFuncVC

/**
 *  协议类型的属性
 */
@property (nonatomic, weak) id<PSCompanyAddressViewControllerDelegate> delegate;

@end
