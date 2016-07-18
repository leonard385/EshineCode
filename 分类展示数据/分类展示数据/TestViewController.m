//
//  TestViewController.m
//  分类展示数据
//
//  Created by eshine_33 on 16/7/18.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TestViewController

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    }
    
    cell.textLabel.text =  [NSString stringWithFormat:@"%@~~~~%ld",self.tableViewTitle,indexPath.row];
    return cell;
}


@end
