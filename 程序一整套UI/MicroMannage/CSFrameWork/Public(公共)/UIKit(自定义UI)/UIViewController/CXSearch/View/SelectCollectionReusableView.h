//
//  SelectCollectionReusableView.h
//  LeNing
//
//  Created by 蔡翔 on 15/10/30.
//  Copyright © 2015年 Qeebu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectCollectionReusableView;
@protocol UICollectionReusableViewButtonDelegate<NSObject>
- (void)delectData:(SelectCollectionReusableView *)view;
@end
@interface SelectCollectionReusableView : UICollectionReusableView

@property (weak,nonatomic) UIButton *delectButton;

@property (weak, nonatomic) id<UICollectionReusableViewButtonDelegate> delectDelegate;

- (void) setText:(NSString*)text;

- (void) setImage:(NSString *)image;



@end
