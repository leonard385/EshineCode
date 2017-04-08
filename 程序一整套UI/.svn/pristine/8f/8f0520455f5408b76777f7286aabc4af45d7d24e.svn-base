//
//  MMKVPracticeViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/11.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKVPracticeViewController.h"
#import "MMKVPracticeTableViewCell.h"
#import "MMKVPraticeModel.h"
@interface MMKVPracticeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMKVPracticeViewController
-(NSArray *)plistArray{
    if(_plistArray == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMKVPratice.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        _plistArray = [MMKVPraticeModel mj_objectArrayWithKeyValuesArray:listArray];
    }
    return _plistArray;
}

-(UITableView *)tableView{
    if(_tableView == nil){
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.tableView registerClass:[MMKVPracticeTableViewCell class] forCellReuseIdentifier:@"MMKVPracticeTableViewCell"];
        self.tableView.rowHeight = 96.0f;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self PVSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)PVSetUpSubviews{
    [self.view addSubview:self.tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.plistArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMKVPracticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMKVPracticeTableViewCell"];
    if(cell == nil){
        cell = [[MMKVPracticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMKVPracticeTableViewCell"];
    }
    MMKVPraticeModel *model = self.plistArray[indexPath.row];
    [cell setCellModel:model];
    return cell;
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
