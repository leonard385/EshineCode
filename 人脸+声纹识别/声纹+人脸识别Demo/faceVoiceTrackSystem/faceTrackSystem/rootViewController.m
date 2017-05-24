//
//  rootViewController.m
//  faceTrackSystem
//
//  Created by 倪望龙 on 2017/5/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "rootViewController.h"
#import "faceRegisterViewController.h"
#import "voiceViewController.h"
@interface rootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{//人脸识别
            faceRegisterViewController *faceReVc = [[faceRegisterViewController alloc]initWithNibName:@"faceRegisterViewController" bundle:nil];
            [self.navigationController pushViewController:faceReVc animated:YES];
        }
            break;
        case 1:{//声纹识别
            voiceViewController *voiceVc = [[voiceViewController alloc]initWithNibName:@"voiceViewController" bundle:nil];
            [self.navigationController pushViewController:voiceVc animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
