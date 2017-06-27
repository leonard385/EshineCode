//
//  PopView.m
//  PopView
//
//  Created by 123 on 16/4/29.
//  Copyright © 2016年 asura. All rights reserved.
//

#import "PopView.h"
#import "DrawView.h"

//屏幕宽和高
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

typedef NS_ENUM(NSInteger, PopViewType){
    PopViewNormalType = 0,
    PopViewPasswordType = 1 << 1,
    PopViewCommentedType = 1 << 2,
    PopViewSuccessType = 1 << 3,
    PopViewFailureType = 1 << 4,
    PopViewWaitingType = 1 << 5
};

#define kScreenFrame [UIScreen mainScreen].bounds

#define kScreenSpacing 10

@interface PopView () <UITextViewDelegate>

               /** 操作界面 **/
@property (nonatomic, strong) UIWindow *window;
//底层背景视图
@property (nonatomic, strong) UIButton *bottomButton;
//记录创建该视图时当前 window 的等级
@property (nonatomic, assign) NSInteger windowLevel;
//提示标题
@property (nonatomic, copy) NSString *title;
//提示内容
@property (nonatomic, copy) NSString *content;
//按钮标题
@property (nonatomic, strong) NSArray *buttonTitle;
//存放 textField的数组
@property (nonatomic, strong) NSMutableArray *textFields;
//回调信息
@property (nonatomic, copy) NSString *messagString;
//弹出视图的样式
@property (nonatomic, assign) PopViewType popViewType;
//记录点击的标示
@property (nonatomic, assign) BOOL isHandle;

            /** 状态提示界面 **/
//状态消息
@property (nonatomic, copy) NSString *showMessage;
//画图板
@property (nonatomic, strong) CAShapeLayer *shaperLayer;
//加载控件
@property (nonatomic, strong) DrawView *drawView;

@end

@implementation PopView


// Only override drawRect: if you perform custom drawing.
// An emprty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

#pragma mark - lazyloaded
- (NSMutableArray *)textFields{
    if (!_textFields) {
        self.textFields = [NSMutableArray array];
    }
    return _textFields;
}

#pragma mark - init
//普通视图
+ (void)initWithTitle:(NSString *)title content:(NSString *)content buttonTitle:(NSArray *)buttonTitle success:(void (^)())success failure:(void (^)())failure{
    
    PopView *popView = [[PopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 2 / 3, kScreenHeight / 6)];
    popView.title = title;
    popView.content = content;
    popView.buttonTitle = buttonTitle;
    popView.popViewType = PopViewNormalType;
    
    [popView initConfgureBottomButtonAndWindow];
    [popView initConfgureCenterView];

    popView.success = success;
    popView.failure = failure;

}
//密文视图
+ (void)initWithPassword:(NSString *)password buttonTitle:(NSArray *)buttonTitle message:(void (^)())message failure:(void (^)())failure{
    
    PopView *popView = [[PopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 2 / 3, kScreenHeight / 6)];
    popView.title = password;
    popView.buttonTitle = buttonTitle;
    popView.popViewType = PopViewPasswordType;

    [popView initConfgureBottomButtonAndWindow];
    [popView initConfgureCenterView];

    popView.message = message;
    popView.failure = failure;
}
//评论视图
+ (void)initWithCommented:(NSString *)commented buttonTitle:(NSArray *)buttonTitle message:(void (^)(NSString *))message failure:(void (^)())failure{
    
    PopView *popView = [[PopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 2 / 3, kScreenHeight / 6)];
    popView.title = commented;
    popView.buttonTitle = buttonTitle;
    popView.popViewType = PopViewCommentedType;
    
    [popView initConfgureBottomButtonAndWindow];
    [popView initConfgureCenterView];
    
    popView.message = message;
    popView.failure = failure;
}
//成功提示
+ (void)initWithSuccessString:(NSString *)successString{
    
    PopView *popView = [[PopView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight / 8, kScreenHeight / 8)];
    popView.showMessage = successString;
    popView.popViewType = PopViewSuccessType;
    
    [popView initConfgureBottomButtonAndWindow];
    [popView initConfgureStatedCenterView];
}

//失败提示
+ (void)initWithFailureString:(NSString *)failureString{
    PopView *popView = [[PopView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight / 8, kScreenHeight / 8)];
    popView.showMessage = failureString;
    popView.popViewType = PopViewFailureType;
    
    [popView initConfgureBottomButtonAndWindow];
    [popView initConfgureStatedCenterView];
}
//状态等待
+ (void)initWithWaitingString:(NSString *)waitingString{
    
    PopView *popView = [[PopView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight / 8, kScreenHeight / 8)];
    popView.showMessage = waitingString;
    popView.popViewType = PopViewWaitingType;
    
    [popView initConfgureBottomButtonAndWindow];
    [popView initConfgureStatedCenterView];
}

