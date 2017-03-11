//
//  ViewController.m
//  taobaoViewControllers
//
//  Created by 倪望龙 on 2017/3/10.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ViewController.h"
#import "WLPageViewController.h"
#import "oneViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    
  
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    WLPageViewConfigModel *config = [[WLPageViewConfigModel alloc]init];
    WLPageViewController *page = [[WLPageViewController alloc]initWithControllers:@[[oneViewController new],[oneViewController new],[oneViewController new]] titles:@[@"one",@"second",@"third"] config:config];
    [self presentViewController:page animated:YES completion:^{
        
    }];
}
- (IBAction)Click:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
