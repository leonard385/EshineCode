//
//  WLSegmentMenuView.h
//  taobaoViewControllers
//
//  Created by 倪望龙 on 2017/3/11.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLPageMacros.h"
#import "WLPageViewConfigModel.h"
@protocol WLMenuDelegate  <NSObject>

-(void)WLMenuBtnClick:(NSInteger)index;

@end

@interface WLSegmentMenuView : UIView
@property(nonatomic,strong,readonly)NSArray *titles;//标题数组
@property(nonatomic,weak)id<WLMenuDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withConfig:(WLPageViewConfigModel *)configModel withTitles:(NSArray *)titles;
-(void)progressLineMoveTo:(NSUInteger)index;
@end
