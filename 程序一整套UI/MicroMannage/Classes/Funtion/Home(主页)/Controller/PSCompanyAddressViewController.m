//
//  PSCompanyAddressViewController.m
//  PracticeSaftSystem
//  Created by 梅守强 on 16/9/29.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "PSCompanyAddressViewController.h"
#import "PSCompanyAddressModel.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "BaiDuKitHeader.h"

@interface PSCompanyAddressViewController ()<UITableViewDelegate, UITableViewDataSource, BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKPoiSearchDelegate, BMKSuggestionSearchDelegate, BMKLocationServiceDelegate, UISearchBarDelegate>
@property(nonatomic,strong) BMKGeoCodeSearch *geoCodeSearch;
@property(nonatomic,strong) BMKReverseGeoCodeOption *reverseGeoCodeOption;
@property(nonatomic,strong )BMKLocationService *locService;
@property(nonatomic,strong) BMKPoiSearch *poiSearch;
@property(nonatomic,strong) BMKSuggestionSearch *sugSearch;

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *addressArray;// 地点数组
@property (nonatomic, strong) UIButton *mapPinBtn;// 地标按钮
@property (nonatomic,strong) CLGeocoder *geocoder;// 地理编码
@property (nonatomic, strong) NSMutableArray *searchArray;// 返回搜索结果
@property (nonatomic, strong) UISearchBar *searchBar;// UISearchBar
@property (nonatomic, strong) UITableView *searchTableView;// searchTableView
@property (nonatomic, strong) UIBarButtonItem *rightBtn;// 右上角按钮
@property (nonatomic, strong) BMKUserLocation *userLocation;// 保存用户当前位置
@property (nonatomic, strong) UIView *emptyView;//空白提示页

@end

@implementation PSCompanyAddressViewController

-(instancetype)init{
    self = [super init];
    if(self){
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (NSMutableArray *)searchArray {
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (NSMutableArray *)addressArray {
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

-(CLGeocoder *)geocoder {
    if (_geocoder == nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
    self.fd_interactivePopDisabled = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _poiSearch.delegate = nil;
    _geoCodeSearch.delegate = nil;
    _sugSearch.delegate = nil;
    self.fd_interactivePopDisabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self caSetupNavi];// 导航设置
    [self caSetUpSubviews];
    [self initLocationService];// 初始化地图服务
}


- (void)caSetupNavi {
    //添加searchBar
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    for (UIView *view in _searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    _searchBar.tintColor = [UIColor blueColor];
    _searchBar.placeholder = @"搜索地点或地址";
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    // 右上角按钮
    _rightBtn = [UIBarButtonItem new];
    [_rightBtn setTitle:@"搜索"];
    [_rightBtn setTintColor:HEXCOLOR(kBlueColor)];
    [_rightBtn setTarget:self];
    [_rightBtn setAction:@selector(rightBtnDidClick)];
    self.navigationItem.rightBarButtonItem = _rightBtn;
}

#pragma mark - 导航按钮点击
- (void)rightBtnDidClick {
    if ([_rightBtn.title isEqualToString:@"搜索"]) {
        [_searchBar becomeFirstResponder];
    } else if ([_rightBtn.title isEqualToString:@"取消"]) {
        self.searchTableView.hidden = YES;
        [_searchBar resignFirstResponder];
        _rightBtn.title = @"搜索";
    }
}

#pragma mark - 添加mapView
- (void)caSetUpSubviews {
    WeakSelf();
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, -1, kScreenWidth, kScreenHeight/2 + 1)];
    [self.view addSubview:_mapView];
    //定位坐标
    _mapPinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mapPinBtn.frame = CGRectMake(0, 0, 35, 35);
    [_mapPinBtn setImage:[UIImage imageNamed:@"mapPin"] forState:UIControlStateNormal];
    [_mapView addSubview:_mapPinBtn];
    [_mapPinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.mapView);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
    }];
    //定位按钮
    UIButton *btnMyLocation = [UIButton new];
    [btnMyLocation setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    [btnMyLocation.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [btnMyLocation addTarget:self action:@selector(caStartLocation) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:btnMyLocation];
    [btnMyLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_mapView).with.offset(-12.0f);
        make.bottom.mas_equalTo(_mapView).with.offset(-12.0f);
        make.size.mas_equalTo(CGSizeMake(38, 37));
    }];
    
    //tableView
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mapView.mas_bottom).with.offset(0);
        make.left.equalTo(weakself.view.mas_left).with.offset(0);
        make.bottom.equalTo(weakself.view.mas_bottom).with.offset(0);
        make.right.equalTo(weakself.view.mas_right).with.offset(0);
    }];

}

- (void)caStartLocation {
    [self setMapViewCenter:self.userLocation.location.coordinate];
    _mapView.zoomLevel=17;
}


#pragma mark - SearchBar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _rightBtn.title = @"取消";
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        [self.view addSubview:_searchTableView];
    }
    _searchTableView.hidden = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //初始化检索对象
    _sugSearch = [[BMKSuggestionSearch alloc]init];
    _sugSearch.delegate = self;
    BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
    option.cityname = @"中国";
    option.keyword  = searchBar.text;
    BOOL flag = [_sugSearch suggestionSearch:option];
    if(flag)
    {
        NSLog(@"建议检索发送成功");
    }
    else
    {
        NSLog(@"建议检索发送失败");
    }
    
    if (searchText.length == 0) {
        [self.searchArray removeAllObjects];
        [self.searchTableView reloadData];
    }
}

