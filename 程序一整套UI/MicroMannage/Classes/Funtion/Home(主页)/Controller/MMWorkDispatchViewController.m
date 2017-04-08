//
//  MMWorkDispatchViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkDispatchViewController.h"
#import "MMWorkDispatchTableViewCell.h"
#import "MMWorkCreateViewController.h"
#import "MMWorkDispathDetailController.h"

#import "MMDispathDetailAllController.h"
#import "MMDispathDetailUndoController.h"
#import "MMDispathDetailDoingController.h"
#import "MMDispathDetailDoneController.h"
@class MMWorkDispatchModel;
@interface MMWorkDispatchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,strong)UIButton *btnAddTask;
@end


@implementation MMWorkDispatchViewController

-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMWorkDispatch.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        _plistArray = [MMWorkDispatchModel mj_objectArrayWithKeyValuesArray:listArray];
    }
    return _plistArray;
}

-(UIButton *)btnAddTask{
    if(_btnAddTask == nil){
        _btnAddTask = [UIButton  new];
        [_btnAddTask setImage:[UIImage imageNamed:@"bth_icon_fbgz"] forState:UIControlStateNormal];
        [_btnAddTask setBackgroundColor:HEXCOLOR(0xfaa81f) forState:UIControlStateNormal];
        _btnAddTask.layer.cornerRadius = 30.0f;
        _btnAddTask.layer.borderWidth = 1.0f;
        _btnAddTask.layer.borderColor = HEXCOLOR(0xfaa81f).CGColor;
        _btnAddTask.layer.masksToBounds = YES;
        [_btnAddTask addTarget:self action:@selector(WDAddTaskClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddTask;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self WDSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)WDSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 122.0f;
    [self.tableView registerClass:[MMWorkDispatchTableViewCell class] forCellReuseIdentifier:@"MMWorkDispatchTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.btnAddTask];
    
    [_btnAddTask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).with.offset(-20.0f);
        make.right.mas_equalTo(self.view).with.offset(-18.0f);
        make.size.mas_equalTo(CGSizeMake(60.0f, 60.0f));
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.plistArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMWorkDispatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMWorkDispatchTableViewCell"];
    
    if(cell == nil){
        cell = [[MMWorkDispatchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMWorkDispatchTableViewCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row == (self.plistArray.count - 1)){
        cell.cellLine.hidden = YES;
    }
    MMWorkDispatchModel *model =_plistArray[indexPath.row];
    [cell setCellModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *VCs = [NSArray arrayWithObjects:
                    [MMDispathDetailAllController new],
                    [MMDispathDetailUndoController new],
                    [MMDispathDetailDoingController new],
                    [MMDispathDetailDoneController new],nil];
    
    NSArray *titles = [NSArray arrayWithObjects:
                       @"全部",
                       @"未完成",
                       @"进行中",
                       @"已完成",nil];
    MMWorkDispathDetailController *WDVc = [[MMWorkDispathDetailController alloc]initWithControllers:VCs titles:titles];
    [self.parentViewController.navigationController pushViewController:WDVc animated:YES];
}

-(void)WDAddTaskClick{
    MMWorkCreateViewController *CVVC = [MMWorkCreateViewController new];
    [self.navigationController pushViewController:CVVC animated:YES];
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