//记载等待
+ (void)initWithWaiting{
    
    PopView *popView = [[PopView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight / 8 - 10, kScreenHeight / 8 - 10)];
    popView.popViewType = PopViewWaitingType;
    [popView initConfgureBottomButtonAndWindow];
    [popView initConfgureStatedCenterView];
}

//配置底层视图
- (void)initConfgureBottomButtonAndWindow{
 
    self.window = [[[UIApplication sharedApplication]delegate]window];
    self.windowLevel = self.window.windowLevel;
    self.window.windowLevel = UIWindowLevelAlert + 1;
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.frame = kScreenFrame;
    self.bottomButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    
    self.window.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.4];
    self.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:self.bottomButton];
    [self.bottomButton addSubview:self];
}

//配置弹出视图及其子视图
- (void)initConfgureCenterView{
    
    //self
    self.center = self.bottomButton.center;
    self.layer.cornerRadius = kScreenSpacing;
    self.layer.masksToBounds = YES;

    CGFloat selfWidth = CGRectGetWidth(self.frame);
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    
    //title
    UILabel *titleLabel = [self addSubViwLableWithFrame:CGRectMake(kScreenSpacing, 0, selfWidth - kScreenSpacing * 2, selfHeight / 3) title:self.title sizeFont:17 isTitle:YES];
    
    
    if (self.popViewType == PopViewPasswordType) {
        //密文
        [self addTextFieldWithSelfWidth:selfWidth titleLabel:titleLabel];
        
    }else if (self.popViewType == PopViewNormalType){
        //普通
        [self addSubViwLableWithFrame:CGRectMake(kScreenSpacing, CGRectGetMaxY(titleLabel.frame), selfWidth - kScreenSpacing * 2, selfHeight / 3) title:self.content sizeFont:14 isTitle:NO];
    }else if (self.popViewType == PopViewCommentedType){
        //评论
        [self addTextViewWithSelfWidth:selfWidth selfHeight:selfHeight titleLabel:titleLabel];
    }

    //button
    [self addButtonWithSelfWidth:selfWidth selfHeight:selfHeight];
    
    //分割线
    [self addLineWithSelfWidth:selfWidth selfHeight:selfHeight];
    
    //显示动画
    [self showAnimationPopView];
}

- (id)addSubViwLableWithFrame:(CGRect)frame title:(NSString *)title sizeFont:(int)sizeFont isTitle:(BOOL)isTitle{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:frame];
    [self addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        titleLabel.font = [UIFont boldSystemFontOfSize:sizeFont];
    }else{
        titleLabel.font = [UIFont systemFontOfSize:sizeFont];
    }
    
    return titleLabel;
}
//textField
- (void)addTextFieldWithSelfWidth:(CGFloat)selfWidth titleLabel:(UILabel *)titleLabel{
    
    CGFloat textFieldWidth = (selfWidth - kScreenSpacing * 7) / 6;
    for (int i = 0; i < 6; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake((textFieldWidth + kScreenSpacing) * i + kScreenSpacing, CGRectGetMaxY(titleLabel.frame), textFieldWidth, textFieldWidth)];
        [self addSubview:textField];
        
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1;
        [textField addTarget:self action:@selector(editigChanged:) forControlEvents:UIControlEventEditingChanged];
        textField.tag = 200 + i;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        [self.textFields addObject:textField];
        textField.secureTextEntry = YES;
        textField.textAlignment = NSTextAlignmentCenter;
        if (i != 0) {
            textField.enabled = NO;
        }
        if (i == 0) {
            [textField becomeFirstResponder];
        }
    }
}
//button
- (void)addButtonWithSelfWidth:(CGFloat)selfWidth selfHeight:(CGFloat)selfHeight{

    CGFloat buttonWidth = (selfWidth - kScreenSpacing * (self.buttonTitle.count + 1)) / self.buttonTitle.count;
    
    for (int i = 0; i < self.buttonTitle.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((buttonWidth + kScreenSpacing ) * i + kScreenSpacing,selfHeight * 2 / 3, buttonWidth, selfHeight / 3);
        [button setTitle:self.buttonTitle[i] forState:UIControlStateNormal];
        [self addSubview:button];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
    }
}
//分割线
- (void)addLineWithSelfWidth:(CGFloat)selfWidth selfHeight:(CGFloat)selfHeight{

    UIView *hView = [[UIView alloc]initWithFrame:CGRectMake(0, selfHeight * 2 / 3 - 1, selfWidth, 1)];
    hView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:hView];
    
    if (self.buttonTitle.count == 2) {
        UIView *Vview = [[UIView alloc]initWithFrame:CGRectMake(selfWidth / 2 - 0.5, selfHeight * 2 / 3, 1, selfHeight / 3)];
        Vview.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:Vview];
    }
}

