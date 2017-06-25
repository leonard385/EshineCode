//
//  customDemoViewController.m
//  searchTest
//
//  Created by 倪望龙 on 2017/6/25.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "customDemoViewController.h"

@interface customDemoViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation customDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self dismissViewControllerAnimated:NO completion:nil];
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
