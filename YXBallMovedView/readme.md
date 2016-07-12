模块简介：
    一个带计时器自由漂浮在界面的小球
    
模块特点：
    1，计时
    2，自由移动
    3，点击小球响应事件
    4，背景半透明度
    
使用方法：
    项目中导入文件，然后在需要的地方#import "YXBallMovedView.h",类方法 +(instancetype)ballMovedView;初始化即可默认一些接口。
    
暴露的接口：
  /*
  自定义的小球图片
*/
@property (strong, nonatomic) UIImage *image;

/*
 显示自定义的小球计时时间的label
 */
@property (strong, nonatomic) UILabel *lbBallTime;

/*
 自定义的小球iv
 */
@property (strong, nonatomic) UIImageView *ivBall;

/*
 视图的代理方法
 */
@property (weak, nonatomic) id<YXBallMovedViewDelegate> delegate;

/*
 默认视图rect为全屏
 */
@property (assign, nonatomic) CGRect ballBgViewRect;

小球点击响应的代理方法：- (void)YXBallMovedClick:(YXBallMovedView *)ballMovedView withDeltaTime:(NSInteger)deltaTime;


