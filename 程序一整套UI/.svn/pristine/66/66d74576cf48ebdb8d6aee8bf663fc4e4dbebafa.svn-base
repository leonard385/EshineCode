//
//  MMMyTrainOfflineDetailController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMMyTrainOfflineDetailController.h"
#import "MMTrainItemModel.h"
#import "MMTrainCellFrameModel.h"
#import "MMmyTainOfflineHead.h"
#import "MMTrainItemCell.h"
#import "MMTrainSectionHead.h"
#import "MMTrainEndSection.h"
@interface MMMyTrainOfflineDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,strong)MMmyTainOfflineHead *headView;
@end

@implementation MMMyTrainOfflineDetailController

-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMTrianItem.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        [MMTrainItemModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"files" : @"MMTrainItemFileModel",
                     };
        }];
        NSArray *models = [MMTrainItemModel mj_objectArrayWithKeyValuesArray:listArray];
        
        NSMutableArray *frameModels = [NSMutableArray new];
        [models enumerateObjectsUsingBlock:^(MMTrainItemModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            MMTrainCellFrameModel *frameModel = [MMTrainCellFrameModel new];
            [frameModel setCellModel:model];
            [frameModels addObject:frameModel];
        }];
        _plistArray = [frameModels copy];
    }
    return _plistArray;
}

-(MMmyTainOfflineHead *)headView{
    if(_headView == nil){
        _headView = [[MMmyTainOfflineHead alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 324.0f)];
    }
    return _headView;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"离线任务详情";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self TOsetUpSubviews];
}

-(void)TOsetUpSubviews{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.width,self.view.height - kNavigationBarAndStateBarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MMTrainItemCell class] forCellReuseIdentifier:@"MMTrainItemCell"];
    [self.tableView registerClass:[MMTrainSectionHead class] forHeaderFooterViewReuseIdentifier:@"MMTrainSectionHead"];
    [self.tableView registerClass:[MMTrainEndSection class] forHeaderFooterViewReuseIdentifier:@"MMTrainEndSection"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.plistArray.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section < self.plistArray.count){
        MMTrainCellFrameModel *model =_plistArray[indexPath.section];
        return model.cellHeight;
    }else{
        return 0.0f;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section < self.plistArray.count){
        return 1.0f;
    }else{
        return 0.0f;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMTrainItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTrainItemCell"];
    if(cell == nil){
        cell = [[MMTrainItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMTrainItemCell"];
    }
    MMTrainCellFrameModel *model =_plistArray[indexPath.section];
    [cell setFrameModel:model];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section < self.plistArray.count){
        return 44.0f;
    }else{
        return 25.0f;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WeakSelf();
    if(section < self.plistArray.count){
        MMTrainSectionHead *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MMTrainSectionHead"];
        if(headView == nil){
            headView = [[MMTrainSectionHead  alloc]initWithReuseIdentifier:@"MMTrainSectionHead"];
        }
        MMTrainCellFrameModel *model =_plistArray[section];
        [headView setDropState:model.drop];
        [headView setTitle:model.cellModel.title];
        
        [headView setDropBtnClickBlock:^(BOOL isdrop) {
            MMTrainCellFrameModel *model = _plistArray[section];
            [model setDrop:isdrop];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0.0f inSection:section];
            
            [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        return headView;
    }else{
        MMTrainEndSection *headEndView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MMTrainEndSection"];
        if(headEndView == nil){
            headEndView = [[MMTrainEndSection  alloc]initWithReuseIdentifier:@"MMTrainEndSection"];
        }
        return headEndView;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
