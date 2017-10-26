//
//  FavoritesDemoViewController.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/5/8.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "FavoritesDemoViewController.h"
#import "PromptInfo.h"

#define INDEX_TAG_DIS   1000

@interface MyFavoriteAnnotation : BMKPointAnnotation

@property (nonatomic, assign) NSInteger favIndex;
@property (nonatomic, strong) BMKFavPoiInfo *favPoiInfo;

@end

@implementation MyFavoriteAnnotation

@synthesize favIndex = _favIndex;
@synthesize favPoiInfo = _favPoiInfo;

@end

@interface FavoritesDemoViewController ()<BMKMapViewDelegate> {
    BMKFavPoiManager *_favManager;
    CLLocationCoordinate2D _coor;
    NSMutableArray *_favPoiInfos;
    NSInteger _curFavIndex;
}

@end

@implementation FavoritesDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
    tap.cancelsTouchesInView = NO;//添加自定义手势时，需设置，否则影响地图的操作
    tap.delaysTouchesEnded = NO;//添加自定义手势时，需设置，否则影响地图的操作
    [self.view addGestureRecognizer:tap];
    
    _updateView.hidden = YES;//隐藏update view
    
    _favManager = [[BMKFavPoiManager alloc] init];
    _favPoiInfos = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}
- (void)dealloc {
    _mapView = nil;
    _favManager = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hiddenKeyBoard {
    [_nameTextField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//收藏点
- (IBAction)saveAction:(id)sender {
    [self hiddenKeyBoard];
    if (_nameTextField.text.length == 0) {
        [PromptInfo showText:@"请输入名称"];
        return;
    }
    if (_coor.latitude == 0 && _coor.longitude == 0) {
        [PromptInfo showText:@"请获取经纬度"];
        return;
    }
    BMKFavPoiInfo *poiInfo = [[BMKFavPoiInfo alloc] init];
    poiInfo.pt = _coor;
    poiInfo.poiName = _nameTextField.text;
    NSInteger res = [_favManager addFavPoi:poiInfo];
    if (res == 1) {
        [PromptInfo showText:@"保存成功"];
    } else {
        [PromptInfo showText:@"保存失败"];
    }
}

//获取所有收藏点
- (IBAction)getAllAction:(id)sender {
    [self hiddenKeyBoard];
    NSArray *favPois = [_favManager getAllFavPois];
    if (favPois == nil) {
        return;
    }
    [_favPoiInfos removeAllObjects];
    [_favPoiInfos addObjectsFromArray:favPois];
    [self updateMapAnnotations];
}

//删除所有收藏点
- (IBAction)deleteAllAction:(id)sender {
    [self hiddenKeyBoard];
    BOOL res = [_favManager clearAllFavPois];
    if (res) {
        [PromptInfo showText:@"清除成功"];
        [_favPoiInfos removeAllObjects];
        [self updateMapAnnotations];
    } else {
        [PromptInfo showText:@"清除失败"];
    }
}

///取消更新
- (IBAction)updateCancelAction:(id)sender {
    [self cancelUpdateView];
}

///保存更新
- (IBAction)updateSaveAction:(id)sender {
    CGFloat lat = [_updateLatTextField.text doubleValue];
    if (lat == 0 || lat < -90 || lat > 90) {
        [PromptInfo showText:@"请输入正确的纬度"];
        return;
    }
    CGFloat lon = [_updateLonTextField.text doubleValue];
    if (lon == 0 || lon < -180 || lon > 180) {
        [PromptInfo showText:@"请输入正确的经度"];
        return;
    }
    if (_updateNameTextField.text.length == 0) {
        [PromptInfo showText:@"请输入名称"];
        return;
    }
    BMKFavPoiInfo *favInfo = [_favPoiInfos objectAtIndex:_curFavIndex];
    favInfo.pt = CLLocationCoordinate2DMake(lat, lon);
    favInfo.poiName = _updateNameTextField.text;
    BOOL res = [_favManager updateFavPoi:favInfo.favId favPoiInfo:favInfo];
    if (res) {
        [PromptInfo showText:@"更新成功"];
        [self cancelUpdateView];
        [self updateMapAnnotations];
    } else {
        [PromptInfo showText:@"更新失败"];
    }
}

///点击paopao更新按钮
- (void)updateAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    _curFavIndex = button.tag - INDEX_TAG_DIS;
    if (_curFavIndex < _favPoiInfos.count) {
        BMKFavPoiInfo *favInfo = [_favPoiInfos objectAtIndex:_curFavIndex];
        _updateLatTextField.text = [NSString stringWithFormat:@"%lf", favInfo.pt.latitude];
        _updateLonTextField.text = [NSString stringWithFormat:@"%lf", favInfo.pt.longitude];
        _updateNameTextField.text = favInfo.poiName;
        [_updateLatTextField becomeFirstResponder];
        _updateView.hidden = NO;
    }
}

///点击paopao删除按钮
- (void)deleteAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger favIndex = button.tag - INDEX_TAG_DIS;
    if (favIndex < _favPoiInfos.count) {
        BMKFavPoiInfo *favInfo = [_favPoiInfos objectAtIndex:favIndex];
        if ([_favManager deleteFavPoi:favInfo.favId]) {
            [_favPoiInfos removeObjectAtIndex:favIndex];
            [self updateMapAnnotations];
            [PromptInfo showText:@"删除成功"];
            return;
        }
    }
    [PromptInfo showText:@"删除失败"];
}

///更新地图标注
- (void)updateMapAnnotations {
    [_mapView removeAnnotations:_mapView.annotations];
    NSInteger index = 0;
    NSMutableArray *annos = [NSMutableArray array];
    for (BMKFavPoiInfo *info in _favPoiInfos) {
        MyFavoriteAnnotation *favAnnotation = [[MyFavoriteAnnotation alloc] init];
        favAnnotation.title = info.poiName;
        favAnnotation.coordinate = info.pt;
        favAnnotation.favPoiInfo = info;
        favAnnotation.favIndex = index;
        
        [annos addObject:favAnnotation];
        index++;
    }
    [_mapView addAnnotations:annos];
//    [_mapView showAnnotations:annos animated:YES];
}

///取消显示更新view
- (void)cancelUpdateView {
    [_updateLatTextField resignFirstResponder];
    [_updateLonTextField resignFirstResponder];
    [_updateNameTextField resignFirstResponder];
    _updateView.hidden = YES;
}

#pragma mark - BMKMapViewDelegate
/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    [self hiddenKeyBoard];
}

