//
//  MMUnreadMessageController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMUnreadMessageController.h"
#import "MMMessageSectionhead.h"
#import "MMUnreadMessageCell.h"
#import "MMNoticeMessageTableViewCell.h"
@interface MMUnreadMessageController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MMUnreadMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UMSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)UMSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight - kTabbarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 75.0f;
    [self.tableView registerClass:[MMUnreadMessageCell class] forCellReuseIdentifier:@"MMUnreadMessageCell"];
    [self.tableView registerClass:[MMMessageSectionhead class] forHeaderFooterViewReuseIdentifier:@"MMMessageSectionhead"];
     [self.tableView registerClass:[MMNoticeMessageTableViewCell class] forCellReuseIdentifier:@"MMNoticeMessageTableViewCell"];
    [self.tableView setContentInset:UIEdgeInsetsMake(12.0f, 0, 0, 0)];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1.0f;
    }else{
        return 2.0f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.0f;
    }else{
        return 44.0f;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            MMNoticeMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMNoticeMessageTableViewCell"];
            if(cell == nil){
                cell = [[MMNoticeMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMNoticeMessageTableViewCell"];
            }
            if(indexPath.row == 0.0f){
                cell.cellLine.hidden = YES;
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;

        }
            break;
        case 1:{
            MMUnreadMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMUnreadMessageCell"];
            if(cell == nil){
                cell = [[MMUnreadMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMUnreadMessageCell"];
            }
            if(indexPath.row == 1.0f){
                cell.cellLine.hidden = YES;
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;

        }
            break;
            
        default:{
            return nil;
        }
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MMMessageSectionhead *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MMMessageSectionhead"];
    if(view == nil){
        view = [[MMMessageSectionhead alloc]initWithReuseIdentifier:@"MMMessageSectionhead"];
    }
    if(section == 0){
    }else{
        [view setTitle:@"最近联系人"];
    }
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
