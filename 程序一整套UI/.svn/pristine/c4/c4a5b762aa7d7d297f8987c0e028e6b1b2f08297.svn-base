//
//  MMEmployMannagerViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployMannagerViewController.h"
#import "MMEmployMannagerBottomBar.h"
#import "MMEmployMannagerCollectionViewCell.h"
#import "MMEmployInfoViewController.h"
#import "MMfilterTableView.h"
#import "MMFilterGroupModel.h"
#import "MMFilterFriendModel.h"
@interface MMEmployMannagerViewController ()<UISearchBarDelegate,UISearchResultsUpdating,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UISearchController *searchController;
@property(nonatomic,strong)MMEmployMannagerBottomBar *bottomBar;
@property(nonatomic,strong)UIButton *btnAddMember;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)UICollectionView *collection;
@property(nonatomic,strong)NSArray *searchArray;
@property(nonatomic,assign)CGFloat barTopConstant;

@property(nonatomic,strong)MMfilterTableView *filterView;
@property(nonatomic,strong)NSArray *filterPlist;
@end

@implementation MMEmployMannagerViewController
-(UISearchController *)searchController{
    if(_searchController == nil){
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.tintColor = HEXCOLOR(0xaaaaaa);
        _searchController.searchBar.barTintColor = HEXCOLOR(0xf0f3f8);
        _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.dimsBackgroundDuringPresentation = NO;
        [_searchController.searchBar sizeToFit];

    }
    return _searchController;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if(_flowLayout == nil){
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.itemSize = CGSizeMake(112.0f, 142.0f);
        _flowLayout.sectionInset = UIEdgeInsetsMake(2.0f, 12.0f, 12.0f, 12.0f);
        _flowLayout.minimumLineSpacing = 12.0f;
        _flowLayout.minimumInteritemSpacing = 4.0f;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

-(UICollectionView *)collection{
    if(_collection == nil){
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,45.0f, kScreenWidth,self.view.height - kNavigationBarAndStateBarHeight - 45.0f) collectionViewLayout:self.flowLayout];
        [_collection registerClass:[MMEmployMannagerCollectionViewCell class] forCellWithReuseIdentifier:@"MMEmployMannagerCollectionViewCell"];
        [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
        _collection.showsVerticalScrollIndicator = YES;
        _collection.backgroundColor = HEXCOLOR(0xf0f3f8);
        _collection.delegate = self;
        _collection.dataSource = self;
    }
    return _collection;
}

-(MMEmployMannagerBottomBar *)bottomBar{
    if(_bottomBar == nil){
        _bottomBar = [[MMEmployMannagerBottomBar alloc]init];
    }
    return _bottomBar;
}

-(UIButton *)btnAddMember{
    if(_btnAddMember == nil){
        _btnAddMember = [UIButton  new];
        [_btnAddMember setImage:[UIImage imageNamed:@"bth_icon_xzry"] forState:UIControlStateNormal];
        [_btnAddMember setBackgroundColor:HEXCOLOR(0xfaa81f) forState:UIControlStateNormal];
        _btnAddMember.layer.cornerRadius = 30.0f;
        _btnAddMember.layer.masksToBounds = YES;
        [_btnAddMember addTarget:self action:@selector(EMAddMemberClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddMember;
}

-(NSArray *)filterPlist{
    if(_filterPlist  == nil){
        NSString *plistPath  =  [[NSBundle mainBundle]pathForResource:@"MMContantGroups.plist" ofType:nil];
        NSArray *listArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        [MMFilterGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"friends" : @"MMFilterFriendModel",
                     };
        }];
        NSArray *models = [MMFilterGroupModel mj_objectArrayWithKeyValuesArray:listArray];
        
        _filterPlist = models;
    }
    return _filterPlist;
}


-(MMfilterTableView *)filterView{
    if(_filterView == nil){
        _filterView = [[MMfilterTableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0.0f, kScreenWidth, kScreenHeight - kNavigationBarAndStateBarHeight)];
        [_filterView setArray:self.filterPlist];
    }
    return _filterView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _barTopConstant = 0.0f;
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)updateViewConstraints{
    [_bottomBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom).with.offset(_barTopConstant);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(45.0f);
    }];
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self EMSetUpNavItems];
    [self EMSetUpSubviews];
    [self EMNoticeRegist];
    // Do any additional setup after loading the view.
}
-(void)EMSetUpSubviews{
    self.view.backgroundColor = HEXCOLOR(0xf0f3f8);
    [self.view addSubview:self.collection];
    [self.view addSubview:self.searchController.searchBar];
    [self.view addSubview:self.bottomBar];
    [self.view addSubview:self.btnAddMember];
    [self.view addSubview:self.filterView];
    
    [_btnAddMember mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_bottomBar.mas_top).with.offset(-20.0f);
        make.right.mas_equalTo(self.view).with.offset(-18.0f);
        make.size.mas_equalTo(CGSizeMake(60.0f, 60.0f));
    }];
    
    [_bottomBar setSelectAllBlock:^(bool state) {
        
    } DeleteBtnClickBlock:^{
        
    }];
}

-(void)EMNoticeRegist{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(EMeditNotic:) name:kMemberEditNotice object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MemberFilterNotice:) name:kMemberFilterNotice object:nil];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1.0f;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10.0f;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MMEmployMannagerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MMEmployMannagerCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.DateArray removeAllObjects];
    //执行搜索操作
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",_searchController.searchBar.text];
    self.searchArray = [[self.DateArray filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    //刷新表格
    [self.tableView reloadData];
}


#pragma mark - 添加
-(void)EMAddMemberClick{
    MMEmployInfoViewController *vc = [MMEmployInfoViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)EMeditNotic:(NSNotification *)notice{
    NSDictionary *userInfo = notice.userInfo;
    NSNumber *editState = userInfo[kMemberEditIsEdit];
    if(_filterView.isOpen){
        [_filterView close];
    }
    
    if(NotNilAndNull(editState)){
        if([editState boolValue]){
            _barTopConstant = -45.0f;
        }else{
            _barTopConstant = 0.0f;
        }
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:1.0f delay:0.0f usingSpringWithDamping:0.8 initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {

        }];
    }
}

-(void)MemberFilterNotice:(NSNotification *)notice{
    [_filterView toggle];
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