#pragma mark - UITableView Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return self.addressArray.count;
    } else {
        if (self.searchArray.count == 0) {
            if (!self.emptyView) {
                self.emptyView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
                self.emptyView.backgroundColor = HEXCOLOR(0xf3f3f3);
                [self.searchTableView addSubview:self.emptyView];
                [self.searchTableView bringSubviewToFront:self.emptyView];
                // 无结果
                UILabel *label = [UILabel new];
                label.textColor = HEXCOLOR(0xcccccc);
                label.font = [UIFont systemFontOfSize:19];
                label.text = @"无结果";
                [self.emptyView addSubview:label];
                // 约束
                WeakSelf();
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(weakself.emptyView);
                    make.top.equalTo(weakself.emptyView.mas_top).with.offset(kScreenHeight/3);
                    make.height.equalTo(@20);
                }];
            } else {
                self.emptyView.hidden = NO;
            }
        } else {
            self.emptyView.hidden = YES;
        }
        return self.searchArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (tableView == self.tableView) {
        PSCompanyAddressModel *model=self.addressArray[indexPath.row];
        cell.textLabel.text=model.name;
        cell.detailTextLabel.text=model.address;
    }else{
        PSCompanyAddressModel *model=self.searchArray[indexPath.row];
        cell.textLabel.text=model.name;
        cell.detailTextLabel.text=model.address;
    }
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        NSString *addStr = [self.addressArray[indexPath.row]address];
        if ([addStr isEqualToString:@" "]) {
            [self.delegate didSelectCompanyAddress:[self.addressArray[indexPath.row]name]coordinate:[self.addressArray[indexPath.row]locationCoordinate]];
        } else {
            [self.delegate didSelectCompanyAddress:addStr coordinate:[self.addressArray[indexPath.row]locationCoordinate]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.searchTableView.hidden = YES;
        _rightBtn.title = @"搜索";
        // 将地图中心点移到指定经纬度
        PSCompanyAddressModel *model=self.searchArray[indexPath.row];
        [self setMapViewCenter:model.locationCoordinate];
    }
}

#pragma mark 设置cell分割线做对齐
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark 初始化地图，定位
-(void)initLocationService
{
    _mapView.zoomLevel=17;
    _mapView.showsUserLocation = YES;
    [_mapView bringSubviewToFront:_mapPinBtn];
    
    if (_locService==nil) {
        _locService = [[BMKLocationService alloc]init];
        [_locService setDesiredAccuracy:kCLLocationAccuracyBest];
        _poiSearch = [[BMKPoiSearch alloc] init]; //创建搜索对象
        _poiSearch.delegate = self; //代理设置为自身，搜索之后会自动回调下一步中的函数
    }
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

- (void)setMapViewCenter:(CLLocationCoordinate2D)coor {
    _mapView.centerCoordinate = coor;
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = _mapView.centerCoordinate;//中心点
    region.span.latitudeDelta = 0.004;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.004;//纬度范围
    [_mapView setRegion:region animated:YES];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (!self.userLocation) {
        self.userLocation = userLocation;
        _mapView.showsUserLocation = YES;//显示定位图层
        //设置地图中心为用户经纬度
        [_mapView updateLocationData:self.userLocation];
        [self setMapViewCenter:self.userLocation.location.coordinate];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self mapView:_mapView regionDidChangeAnimated:YES];
            _mapView.zoomLevel=17;
        });
    }
}

#pragma mark BMKMapViewDelegate

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapView.center toCoordinateFromView:_mapView];
    if (_geoCodeSearch==nil) {
        //初始化地理编码类
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        
    }
    if (_reverseGeoCodeOption==nil) {
        
        //初始化反地理编码类
        _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    }
    
    //需要逆地理编码的坐标位置
    _reverseGeoCodeOption.reverseGeoPoint =MapCoordinate;
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
    
}

#pragma mark - BMKGeoCodeSearchDelegate

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //获取周边用户信息
    if (error==BMK_SEARCH_NO_ERROR) {
        
        [self.addressArray removeAllObjects];
        for(BMKPoiInfo *poiInfo in result.poiList)
        {
            PSCompanyAddressModel *model=[[PSCompanyAddressModel alloc]init];
            model.name=poiInfo.name;
            model.address=poiInfo.address;
            model.locationCoordinate = poiInfo.pt;
            [self.addressArray addObject:model];
        }
    }else{
        NSLog(@"BMKSearchErrorCode: %u",error);
    }
    [self.tableView reloadData];
}

//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //  在此处理正常结果
        [self.searchArray removeAllObjects];
        for (int i = 0; i < result.keyList.count; i++) {
            PSCompanyAddressModel *model=[[PSCompanyAddressModel alloc]init];
            model.name = result.keyList[i];
            model.address = result.districtList[i];
            //            NSValue *value = result.ptList[i];
            NSValue *value = result.ptList[ i];
            CLLocationCoordinate2D coor;
            [value getValue:&coor];
            model.locationCoordinate = coor;
            [self.searchArray addObject:model];
        }
    } else {
        [self.searchArray removeAllObjects];
    }
    [self.searchTableView reloadData];
}

#pragma mark - PoiSearchDelegate处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //  在此处理正常结果
        [self.searchArray removeAllObjects];
        for (BMKPoiInfo *obj in poiResultList.poiInfoList) { // 需要里面的uid再次发送请求
            PSCompanyAddressModel *model=[[PSCompanyAddressModel alloc]init];
            model.name=obj.name;
            model.address=obj.address;
            model.locationCoordinate = obj.pt;
            [self.searchArray addObject:model];
        }
    } else {
        [self.searchArray removeAllObjects];
    }
    [self.searchTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
