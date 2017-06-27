//
//  PopView.h
//  PopView
//
//  Created by 123 on 16/4/29.
//  Copyright © 2016年 asura. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sureBlock)();
typedef void(^cancleBlock)();
typedef void(^messageBlock)(NSString *message);

@interface PopView : UIButton

#pragma mark - block
//确定按钮 block 回调
@property (nonatomic, copy) sureBlock success;
//取消按钮 block 回调
@property (nonatomic, copy) cancleBlock failure;
//消息 block 回调
@property (nonatomic, copy) messageBlock message;

                                     /** 操作界面 **/
/**
 *  @author asura, 16-05-04
 *
 *  普通的弹窗
 *
 *  @param title       提示标题
 *  @param content     提示的内容
 *  @param buttonTitle 按钮的标题数组
 *  @param success     第一个按钮点击回调
 *  @param failure     第二个按钮点击回调
 */
+ (void)initWithTitle:(NSString *)title content:(NSString *)content buttonTitle:(NSArray *)buttonTitle success:(void (^)())success failure:(void (^)())failure;
/**
 *  @author asura, 16-05-04
 *
 *  密文输入弹窗
 *
 *  @param password    提示标题
 *  @param buttonTitle 按钮的标题数组
 *  @param message     第一个按钮点击回调
 *  @param failure     第二个按钮点击回调
 */
+ (void)initWithPassword:(NSString *)password buttonTitle:(NSArray *)buttonTitle message:(void (^)())message failure:(void (^)())failure;
/**
 *  @author asura, 16-05-04
 *
 *  评论的弹窗
 *
 *  @param commented   评论标题
 *  @param buttonTitle 按钮的标题数组
 *  @param message     第一个按钮点击回调
 *  @param failure     第二个按钮点击回调
 */
+ (void)initWithCommented:(NSString *)commented buttonTitle:(NSArray *)buttonTitle message:(void (^)(NSString *message))message failure:(void (^)())failure;

                                      /** 状态提示界面 **/
/**
 *  @author asura, 16-05-04
 *
 *  成功状态提示
 *
 *  @param successString 提示的字符
 */
+ (void)initWithSuccessString:(NSString *)successString;
/**
 *  @author asura, 16-05-04
 *
 *  失败状态提示
 *
 *  @param failureString 提示的字符
 */
+ (void)initWithFailureString:(NSString *)failureString;
/**
 *  @author asura, 16-05-04
 *
 *  等待状态的show
 *
 *  @param waitingString 提示的字符
 */
+ (void)initWithWaitingString:(NSString *)waitingString;

+ (void)initWithWaiting;
/**
 *  @author asura, 16-05-04
 *
 *  等待状态的dismiss
 */
+ (void)dissmissPopview;

@end
