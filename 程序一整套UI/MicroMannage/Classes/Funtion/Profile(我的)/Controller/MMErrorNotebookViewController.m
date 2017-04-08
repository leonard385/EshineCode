//
//  MMErrorNotebookViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/9.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMErrorNotebookViewController.h"
#import "MMErrorNotebookHeadView.h"
#import "MMNotebooksSwithCell.h"
#import "MMNotebooksTableViewCell.h"
#import "MMErrorNotebookModel.h"
@interface MMErrorNotebookViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MMErrorNotebookHeadView *headView;
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMErrorNotebookViewController
-(NSArray *)plistArray{
    if(_plistArray == nil){
        NSString *fullPath  =  [[NSBundle mainBundle]pathForResource:@"errorNotebook.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSArray *temp = [MMErrorNotebookModel mj_objectArrayWithKeyValuesArray:listArray];
        _plistArray = temp;

    }
    return _plistArray;
}


-(MMErrorNotebookHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMErrorNotebookHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 155.0f)];
    }
    return _headView;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"错题本";
    }
    return self;
}

-(void)ENSetUpSubviews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height ) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50.0f;
    self.tableView.sectionHeaderHeight = 13.0f;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = HEXCOLOR(0xefeff4);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"sectionHead"];
    [self.tableView registerClass:[MMNotebooksSwithCell class] forCellReuseIdentifier:@"MMNotebooksSwithCell"];
     [self.tableView registerClass:[MMNotebooksTableViewCell class] forCellReuseIdentifier:@"MMNotebooksTableViewCell"];
    
    self.tableView.bounces = NO;
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
    
    [_headView setENpraticeClickBlock:^{
        
    } examClickBlock:^{
        
    }];
}

-(void)ENSetUpNavItem{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 21, 21);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"nav_shanchu"] forState:UIControlStateNormal];
    [rightBtn.imageView setContentMode:UIViewContentModeCenter];
    [rightBtn addTarget:self action:@selector(ENdropBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customRightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = customRightItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ENSetUpSubviews];
    [self ENSetUpNavItem];
    // Do any additional setup after loading the view.
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
    if(section == 0){
        return 1.0f;
    }else{
      return self.plistArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            MMNotebooksSwithCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MMNotebooksSwithCell"];
            if(cell == nil){
                cell  = [[MMNotebooksSwithCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMNotebooksSwithCell"];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setENswithChangeBlock:^(bool state) {
                
            }];
            cell.cellLine.hidden = YES;
            return cell;
        }
            break;
        case 1:{
            MMNotebooksTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MMNotebooksTableViewCell"];
            if(cell == nil){
                cell  = [[MMNotebooksTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMNotebooksTableViewCell"];
            }
            MMErrorNotebookModel *model = self.plistArray[indexPath.row];
            [cell setCellModel:model];
            if(indexPath.row == (self.plistArray.count - 1)){
                cell.cellLine.hidden = YES;
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
            
        }break;
            
        default:{
            return nil;
        }
            break;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 删除按钮
-(void)ENdropBtnClick{
    
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
