//
//  MMOfflineQrcodeView.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^OQcloseClick)();
typedef void(^OQsaveClick)();
@interface MMOfflineQrcodeView : UIView
@property(nonatomic,copy)OQcloseClick OQcloseClickBlock;
@property(nonatomic,copy)OQsaveClick OQsaveClickBlock;

-(void)setOQcloseClickBlock:(OQcloseClick)OQcloseClickBlock;
-(void)setOQsaveClickBlock:(OQsaveClick)OQsaveClickBlock;
@end
