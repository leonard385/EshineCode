//
//  WLControllerContainerCell.h
//  taobaoViewControllers
//
//  Created by 倪望龙 on 2017/3/11.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLSegmentMenuView.h"
@class WLPageViewConfigModel;
@interface WLSegmentContainerView : UIView
-(instancetype)initWithFrame:(CGRect)frame Controllers:(NSArray *)controllers Titles:(NSArray*)titles withConfig:(WLPageViewConfigModel*)config parentVc:(UIViewController *)Vc;

@end
