//
//  CXsearchController.m
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "CXSearchController.h"
#import "CXSearchSectionModel.h"
#import "CXSearchModel.h"
#import "CXSearchCollectionViewCell.h"
#import "SelectCollectionReusableView.h"
#import "SelectCollectionLayout.h"
#import "CXDBHandle.h"

static NSString *const kcxSearchCollectionViewCell = @"CXSearchCollectionViewCell";

static NSString *const kheaderViewIden = @"HeadViewIden";

@interface CXSearchController()<UICollectionViewDataSource,UICollectionViewDelegate,SelectCollectionCellDelegate,UICollectionReusableViewButtonDelegate,UITextFieldDelegate>

/**
 *  存储网络请求的热搜，与本地缓存的历史搜索model数组
 */
@property (nonatomic, strong) NSMutableArray *sectionArray;
/**
 *  存搜索的数组 字典
 */
@property (nonatomic,strong) NSMutableArray *searchArray;

@property (strong, nonatomic) UICollectionView *cxSearchCollectionView;

@property (nonatomic,strong) UIView *searchContent;
@property (nonatomic,strong) UIImageView *searchIcon;
@property (strong, nonatomic) UITextField *cxSearchTextField;


@end

@implementation CXSearchController

-(NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

-(NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

-(UIView *)searchContent{
    if(_searchContent == nil){
        _searchContent = [[UIView alloc]init];
        _searchContent.backgroundColor = HEXCOLOR(0xefeff4);
        _searchContent.layer.cornerRadius = 2.5f;
        _searchContent.layer.masksToBounds = YES;
    }
    return _searchContent;
}

-(UIImageView *)searchIcon{
    if(_searchIcon == nil){
        _searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_ck"]];
    }
    return _searchIcon;
}


-(UITextField *)cxSearchTextField{
    if(_cxSearchTextField == nil){
        _cxSearchTextField = [[UITextField alloc]init];
        [_cxSearchTextField setPlaceholder:@"请输入搜索关键词"];
        [_cxSearchTextField setFont:[UIFont systemFontOfSize:15.0f]];
        [_cxSearchTextField setBorderStyle:UITextBorderStyleNone];
        [_cxSearchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        _cxSearchTextField.delegate = self;
    }
    return _cxSearchTextField;
}


-(UICollectionView *)cxSearchCollectionView{
    if(_cxSearchCollectionView == nil){
        _cxSearchCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(12.0f,0,self.view.frame.size.width - 12.0f * 2.0f,self.view.frame.size.height  - 64.0f) collectionViewLayout:[SelectCollectionLayout new]];
        [_cxSearchCollectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderViewIden];
        [_cxSearchCollectionView registerNib:[UINib nibWithNibName:@"CXSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kcxSearchCollectionViewCell];
        _cxSearchCollectionView.backgroundColor = [UIColor whiteColor];
        _cxSearchCollectionView.delegate = self;
        _cxSearchCollectionView.dataSource = self;
    }
    return _cxSearchCollectionView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self prepareData];
    [self SCSetUpNavItem];
    [self SCSetUpSubviews];
}

-(void)SCSetUpNavItem{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 54, 30);
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn.imageView setContentMode:UIViewContentModeCenter];
    [rightBtn addTarget:self action:@selector(CancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customRightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = customRightItem;
   
    [self.searchContent addSubview:self.searchIcon];
    [self.searchContent addSubview:self.cxSearchTextField];
    
    CGFloat contentX = 0.0f;
    CGFloat contentY = (44.0f - 30.0f)/2.0f;
    CGFloat contentW = kScreenWidth - 54.f - 12.0f;
    CGFloat contentH = 30.0f;
    _searchContent.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGFloat searchIconW = 11.0f;
    CGFloat searchIconH = 11.0f;
    CGFloat searchIconX = 11.0f;
    CGFloat searchIconY = (contentH - searchIconH)/2.0f;
    _searchIcon.frame = CGRectMake(searchIconX, searchIconY, searchIconW, searchIconH);
    
    
    CGFloat TextFieldX = CGRectGetMaxX(_searchIcon.frame) + 10.0f;
    CGFloat TextFieldY = 0.0f;
    CGFloat TextFieldW = contentW - TextFieldX - 20.0f;
    CGFloat TextFieldH = contentH;
    _cxSearchTextField.frame = CGRectMake(TextFieldX, TextFieldY, TextFieldW, TextFieldH);
    
    self.navigationItem.titleView = self.searchContent;
}

-(void)SCSetUpSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cxSearchCollectionView];
    /***  可以做实时搜索*/
    //    [self.cxSearchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - 初始化数据
- (void)prepareData
{
    /**
     *  测试数据 ，字段暂时 只用一个 titleString，后续可以根据需求 相应加入新的字段
     */
    NSDictionary *testDict = @{@"section_id":@"1",@"section_title":@"热门搜索",@"section_content":@[@{@"content_name":@"计算机二级"},@{@"content_name":@"HTML5"}]};
    NSMutableArray *testArray = [@[] mutableCopy];
    [testArray addObject:testDict];
    
    /***  去数据查看 是否有数据*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    NSDictionary *dbDictionary =  [CXDBHandle statusesWithParams:parmDict];
    
    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }
    
    for (NSDictionary *sectionDict in testArray) {
        CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:sectionDict];
        [self.sectionArray addObject:model];
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.cxSearchTextField becomeFirstResponder];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CXSearchSectionModel *sectionModel =  self.sectionArray[section];
    return sectionModel.section_contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcxSearchCollectionViewCell forIndexPath:indexPath];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [cell.contentButton setTitle:contentModel.content_name forState:UIControlStateNormal];
    cell.selectDelegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        SelectCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kheaderViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        [view setText:sectionModel.section_title];
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        if(indexPath.section == 0)
        {
            [view setImage:@"cxCool"];
            view.delectButton.hidden = YES;
        }else{
            [view setImage:@"cxSearch"];
            view.delectButton.hidden = NO;
        }
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    if (sectionModel.section_contentArray.count > 0) {
        CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        return [CXSearchCollectionViewCell getSizeWithText:contentModel.content_name];
    }
    return CGSizeMake(80, 24);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - SelectCollectionCellDelegate
- (void)selectButttonClick:(CXSearchCollectionViewCell *)cell;
{
    NSIndexPath* indexPath = [self.cxSearchCollectionView indexPathForCell:cell];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    NSLog(@"您选的内容是：%@",contentModel.content_name);
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"您该去搜索 %@ 的相关内容了",contentModel.content_name] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了！", nil];
    [al show];
}

#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData:(SelectCollectionReusableView *)view;
{
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
        [self.searchArray removeAllObjects];
        [self.cxSearchCollectionView reloadData];
        [CXDBHandle saveStatuses:@{} andParam:@{@"category":@"1"}];
    }
}
#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.cxSearchTextField resignFirstResponder];
}
#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"content_name"]]) {
        return YES;
    }
    [self reloadData:textField.text];
    return YES;
}
- (void)reloadData:(NSString *)textString
{
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"content_name"]];
    
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":self.searchArray};
    
    /***由于数据量并不大 这样每次存入再删除没问题  存数据库*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    [CXDBHandle saveStatuses:searchDict andParam:parmDict];
    
    CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    [self.cxSearchCollectionView reloadData];
    self.cxSearchTextField.text = @"";
}
#pragma mark  - 取消点击
-(void)CancelBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
