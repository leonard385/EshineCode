//
//  baseDznViewController.h
//  EmptySetDemo_Third
//
//  Created by 倪望龙 on 2017/6/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

typedef NS_ENUM(NSUInteger, BDEmptyType) {
    loading = 0,//加载动画
    requestComplete,//加载完成(空白页)
    requestError,//错误页
    hidden,//隐藏
};
typedef void(^BDdidTapEmptyView)();

@interface baseDznViewController : UIViewController<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,assign)BDEmptyType emptyType;//空白页类型
@property(nonatomic,copy)NSString *errorDesc;//错误描述

@property(nonatomic,copy)BDdidTapEmptyView didTapEmptyViewBlock;

-(void)setDidTapEmptyViewBlock:(BDdidTapEmptyView)didTapEmptyViewBlock;

-(NSString *)errorTipHandleWithCode:(long)errorCode;
@end
