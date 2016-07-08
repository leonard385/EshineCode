//
//  ViewController.m
//  AlertSelectDemo
//
//  Created by eshine_lsc on 16/5/11.
//  Copyright © 2016年 eshine_lsc. All rights reserved.
//

#import "ViewController.h"
#import "ESAlertSelectorVC.h"

@interface ViewController ()<ESAlertSelectorVCDelegate>
/**
 *  显示城市文本
 */
@property (weak, nonatomic) IBOutlet UILabel *labelCity;

/**
 *  城市名数组
 */
@property (nonatomic ,strong) NSArray * arrCity;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arrCity = @[@"北京",@"上海",@"广州",@"深圳",@"大连",@"长沙",@"重庆",@"天津",@"成都",@"昆明",@"来个名字长一点的看会怎么样,也就这个样子啊，会不会换行呢，不错，居然会换行了"];
}

- (IBAction)selectButtonClick:(UIButton *)sender {
    
    ESAlertSelectorVC * alertVC = [ESAlertSelectorVC selectorAddButton:sender title:@"请选择城市"];
    //设置数据源，数组只能为字符串数组
    alertVC.arrData = self.arrCity;
    //设置代理
    alertVC.delegate = self;
    //弹出选择框
    [alertVC gogogo];
}

#pragma mark 代理方法
-(void)selectorButton:(UIButton *)button selectWithRow:(NSInteger)row{
    self.labelCity.text = self.arrCity[row];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    ESAlertSelectorVC * alertVC = [ESAlertSelectorVC selectorAddButton:nil title:@"请选择城市"];
//    //设置数据源，数组只能为字符串数组
//    alertVC.arrData = self.arrCity;
//    //设置代理
//    alertVC.delegate = self;
//    //弹出选择框
//    [alertVC gogogo];
//}
@end
