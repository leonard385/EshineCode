//
//  ViewController.m
//  EmptySetDemo_Third
//
//  Created by 倪望龙 on 2017/6/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableViewController.h"
#import "DZNEmptySetDemoController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            DemoTableViewController *vc = [[DemoTableViewController alloc]initWithNibName:@"DemoTableViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            DZNEmptySetDemoController *vc = [[DZNEmptySetDemoController alloc]initWithNibName:@"DZNEmptySetDemoController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