- (void)addTextViewWithSelfWidth:(CGFloat)selfWidth selfHeight:(CGFloat)selfHeight titleLabel:(UILabel *)titleLabel{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(kScreenSpacing, CGRectGetMaxY(titleLabel.frame), selfWidth - kScreenSpacing * 2, selfHeight / 3 - 2)];
    textView.layer.cornerRadius = kScreenSpacing / 2;
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 1;
    [self addSubview:textView];
    textView.delegate = self;
}

//状态模式的配置子视图
- (void)initConfgureStatedCenterView{
    //self
    self.center = self.bottomButton.center;
    self.layer.cornerRadius = kScreenSpacing;
    self.layer.masksToBounds = YES;
    
    CGFloat selfWidth = CGRectGetWidth(self.frame);
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    
    if (self.popViewType == PopViewWaitingType) {
        //laoding
        [self loadingWithSelfWidth:selfWidth selfHeight:selfHeight];
        
    }else{
    //画图
        [self drawRectWithSelfWidth:selfWidth selfHeight:selfHeight];
    }
    // label
    [self addSubViwLableWithFrame:CGRectMake(kScreenSpacing, selfHeight * 2 / 3 - 5, selfWidth -  kScreenSpacing * 2, selfHeight / 3) title:self.showMessage sizeFont:14 isTitle:NO];
    
    [self showAnimationPopView];
    [self drawRectAnimation];
    
    //存在,则直接返回
    if (self.drawView) return;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self disssmissAnimationPopView];
    });
}

//移除
+ (void)dissmissPopview{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIView *window in windows) {
        if ([window isKindOfClass:[UIWindow class]]) {
            for (UIView *view in window.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    for (UIView *subView in view.subviews) {
                        if ([subView isKindOfClass:[PopView class]]) {
                            [((PopView *)subView) disssmissAnimationPopView];
                            [((PopView *)subView).drawView stopAnimating];
                        }
                    }
                }
            }
        }
    }
}

- (void)drawRectWithSelfWidth:(CGFloat)selfWidth selfHeight:(CGFloat)selfHeight{
    //画图
    CGPoint centerPoint = CGPointMake(selfWidth / 2, selfHeight / 3);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:selfHeight / 4 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    
    if (self.popViewType == PopViewSuccessType) {
        //成功状态
        
        [bezierPath moveToPoint: CGPointMake(selfWidth / 2 - selfHeight / 4 + 5, selfHeight / 3 + 5)];
        [bezierPath addLineToPoint: CGPointMake(selfWidth / 2 - 5, selfHeight / 3 + selfHeight / 4 - 5)];
        [bezierPath addLineToPoint: CGPointMake(selfWidth / 2 + selfHeight / 8, selfHeight / 4)];
        [bezierPath addLineToPoint:CGPointMake(selfWidth / 2 + selfHeight / 6, selfHeight / 4)];
    }else if (self.popViewType == PopViewFailureType){
        //失败状态
        
        [bezierPath  moveToPoint:CGPointMake(selfWidth / 2 - selfHeight / 4 + kScreenSpacing, selfHeight / 5)];
        [bezierPath addLineToPoint:CGPointMake(selfWidth / 2 + selfHeight / 8, selfHeight / 2)];
        
        [bezierPath  moveToPoint:CGPointMake(selfWidth / 2 + selfHeight / 4 - kScreenSpacing, selfHeight / 5)];
        [bezierPath addLineToPoint:CGPointMake(selfWidth / 2 - selfHeight / 4 + kScreenSpacing, selfHeight / 2)];
    }
    
    self.shaperLayer = [CAShapeLayer layer];
    self.shaperLayer.frame = self.bounds;
    self.shaperLayer.lineWidth = 2;
    self.shaperLayer.strokeColor = [UIColor blueColor].CGColor;
    self.shaperLayer.fillColor = [UIColor clearColor].CGColor;
    self.shaperLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:self.shaperLayer];
}