/**
 *双击地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回双击处坐标点的经纬度
 */
-(void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi {
    [self hiddenKeyBoard];
}

/**
 *长按地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate {
    _coor = coordinate;
    _coorLabel.text = [NSString stringWithFormat:@"%lf,%lf", coordinate.longitude,coordinate.latitude];
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"FavPoiMark"];
    // 设置颜色
    annotationView.pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
    annotationView.animatesDrop = NO;
    // 设置可拖拽
    annotationView.draggable = YES;
    annotationView.canShowCallout = YES;
    annotationView.annotation = annotation;
    
    MyFavoriteAnnotation *myAnotation = (MyFavoriteAnnotation *)annotation;
    ///添加更新按钮
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    updateButton.frame = CGRectMake(10, 0, 32, 41);
    [updateButton setTitle:@"更新" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
    updateButton.tag = myAnotation.favIndex + INDEX_TAG_DIS;
    annotationView.leftCalloutAccessoryView = updateButton;
    ///添加删除按钮
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeSystem];
    delButton.frame = CGRectMake(10, 0, 32, 41);
    [delButton setTitle:@"删除" forState:UIControlStateNormal];
    [delButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    delButton.tag = myAnotation.favIndex + INDEX_TAG_DIS;
    annotationView.rightCalloutAccessoryView = delButton;
    
    return annotationView;
}

@end
