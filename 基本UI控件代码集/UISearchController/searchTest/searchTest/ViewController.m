//
//  ViewController.m
//  searchTest
//
//  Created by 倪望龙 on 2017/6/25.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ViewController.h"
#import "searchControllerDemoViewController.h"
#import "customSearchViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
    
        [self.navigationController pushViewController:[[searchControllerDemoViewController alloc] initWithNibName:@"searchControllerDemoViewController" bundle:nil] animated:YES];
    }
    if(indexPath.row == 1){
        [self.navigationController pushViewController:[[customSearchViewController alloc] initWithNibName:@"customSearchViewController" bundle:nil] animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
