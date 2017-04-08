//
//  MMExamViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamViewController.h"
#import "MMExamCollectionCell.h"
#import "MMExamBottomBar.h"
#import "MMExamTitleView.h"
#import "MMExamCardDropView.h"
#import "MMExamPromotView.h"
#import "JCAlertView.h"
@class MMExamModel;
@interface MMExamViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectView;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)MMExamBottomBar *bottomBar;
@property(nonatomic,strong)UIButton *BtnTrue;
@property(nonatomic,strong)UIButton *BtnFalse;
@property(nonatomic,strong)MMExamTitleView *titleView;
@property(nonatomic,strong)MMExamCardDropView *menuView;

@property(nonatomic,strong)MMExamPromotView *PromotView;
@property(nonatomic,strong)JCAlertView *AlertPromot;
@property(nonatomic,strong)JCAlertView *AlertResult;
@property(nonatomic,strong)NSArray *plistArray;
@end

@implementation MMExamViewController

-(NSArray *)plistArray{
    if(_plistArray  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMExam.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        _plistArray = [MMExamModel mj_objectArrayWithKeyValuesArray:listArray];
    }
    return _plistArray;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if(_flowLayout == nil){
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.itemSize = CGSizeMake(kScreenWidth,kScreenHeight  - kNavigationBarAndStateBarHeight - 65.0f);
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.minimumLineSpacing = 0.0f;
        _flowLayout.minimumInteritemSpacing = 0.0f;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}
-(UICollectionView *)collectView{
    if(_collectView == nil){
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight - kNavigationBarAndStateBarHeight - 65.0f) collectionViewLayout:self.flowLayout];
        [_collectView registerClass:[MMExamCollectionCell class] forCellWithReuseIdentifier:@"MMExamCollectionCell"];
        _collectView.showsHorizontalScrollIndicator = NO;
        _collectView.backgroundColor = [UIColor whiteColor];
        _collectView.pagingEnabled = YES;
        _collectView.delegate = self;
        _collectView.dataSource = self;
    }
    return _collectView;
}

-(MMExamBottomBar *)bottomBar{
    if(_bottomBar == nil){
        _bottomBar = [[MMExamBottomBar alloc]initWithFrame:CGRectMake(0,kScreenHeight - kNavigationBarAndStateBarHeight - 65.0f, kScreenWidth, 65.0f)];
    }
    return _bottomBar;
}

-(MMExamCardDropView *)menuView{
    if(_menuView == nil){
        _menuView = [[MMExamCardDropView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0f)];
        _menuView.bgframe = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarAndStateBarHeight - 65.0f);
    }
    return _menuView;
}

-(UIButton *)BtnTrue{
    if(_BtnTrue == nil){
        _BtnTrue = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 53.0f, 26.0f)];
        [_BtnTrue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_BtnTrue.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_BtnTrue setImage:[UIImage imageNamed:@"nav_zhengque"] forState:UIControlStateNormal];
        [_BtnTrue.imageView setContentMode:UIViewContentModeCenter];
        [_BtnTrue setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        _BtnTrue.layer.cornerRadius = 13.0f;
        _BtnTrue.layer.masksToBounds = YES;
        [_BtnTrue addTarget:self action:@selector(EVTrueBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _BtnTrue;
}

-(UIButton *)BtnFalse{
    if(_BtnFalse == nil){
        _BtnFalse = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 53.0f, 26.0f)];
        [_BtnFalse setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_BtnFalse.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_BtnFalse setImage:[UIImage imageNamed:@"nav_cuowu"] forState:UIControlStateNormal];
        [_BtnFalse.imageView setContentMode:UIViewContentModeCenter];
        [_BtnFalse setBackgroundColor:HEXCOLOR(0xff6633) forState:UIControlStateNormal];
        _BtnFalse.layer.cornerRadius = 13.0f;
        _BtnFalse.layer.masksToBounds = YES;
        [_BtnFalse addTarget:self action:@selector(EVFalseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _BtnFalse;
}

-(MMExamTitleView *)titleView{
    if(_titleView == nil){
        _titleView = [[MMExamTitleView alloc]initWithFrame:CGRectMake(0, 0, 93.0f, 27.0f)];
        NSString *totalstr = [NSString stringWithFormat:@"%lu",self.plistArray.count];
        _titleView.total = totalstr;
    }
    return _titleView;
}

-(MMExamPromotView *)PromotView{
    if(_PromotView == nil){
        _PromotView = [[MMExamPromotView alloc]initWithFrame:CGRectMake(0, 0, 300.0f,175.0f)];
        [_PromotView setRemainNum:@"15"];
    }
    return _PromotView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self EVSetNavItems];
    [self EVSetUpSubviews];
    [self performSelector:@selector(showPromot) withObject:nil afterDelay:0.8];
    // Do any additional setup after loading the view.
}

-(void)EVSetNavItems{
    UIBarButtonItem *TrueRightItem = [[UIBarButtonItem alloc] initWithCustomView:self.BtnTrue];
    UIBarButtonItem *FalseRightItem = [[UIBarButtonItem alloc] initWithCustomView:self.BtnFalse];
    self.navigationItem.rightBarButtonItems = @[FalseRightItem,TrueRightItem];
    self.navigationItem.titleView = self.titleView;
}

-(void)EVSetUpSubviews{
    WeakSelf();
    [self.view addSubview:self.collectView];
    [self.view addSubview:self.bottomBar];
    [self.view addSubview:self.menuView];
    
    [self.PromotView setCancleClickBlock:^{
        [weakself.AlertPromot dismissWithCompletion:nil];
    } ConfirmClickBlock:^{
        [weakself.AlertPromot dismissWithCompletion:nil];
    } CheakClickBlock:^{
        [weakself.AlertPromot dismissWithCompletion:nil];
    }];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1.0f;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.plistArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MMExamCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MMExamCollectionCell" forIndexPath:indexPath];
    MMExamModel *model = self.plistArray[indexPath.row];
    [cell setCellModel:model];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -  正确按钮点击
-(void)EVTrueBtnClick{
    [_menuView showMenu];
}

#pragma mark -  错误按钮点击
-(void)EVFalseBtnClick{
    [_menuView hidenMenu];
}

-(void)showPromot{
    _AlertPromot = [[JCAlertView alloc]initWithCustomView:self.PromotView dismissWhenTouchedBackground:NO];
    [_AlertPromot show];
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
