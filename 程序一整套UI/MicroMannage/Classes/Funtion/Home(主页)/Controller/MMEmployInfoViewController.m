//
//  MMEmployInfoViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployInfoViewController.h"
#import "MMEmployInfoHeadCell.h"
#import "MMEmployInfoSelectCell.h"
#import "MMEmployInfoModel.h"
#import "MMEmployInfoInputController.h"
@interface MMEmployInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMEmployInfoViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"添加员工";
    }
    return self;
}

-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"NewEmploy.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        NSArray *models = [MMEmployInfoModel mj_objectArrayWithKeyValuesArray:listArray];
        
        _plistArray = models;
    }
    return _plistArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self EISetUpSubviews];
}

#pragma mark - subViews
-(void)EISetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MMEmployInfoHeadCell class] forCellReuseIdentifier:@"MMEmployInfoHeadCell"];
    [self.tableView registerClass:[MMEmployInfoSelectCell class] forCellReuseIdentifier:@"MMEmployInfoSelectCell"];
    [self.tableView setContentInset:UIEdgeInsetsMake(-10.0f, 0, 0, 0)];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.plistArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.plistArray[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if((indexPath.section == 0)&&(indexPath.row == 0)){
            return 82.0f;
        }else{
            return 44.0f;
        }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = self.plistArray[indexPath.section];
    MMEmployInfoModel *model = array[indexPath.row];
    if((indexPath.section == 0)&&(indexPath.row == 0)){
        MMEmployInfoHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMEmployInfoHeadCell"];
        if(cell == nil){
            cell = [[MMEmployInfoHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMEmployInfoHeadCell"];
        }
        return cell;
    }else{
        MMEmployInfoSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMEmployInfoSelectCell"];
        if(cell == nil){
            cell = [[MMEmployInfoSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMEmployInfoSelectCell"];
        }
        if(indexPath.row == array.count - 1){
            cell.cellLine.hidden = YES;
        }else{
            cell.cellLine.hidden = NO;
        }
        [cell setCellModel:model];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf();
  
    if((indexPath.section == 0)&&(indexPath.row == 0)){
        return;
    }
    
    
    NSArray *array = self.plistArray[indexPath.section];
    MMEmployInfoModel *model = array[indexPath.row];
    MMEmployInfoInputController *vc = [MMEmployInfoInputController new];
    vc.navTitle = model.title;
    [vc setReturnInputBlock:^(NSString *content) {
            model.content = content;
            [weakself.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
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
