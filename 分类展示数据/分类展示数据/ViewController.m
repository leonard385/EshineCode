//
//  ViewController.m
//  分类展示数据
//
//  Created by eshine_33 on 16/7/18.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.arrMOptionsData = [NSMutableArray arrayWithArray:@[@"幼儿园",@"学前班",@"中班",@"大班",@"小学",@"初中",@"高中",@"大学",@"研究生",@"博士",@"博士后",@"dsafdsafadsf"]];
    
    self.topMenuFrame = CGRectMake(0, 20, ScreenW, 40);
    
    //根据菜单中的标题 循环创建tableView
    for (NSString *title in self.arrMOptionsData) {
        
        TestViewController *table = [[TestViewController alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        //        table.backgroundColor = [UIColor blackColor];
        table.tableViewTitle = title;
        [self.arrMTableViewsOfOption addObject:table];
    }
    
    
    self.bottomTableViewFrame = CGRectMake(0, CGRectGetMaxY(self.topMenuFrame) + 30, ScreenW, ScreenH - CGRectGetMaxY(self.topMenuFrame));
    
    
    
    //调用父类方法加载控件
    [super viewDidLoad]; //最后执行
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
