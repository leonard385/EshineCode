//
//  MMTrainDispatchController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainDispatchController.h"
#import "MMTrainDispatchCell.h"
#import "MMTrainCreateViewController.h"
#import "MMTrainOfflineCreateController.h"
#import "MMTrainDispathController.h"
#import "MMTrainDispathAllController.h"
#import "MMTrainDispathUndoController.h"
#import "MMTrainDispathDoingController.h"
#import "MMTrainDispathDoneController.h"

#import "MMTrainDispathOfflineController.h"
#import "MMTrainOfflineAllController.h"
#import "MMTrainOfflineNorController.h"
#import "MMTrainOfflineLateController.h"
#import "MMTrainOfflineAbsentController.h"

#import "UPStackMenu.h"

@interface MMTrainDispatchController ()<UITableViewDelegate,UITableViewDataSource,UPStackMenuDelegate>
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,strong)UIView *addContentView;
@property(nonatomic,strong)UIImageView *addTrainImage;
@property(nonatomic,strong)UPStackMenu *stackMenu;
@end

@implementation MMTrainDispatchController

-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMWorkDispatch.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        _plistArray = [MMWorkDispatchModel mj_objectArrayWithKeyValuesArray:listArray];
    }
    return _plistArray;
}

-(UIView *)addContentView{
    if(_addContentView == nil){
        _addContentView = [UIView new];
        _addContentView.frame = CGRectMake(0, 0, 60, 60);
        _addContentView.backgroundColor = HEXCOLOR(0xfaa81f);
        _addContentView.layer.cornerRadius = 30.0f;
        _addContentView.layer.masksToBounds = YES;
        [_addContentView  addSubview:self.addTrainImage];
    }
    return _addContentView;
}

-(UIImageView *)addTrainImage{
    if(_addTrainImage == nil){
        _addTrainImage = [[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"bth_icon_fbgz"]];
        [_addTrainImage setContentMode:UIViewContentModeCenter];
        _addTrainImage.frame = _addContentView.frame;
    }
    return _addTrainImage;
}

-(UPStackMenu *)stackMenu{
    if(_stackMenu == nil){
        _stackMenu = [[UPStackMenu alloc] initWithContentView:self.addContentView];
        CGFloat addContentX = kScreenWidth - 20.0f - 30.0f;
        CGFloat addContentY = kScreenHeight - 18.0f - 30.0f - kNavigationBarAndStateBarHeight;
        [_stackMenu setCenter:CGPointMake(addContentX, addContentY)];
        [_stackMenu setDelegate:self];
        UPStackMenuItem *onlineItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"bth_icon_xspx"] highlightedImage:nil title:@"线上培训" font:[UIFont systemFontOfSize:14.0f]];
        UPStackMenuItem *offlineItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"bth_icon_xxpx"] highlightedImage:nil title:@"线下培训" font:[UIFont systemFontOfSize:14.0f]];
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:offlineItem, onlineItem,nil];
        [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
            [item setTitleColor:HEXCOLOR(0x333333)];
        }];
                                 
        [_stackMenu setAnimationType:UPStackMenuAnimationType_progressive];
        [_stackMenu setStackPosition:UPStackMenuStackPosition_up];
        [_stackMenu setOpenAnimationDuration:.4];
        [_stackMenu setCloseAnimationDuration:.4];
        [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
             [item setLabelPosition:UPStackMenuItemLabelPosition_left];
        }];
        [_stackMenu addItems:items];
    }
    return _stackMenu;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self WDSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_stackMenu closeStack];
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
    [self.view addSubview:self.stackMenu];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.plistArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMTrainDispatchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTrainDispatchCell"];
    
    if(cell == nil){
        cell = [[MMTrainDispatchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMTrainDispatchCell"];
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
    if(indexPath.row % 2){
      NSArray *VCs = [NSArray arrayWithObjects:
                     [MMTrainDispathAllController new],
                     [MMTrainDispathUndoController new],
                     [MMTrainDispathDoingController new],
                     [MMTrainDispathDoneController new],nil];
    
      NSArray *titles = [NSArray arrayWithObjects:
                        @"全部",
                        @"未完成",
                        @"进行中",
                        @"已完成",nil];
      MMTrainDispathController *WDVc = [[MMTrainDispathController alloc]initWithControllers:VCs titles:titles];
     [self.parentViewController.navigationController pushViewController:WDVc animated:YES];
    }else{
        
        NSArray *VCs = [NSArray arrayWithObjects:
                        [MMTrainOfflineAllController new],
                        [MMTrainOfflineNorController new],
                        [MMTrainOfflineLateController new],
                        [MMTrainOfflineAbsentController new],nil];
        
        NSArray *titles = [NSArray arrayWithObjects:
                           @"全部",
                           @"正常",
                           @"迟到",
                           @"缺勤",nil];
       
        MMTrainDispathOfflineController *DOVc = [[MMTrainDispathOfflineController alloc]initWithControllers:VCs titles:titles];
        [self.parentViewController.navigationController pushViewController:DOVc animated:YES];
    }

}
#pragma mark - 添加培训点击
-(void)TDAddTrainClick{
    
    MMTrainCreateViewController *vc = [MMTrainCreateViewController new];
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UPStackMenuDelegate

- (void)stackMenuWillOpen:(UPStackMenu *)menu{
    
}

- (void)stackMenuWillClose:(UPStackMenu *)menu{
}

- (void)stackMenu:(UPStackMenu *)menu didTouchItem:(UPStackMenuItem *)item atIndex:(NSUInteger)index{
    if(index == 0){
        MMTrainOfflineCreateController *vc = [MMTrainOfflineCreateController new];
        [self.parentViewController.navigationController pushViewController:vc animated:YES];
    }else{
        MMTrainCreateViewController *vc = [MMTrainCreateViewController new];
        [self.parentViewController.navigationController pushViewController:vc animated:YES];
    }
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