- (void)loadingWithSelfWidth:(CGFloat)selfWidth selfHeight:(CGFloat)selfHeight{
    //加载控件
    self.drawView = [[DrawView alloc]initWithFrame:CGRectMake(kScreenSpacing, kScreenSpacing, selfWidth - kScreenSpacing * 2, selfHeight * 2 / 3 - kScreenSpacing * 2)];
    [self addSubview:self.drawView];
    [self.drawView startAnimating];
}

#pragma mark - animation
//show动画
- (void)showAnimationPopView{

    self.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
        
        self.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
    }];
}
// dissmiss 动画
- (void)disssmissAnimationPopView{
    
    //设置还原 window 的 leavel
    self.window.windowLevel = self.windowLevel;

    [UIView animateKeyframesWithDuration:0.4 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        basicAnimation.fromValue = @1.0f;
        basicAnimation.toValue = @0.f;
        basicAnimation.duration = 0.4;
        basicAnimation.removedOnCompletion = NO;
        basicAnimation.fillMode = kCAFillModeForwards;
        [self.layer addAnimation:basicAnimation forKey:@"scale"];
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.bottomButton removeFromSuperview];

        });
    }];
}

//画图动画
- (void)drawRectAnimation{
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @1;
    basicAnimation.duration = 0.6;
    [self.shaperLayer addAnimation:basicAnimation forKey:@"strokeEnd"];
}

#pragma mark - action
//点击事件
- (void)handleAction:(UIButton *)sender{
    
    //先取消输入框的第一响应者
    if (self.popViewType == PopViewCommentedType) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UITextView class]]) {
                [((UITextView *)view) resignFirstResponder];
            }
        }
    }
    
    if (sender.tag == 100) {
        self.success ? self.success() : nil;
        self.message ? self.message(self.messagString) : nil;
    }else{
        self.failure ? self.failure() : nil;
    }
    
    if (!self.isHandle) {
        [self disssmissAnimationPopView];
        self.isHandle = YES;
    }
}
//textFiled 的事件
- (void)editigChanged:(UITextField *)textField{
    switch (textField.tag) {
        case 200:
        {
            [self confgureTextFieldWithChangedTextFiled:textField indexTage:0];
            self.messagString = textField.text;
        }
            break;
        case 201:
        {
            [self confgureTextFieldWithChangedTextFiled:textField indexTage:1];
            self.messagString = [NSString stringWithFormat:@"%@%@",self.messagString,textField.text];
        }
            break;
        case 202:
        {
            [self confgureTextFieldWithChangedTextFiled:textField indexTage:2];
            self.messagString = [NSString stringWithFormat:@"%@%@",self.messagString,textField.text];
        }
            break;
        case 203:
        {
            [self confgureTextFieldWithChangedTextFiled:textField indexTage:3];
            self.messagString = [NSString stringWithFormat:@"%@%@",self.messagString,textField.text];
        }
            break;
        case 204:
        {
            [self confgureTextFieldWithChangedTextFiled:textField indexTage:4];
            self.messagString = [NSString stringWithFormat:@"%@%@",self.messagString,textField.text];
        }
            break;
        case 205:
        {
            [self confgureTextFieldWithChangedTextFiled:textField indexTage:5];
            self.messagString = [NSString stringWithFormat:@"%@%@",self.messagString,textField.text];
        }
            break;
            
        default:
            break;
    }
}

- (void)confgureTextFieldWithChangedTextFiled:(UITextField *)changedTextFiled indexTage:(int)indexTage{
   
    if (changedTextFiled == self.textFields[indexTage]) {
        //限制输入的字符长度
        if (changedTextFiled.text.length == 1) {
            //输入完之后关闭交互
            changedTextFiled.enabled = NO;
            //选择交互和直接返回的判断
            if (indexTage + 1 == self.textFields.count){
                
                UIButton *sureButton = [self viewWithTag:100];
                sureButton.enabled = YES;
            }else{
                
                ((UITextField *)self.textFields[indexTage + 1]).enabled = YES;
                [((UITextField *)self.textFields[indexTage + 1]) becomeFirstResponder];
            }
        }
    }
}

#pragma mark - layoutSubviews
- (void)layoutSubviews{
    [super layoutSubviews];
    self.alpha = 0.7;
    [self.window insertSubview:self.bottomButton atIndex:INT32_MAX];
    //如果是密码输入.则关掉确定按钮的交互
    if (self.textFields.count != 0) {
        UIButton *sureButton = [self viewWithTag:100];
        sureButton.enabled = NO;
    }
}

#pragma mark - UITextView delegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.messagString = textView.text;
}

@end
