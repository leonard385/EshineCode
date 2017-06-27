//
//  ViewController.m
//  ImagePickDemo
//
//  Created by 倪望龙 on 2017/6/26.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ViewController.h"
#import "ImgaePickerViewController.h"
#import "ImagePickerThirdDemoController.h"
#import "compressPhotoController.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:{
            ImgaePickerViewController *Vc = [[ImgaePickerViewController alloc]initWithNibName:@"ImgaePickerViewController" bundle:nil];
            [self.navigationController pushViewController:Vc animated:YES];
        }break;
        case 1:{
            [self.navigationController pushViewController:[ImagePickerThirdDemoController new] animated:YES];
        }break;
        case 2:{
            compressPhotoController *Vc = [[compressPhotoController alloc]initWithNibName:@"compressPhotoController" bundle:nil];
            [self.navigationController pushViewController:Vc animated:YES];
            
        }break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
