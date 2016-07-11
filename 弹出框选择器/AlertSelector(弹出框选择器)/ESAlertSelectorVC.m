//
//  ESAlertSelectorVC.m
//  弹出对话框选择器
//
//  Created by eshine_lsc on 16/4/5.
//  Copyright © 2016年 eshine_lsc. All rights reserved.
//

#import "ESAlertSelectorVC.h"
//自定义文本cell
#import "ESAlertSelectorStringCell.h"

//屏幕宽
#define KSCREEN_W [UIScreen mainScreen].bounds.size.width
//屏幕高
#define KSCREEN_H [UIScreen mainScreen].bounds.size.height
//视图高度
#define KVC_HEIGHT self.view.bounds.size.height
//视图宽度
#define KVC_WIDTH self.view.bounds.size.width

@interface ESAlertSelectorVC ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  接收父控制器
 */
//@property (nonatomic ,weak) UIViewController * viewController;

/**
 *  透明层button
 */
@property (nonatomic ,strong) UIButton * btnTranslucent;

@end

@implementation ESAlertSelectorVC

/**
 *  类方法创建弹出对话框选择器
 *
 *  @param button 点击弹出对话框的button
 *  @param title  选择器标题
 *
 *  @return 选择器
 */
+(instancetype)selectorAddButton:(UIButton *)button title:(NSString *)title{
    return [[self alloc] initWithButton:button title:title];
}

/**
 *  创建弹出对话框选择器
 *
 *  @param button 点击弹出对话框的button
 *  @param title  选择器标题
 *
 *  @return 选择器
 */
-(instancetype)initWithButton:(UIButton *)button title:(NSString *)title{
    if (self = [super init]) {
        self.button = button;
        self.titleSelect = title;
        
    }
    return self;
}

/**
 *  弹出对话框选择器
 */
-(void)gogogo{
    //设置控制器
//    self.viewController = (UIViewController *)self.delegate;
    //设置视图高度
    [self setViewHeight];
    //创建头部UI
    [self setHeadUI];
    //创建选择UI
    [self createUI];
    //创建透明层按钮
    [self createTranslucentBtn];
    //把弹窗视图加到window上
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    //把控制器给跟控制器处理
    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:self];
}

/**
 *  设置视图高度
 */
-(void)setViewHeight{
    NSInteger count = self.arrData.count;
    
    if (count<=2) { //小于两个选择
        //80
        self.view.frame = CGRectMake(0, 0, KSCREEN_W -40, 120);
    }else if (count>2 && count<=8){ //3--8个选择
        //随高度变化
        self.view.frame = CGRectMake(0, 0, KSCREEN_W -40, (count+1) * 40);
    }else{ //大于9个
        //360
        self.view.frame = CGRectMake(0, 0, KSCREEN_W -40, 360);
    }
    //设置弹窗视图中心点坐标
    self.view.center = [UIApplication sharedApplication].keyWindow.center;
}

/**
 *  设置选择器头部视图
 */

-(void)setHeadUI{
    UIView * subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KVC_WIDTH, 40)];
    subView.backgroundColor = [UIColor blueColor];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 10, 40, 20);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:button];
    
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, self.view.bounds.size.width-100, 40);
    label.center = subView.center;
    label.text = self.titleSelect;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [subView addSubview:label];
    
    [self.view addSubview:subView];
}

/**
 *  创建选择器内容
 */
-(void)createUI{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, KVC_WIDTH, KVC_HEIGHT-40) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator =NO;
    [self.view addSubview:tableView];
    [tableView registerClass:[ESAlertSelectorStringCell class] forCellReuseIdentifier:@"cell"];
}

/**
 *  创建透明层button
 */
-(void)createTranslucentBtn{
    //创建透明层button
    if(self.btnTranslucent==nil){
        self.btnTranslucent = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnTranslucent.frame = CGRectMake(0, 0, KSCREEN_W, KSCREEN_H);
        [self.btnTranslucent setBackgroundColor:[UIColor grayColor]];
        [self.btnTranslucent addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:self.btnTranslucent];
    }
    self.btnTranslucent.alpha = 0.2;
}
/**
 *  取消按钮点击事件,弹出框进行隐藏
 */
-(void)buttonClick{
    self.arrData = nil;
    
    //移除透明层button
    self.btnTranslucent.alpha = 0;
    [self.btnTranslucent removeFromSuperview];
    //移除选择器
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark -tableView的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    ESAlertSelectorStringCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.labelText.frame = CGRectMake(10, 0, KVC_WIDTH-20, 40);
    cell.labelText.text = self.arrData[indexPath.row];
//    cell.bottomView.frame= self.view.bounds.size.width;
    CGRect rect = cell.bottomView.frame;
    rect.size.width = self.view.bounds.size.width;
    cell.bottomView.frame = rect;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(selectorButton:selectWithRow:)]) {
        [self.delegate selectorButton:self.button selectWithRow:indexPath.row];
    }
    
    [self buttonClick];
    
    
}


@end
