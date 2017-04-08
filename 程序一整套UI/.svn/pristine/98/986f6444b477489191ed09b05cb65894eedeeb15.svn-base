//
//  MMTrainTaskEditController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainTaskEditController.h"
#import "MMTrainTaskEditHeadView.h"
#import "MMTrainEditFileCell.h"
@interface MMTrainTaskEditController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MMTrainTaskEditHeadView *headView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *btnAddFile;
@end

@implementation MMTrainTaskEditController
-(UIButton *)btnAddFile{
    if(_btnAddFile == nil){
        _btnAddFile = [UIButton new];
        [_btnAddFile setTitle:@"从知识库导入" forState:UIControlStateNormal];
        [_btnAddFile setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_btnAddFile.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_btnAddFile setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnAddFile addTarget:self action:@selector(btnAddClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddFile;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"添加内容模块";
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(MMTrainTaskEditHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMTrainTaskEditHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 210.0f)];
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TESetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)TESetUpSubviews{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 60.0f;
    [self.tableView registerClass:[MMTrainEditFileCell class] forCellReuseIdentifier:@"MMTrainEditFileCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.headView];
    [self.view addSubview:self.btnAddFile];
    
    [_btnAddFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44.0f);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0.0f, 0, 44.0f, 0));
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMTrainEditFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTrainEditFileCell"];
    if(cell == nil){
        cell = [[MMTrainEditFileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMTrainEditFileCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 知识库导入
-(void)btnAddClick{
    
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
