//
//  LYDynamicSizeDemoController.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/24.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYDynamicSizeDemoController.h"

@interface LYDynamicSizeDemoController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldInput;

@end

@implementation LYDynamicSizeDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(DSChangeTextFont) withObject:nil afterDelay:1.0f];
}

-(void)DSChangeTextFont{
    _textFieldInput.font = [UIFont systemFontOfSize:32.0f];
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
