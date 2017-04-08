//
//  MMMyTrainDetailViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMMyTrainDetailViewController.h"
#import "MMTrainItemCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MMTrainItemModel.h"
#import "MMTrainCellFrameModel.h"
#import "MMTrainItemFileFrame.h"
#import "MMTrainSectionHead.h"
#import "MMTrainEndSection.h"
#import "MMTrainHeadFrameModel.h"
#import "MMTainTableHeadView.h"

@interface MMMyTrainDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,strong)MMTrainHeadFrameModel *headModel;
@property(nonatomic,strong)MMTainTableHeadView *headView;
@end

@implementation MMMyTrainDetailViewController

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

-(MMTrainHeadFrameModel *)headModel{
    if(_headModel == nil){
        _headModel = [MMTrainHeadFrameModel new];
        MMTrainHeadModel *viewModel = [MMTrainHeadModel new];
        viewModel.posterImageUrl = @"完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查";
        viewModel.userName = @"用户ABC";
        viewModel.date = @"2017-02 ~ 2017-03";
        viewModel.content = @"完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查完成100个用户调查";
        [_headModel setViewModel:viewModel];
    }
    return _headModel;
}

-(MMTainTableHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMTainTableHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        [_headView setFrameModel:self.headModel];
    }
    return _headView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"店长的岗位培训";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TDSetUpSubviews];
    // Do any additional setup after loading the view.
}

#pragma mark - subViews
-(void)TDSetUpSubviews{
    WeakSelf();
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
    
    [_headView setDropClickBlock:^(BOOL dropState) {
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakself.headModel.drop = dropState;
            [weakself.headView setFrameModel:weakself.headModel];
            [weakself.tableView setTableHeaderView:weakself.headView];
            [weakself.tableView beginUpdates];
            [weakself.tableView endUpdates];
        } completion:nil];
        
    }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
