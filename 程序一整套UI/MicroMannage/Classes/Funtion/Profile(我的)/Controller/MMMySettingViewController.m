//
//  MMMySettingViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/9.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMMySettingViewController.h"
#import "MMMySettingTableViewCell.h"
@interface MMMySettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSArray *plistArray;
@property(nonatomic,strong)UIButton *btnLoginOut;
@end

@implementation MMMySettingViewController
-(UIButton *)btnLoginOut{
    if(_btnLoginOut == nil){
        _btnLoginOut = [UIButton new];
        [_btnLoginOut setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnLoginOut setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
        [_btnLoginOut setTitle:@"退出登录" forState:UIControlStateNormal];
        [_btnLoginOut.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        _btnLoginOut.layer.borderColor = HEXCOLOR(kLineColor).CGColor;
        _btnLoginOut.layer.borderWidth = 0.5f;
        _btnLoginOut.layer.cornerRadius = 5.0f;
        _btnLoginOut.layer.masksToBounds = YES;
        [_btnLoginOut addTarget:self action:@selector(MMCancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return _btnLoginOut;
    }
    return _btnLoginOut;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"系统设置";
    }
    return self;
}

-(NSArray *)plistArray{
    if(_plistArray == nil){
        NSString *fullPath  =  [[NSBundle mainBundle]pathForResource:@"systemSetting.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:fullPath];
        _plistArray = listArray;
    }
    return _plistArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self MSSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)MSSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height ) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50.0f;
    self.tableView.sectionHeaderHeight = 13.0f;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MMMySettingTableViewCell class] forCellReuseIdentifier:@"MMMySettingTableViewCell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"sectionHead"];
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.btnLoginOut];
    
    [_btnLoginOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(12.0f);
        make.right.mas_equalTo(self.view).with.offset(-12.0f);
        make.height.mas_equalTo(49.0f);
        make.bottom.mas_equalTo(self.view).with.offset(-10.0f);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHead"];
    if(headView == nil){
        
        UITableViewHeaderFooterView *headView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"sectionHead"];
        headView.contentView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.plistArray[section];
    if(NotNilAndNull(array)){
        return array.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMMySettingTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if(cell == nil){
        cell = [[MMMySettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMMySettingTableViewCell"];
    }
    NSArray *sectionArray = self.plistArray[indexPath.section];
    if(indexPath.row == (sectionArray.count - 1)){
        cell.cellLine.hidden = YES;
    }
    NSString *title = sectionArray[indexPath.row];
    [cell setCellTitle:title];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 退出登录
-(void)MMCancleBtnClick{
    
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
