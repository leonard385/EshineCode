//
//  MMSegmentView.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/13.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WLSegmentDelegate  <NSObject>
-(void)WLSegmentBtnClickAtIndex:(NSInteger)index;
@end
@interface WLSegmentView : UIView
@property(nonatomic,weak)id<WLSegmentDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles;
-(void)SVprogressLineMoveTo:(NSUInteger)index;
@end
