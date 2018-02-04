//
//  LYStackDynamicController.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/16.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYStackDynamicController.h"
#define kViewTagOffset 100
@interface LYStackDynamicController ()
//图片手stack
@property(nonatomic,strong)UIStackView *stackImages;
//星级stacks
@property(nonatomic,strong)UIStackView *stackStars;
//功能stacks
@property(nonatomic,strong)UIStackView *stackMenus;

@property(nonatomic,strong)NSArray *arrayImages;
@property(nonatomic,strong)NSArray *arrayStars;

@property(nonatomic,assign)NSUInteger selectIdx;
@end

@implementation LYStackDynamicController

-(UIStackView *)stackImages{
    if(_stackImages == nil){
        _stackImages = [UIStackView new];
        [_stackImages setAxis:UILayoutConstraintAxisVertical];
        [_stackImages setAlignment:UIStackViewAlignmentFill];
        [_stackImages setDistribution:UIStackViewDistributionFillEqually];
        [_stackImages setSpacing:10.0f];
    }
    return _stackImages;
}
-(UIStackView *)stackStars{
    if(_stackStars == nil){
        _stackStars = [UIStackView new];
        [_stackStars setAxis:UILayoutConstraintAxisHorizontal];
        [_stackStars setAlignment:UIStackViewAlignmentFill];
        [_stackStars setDistribution:UIStackViewDistributionFillEqually];
        [_stackStars setSpacing:8.0f];
    }
    return _stackStars;
}

-(UIStackView *)stackMenus{
    if(_stackMenus == nil){
        _stackMenus = [UIStackView new];
        [_stackMenus setAxis:UILayoutConstraintAxisHorizontal];
        [_stackMenus setAlignment:UIStackViewAlignmentFill];
        [_stackMenus setDistribution:UIStackViewDistributionFillEqually];
        [_stackMenus setSpacing:10.0f];
    }
    return _stackMenus;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"stackView";
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self SDDataInit];
    [self SDSetUpSubviews];
}

-(void)SDDataInit{
    NSMutableArray *imageArray = [NSMutableArray new];
    for (NSUInteger i = 0; i < 2; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%ld.png",i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = kViewTagOffset + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        [imageView addGestureRecognizer:tap];
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES; 
        [self.stackImages addArrangedSubview:imageView];
        [imageArray addObject:imageView];
    }
    self.arrayImages = [imageArray copy];
    
    for(NSUInteger i = 0;i < 2; i++){
        UIButton *btn = [UIButton new];
        NSString *titleName = (i == 0) ? @"减少":@"增加";
        SEL actionSel = (i == 0) ? @selector(btnReduceClick):@selector(btnAddClick);
        [btn setTitle:titleName forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:actionSel forControlEvents:UIControlEventTouchUpInside];
        [self.stackMenus addArrangedSubview:btn];
    }
}

-(void)SDSetUpSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.stackImages];
    [self.view addSubview:self.stackStars];
    [self.view addSubview:self.stackMenus];
    
    [_stackImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(10.0f);
        make.left.mas_equalTo(self.view).with.offset(12.0f);
        make.right.mas_equalTo(self.view).with.offset(-12.0f);
        make.height.mas_equalTo(self.view).with.multipliedBy(0.55f);
    }];
    
    [_stackMenus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(180.0f);
        make.height.mas_equalTo(30.0f);
        make.bottom.mas_equalTo(self.view).with.offset(-10.0f);
        make.right.mas_equalTo(self.view);
    }];
    
    [_stackStars mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_stackImages.mas_bottom).with.offset(10.0f);
        make.left.right.mas_equalTo(_stackImages);
        make.bottom.mas_equalTo(_stackMenus.mas_top).with.offset(-10.0f);
    }];
}

#pragma mark -  图片点击
-(void)imageClick:(UITapGestureRecognizer *)tap{
    NSUInteger tag = tap.view.tag - kViewTagOffset;
    [UIView animateWithDuration:0.5f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:5.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (_selectIdx == tag) {
                             [_arrayImages enumerateObjectsUsingBlock:^(UIView*  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
                                 view.hidden = NO;
                             }];
                             return;
                         }
                         _selectIdx = tag;
                         [_arrayImages enumerateObjectsUsingBlock:^(UIView*  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
                             view.hidden = !(idx == tag);
                         }];
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

#pragma mark - 减少点击
-(void)btnReduceClick{
    [UIView animateWithDuration:0.5f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:5.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                            NSArray *subviewArrays = self.stackStars.arrangedSubviews;
                            if(subviewArrays.count != 0){
                                UIView* view = self.stackStars.arrangedSubviews.lastObject;
                                [self.stackStars removeArrangedSubview:view];
                                [view removeFromSuperview];
                            }
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - 增加点击
-(void)btnAddClick{
    [UIView animateWithDuration:0.5f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:5.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_star"]];
                            imageView.contentMode = UIViewContentModeCenter;
                            [self.stackStars addArrangedSubview:imageView];
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
