//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  ZLPhotoPickerAssetsViewController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-12.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "MLSelectPhotoPickerGroup.h"
#import "MLSelectPhotoPickerDatas.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoPickerCollectionView.h"
#import "MLSelectPhotoPickerCollectionViewCell.h"
#import "MLSelectPhotoPickerFooterCollectionReusableView.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "UIView+MLExtension.h"

static CGFloat CELL_ROW = 4;
static CGFloat CELL_MARGIN = 2;
static CGFloat CELL_LINE_MARGIN = 2;
static CGFloat TOOLBAR_HEIGHT = 44;

static NSString *const _cellIdentifier = @"cell";
static NSString *const _footerIdentifier = @"FooterView";
static NSString *const _identifier = @"toolBarThumbCollectionViewCell";

@interface MLSelectPhotoPickerAssetsViewController () <ZLPhotoPickerCollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

// View
@property (nonatomic , strong) MLSelectPhotoPickerCollectionView *collectionView;

// 标记View
@property (strong,nonatomic) UILabel *makeView;
@property (strong,nonatomic) UIButton *previewBtn;
@property (strong,nonatomic) UIButton *doneBtn;
@property (strong,nonatomic) UIToolbar *toolBar;

// Datas
@property (assign,nonatomic) NSUInteger privateTempMaxCount;
// 记录选中的assets
@property (strong,nonatomic) NSMutableArray *selectAssets;
@end

@implementation MLSelectPhotoPickerAssetsViewController

#pragma mark - getter
#pragma mark Get Data
- (NSMutableArray *)selectAssets{
    if (!_selectAssets) {
        _selectAssets = [NSMutableArray array];
    }
    return _selectAssets;
}

#pragma mark Get View
- (UIButton *)doneBtn{
    if (!_doneBtn) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:91/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        rightBtn.enabled = YES;
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        rightBtn.frame = CGRectMake(0, 0, 45, 45);
        [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn addSubview:self.makeView];
        self.doneBtn = rightBtn;
    }
    return _doneBtn;
}

- (UIButton *)previewBtn{
    if (!_previewBtn) {
        UIButton *previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [previewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [previewBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        previewBtn.enabled = YES;
        previewBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        previewBtn.frame = CGRectMake(0, 0, 45, 45);
        [previewBtn setTitle:@"预览" forState:UIControlStateNormal];
        [previewBtn addTarget:self action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
        [previewBtn addSubview:self.makeView];
        self.previewBtn = previewBtn;
    }
    return _previewBtn;
}

- (void)setSelectPickerAssets:(NSArray *)selectPickerAssets{
    // 去掉重复的Piker
    NSSet *set = [NSSet setWithArray:selectPickerAssets];
    _selectPickerAssets = [set allObjects];
    
    for (MLSelectPhotoAssets *assets in selectPickerAssets) {
        if ([assets isKindOfClass:[MLSelectPhotoAssets class]]) {
            [self.selectAssets addObject:assets];
        }
    }

    self.collectionView.lastDataArray = nil;
    self.collectionView.isRecoderSelectPicker = YES;
    self.collectionView.selectAsstes = self.selectAssets;
    NSInteger count = self.selectAssets.count;
    self.makeView.hidden = !count;
    self.makeView.text = [NSString stringWithFormat:@"%ld",(long)count];
    self.doneBtn.enabled = (count > 0);
    self.previewBtn.enabled = (count > 0);
}

#pragma mark collectionView
- (MLSelectPhotoPickerCollectionView *)collectionView{
    if (!_collectionView) {
        
        CGFloat cellW = (self.view.frame.size.width - CELL_MARGIN * CELL_ROW + 1) / CELL_ROW;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellW, cellW);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = CELL_LINE_MARGIN;
        layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, TOOLBAR_HEIGHT * 2);
        
        MLSelectPhotoPickerCollectionView *collectionView = [[MLSelectPhotoPickerCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        // 时间置顶
        collectionView.status = ZLPickerCollectionViewShowOrderStatusTimeDesc;
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [collectionView registerClass:[MLSelectPhotoPickerCollectionViewCell class] forCellWithReuseIdentifier:_cellIdentifier];
        // 底部的View
        [collectionView registerClass:[MLSelectPhotoPickerFooterCollectionReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:_footerIdentifier];
        
        collectionView.contentInset = UIEdgeInsetsMake(5, 0,TOOLBAR_HEIGHT, 0);
        collectionView.collectionViewDelegate = self;
        [self.view insertSubview:collectionView belowSubview:self.toolBar];
        self.collectionView = collectionView;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(collectionView);
        
        NSString *widthVfl = @"H:|-0-[collectionView]-0-|";
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:widthVfl options:0 metrics:nil views:views]];
        
        NSString *heightVfl = @"V:|-0-[collectionView]-0-|";
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:heightVfl options:0 metrics:nil views:views]];
        
    }
    return _collectionView;
}

#pragma mark makeView 红点标记View
- (UILabel *)makeView{
    if (!_makeView) {
        UILabel *makeView = [[UILabel alloc] init];
        makeView.textColor = [UIColor whiteColor];
        makeView.textAlignment = NSTextAlignmentCenter;
        makeView.font = [UIFont systemFontOfSize:13];
        makeView.frame = CGRectMake(-5, -5, 20, 20);
        makeView.hidden = YES;
        makeView.layer.cornerRadius = makeView.frame.size.height / 2.0;
        makeView.clipsToBounds = YES;
        makeView.backgroundColor = [UIColor redColor];
        [self.view addSubview:makeView];
        self.makeView = makeView;
        
    }
    return _makeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.bounds = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:PICKER_REFRESH_DONE object:nil];
    
    // 初始化按钮
    [self setupButtons];
    
    // 初始化底部ToorBar
    [self setupToorBar];
}

- (void)refresh:(NSNotification *)noti{
    self.selectAssets = noti.userInfo[@"assets"];
    [self.collectionView.selectsIndexPath removeAllObjects];
    self.collectionView.selectAsstes = noti.userInfo[@"assets"];
    [self.collectionView reloadData];

    NSInteger count = 0;
    if (self.collectionView.selectAsstes.count < self.selectAssets.count) {
        count = self.collectionView.selectAsstes.count;
    }else{
        count = self.selectAssets.count;
    }

    self.makeView.hidden = !count;
    self.makeView.text = [NSString stringWithFormat:@"%ld",(long)count];
    self.doneBtn.enabled = (count > 0);
    self.previewBtn.enabled = (count > 0);
    
}

#pragma mark - setter
#pragma mark 初始化按钮
- (void) setupButtons{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

#pragma mark 初始化所有的组
- (void) setupAssets{
    __block NSMutableArray *assetsM = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    
    [[MLSelectPhotoPickerDatas defaultPicker] getGroupPhotosWithGroup:self.assetsGroup finished:^(NSArray *assets) {
        [assets enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL *stop) {
            MLSelectPhotoAssets *zlAsset = [[MLSelectPhotoAssets alloc] init];
            zlAsset.asset = asset;
            [assetsM addObject:zlAsset];
        }];

        weakSelf.collectionView.dataArray = assetsM;
    }];
    
}

#pragma mark -初始化底部ToorBar
- (void) setupToorBar{
    UIToolbar *toorBar = [[UIToolbar alloc] init];
    toorBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:toorBar];
    self.toolBar = toorBar;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(toorBar);
    NSString *widthVfl =  @"H:|-0-[toorBar]-0-|";
    NSString *heightVfl = @"V:[toorBar(44)]-0-|";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:widthVfl options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:heightVfl options:0 metrics:0 views:views]];
    
    // 左视图 中间距 右视图
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.previewBtn];
    UIBarButtonItem *fiexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.doneBtn];
    
    toorBar.items = @[leftItem,fiexItem,rightItem];
    
}

#pragma mark - setter
-(void)setMaxCount:(NSInteger)maxCount{
    _maxCount = maxCount;
    
    if (!_privateTempMaxCount) {
        _privateTempMaxCount = maxCount;
    }
    
    if (self.selectAssets.count == maxCount){
        maxCount = 0;
    }else if (self.selectPickerAssets.count - self.selectAssets.count > 0) {
        maxCount = _privateTempMaxCount;
    }
    
    self.collectionView.maxCount = maxCount;
}

- (void)setAssetsGroup:(MLSelectPhotoPickerGroup *)assetsGroup{
    if (!assetsGroup.groupName.length) return ;
    
    _assetsGroup = assetsGroup;
    
    self.title = assetsGroup.groupName;
    
    // 获取Assets
    [self setupAssets];
}

- (void)pickerCollectionViewDidCameraSelect:(MLSelectPhotoPickerCollectionView *)pickerCollectionView{
    
    if (self.selectAssets.count >= KPhotoShowMaxCount) {
        [self.view showMessageWithText:[NSString stringWithFormat:@"选择的图片个数不能大于%ld",KPhotoShowMaxCount]];
        return ;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *ctrl = [[UIImagePickerController alloc] init];
        ctrl.delegate = self;
        ctrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ctrl animated:YES completion:nil];
    }else{
        NSLog(@"请在真机使用!");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 处理
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        
        [self.selectAssets addObject:image];
        
        NSInteger count = self.selectAssets.count;
        self.makeView.hidden = !count;
        self.makeView.text = [NSString stringWithFormat:@"%ld",(long)count];
        self.previewBtn.enabled = (count > 0);
        self.doneBtn.enabled = (count > 0);
        
        // 刷新当前相册
        if (isCameraAutoSavePhoto) {
            if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                NSLog(@"MLSelectPhoto : 保存成功");
            }else{
                NSLog(@"MLSelectPhoto : 没有用户权限,保存失败");
            }
        }
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }else{
        NSLog(@"请在真机使用!");
    }
}

- (void)preview{
    MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
    [browserVc setValue:@(YES) forKeyPath:@"isEditing"];
    browserVc.photos = self.selectAssets;
    [self.navigationController pushViewController:browserVc animated:YES];
}

- (void)setTopShowPhotoPicker:(BOOL)topShowPhotoPicker{
    _topShowPhotoPicker = topShowPhotoPicker;
    
    if (topShowPhotoPicker) {
        NSMutableArray *reSortArray= [[NSMutableArray alloc] init];
        for (id obj in [self.collectionView.dataArray reverseObjectEnumerator]) {
            [reSortArray addObject:obj];
        }
        
        MLSelectPhotoAssets *mlAsset = [[MLSelectPhotoAssets alloc] init];
        [reSortArray insertObject:mlAsset atIndex:0];
        
        self.collectionView.status = ZLPickerCollectionViewShowOrderStatusTimeAsc;
        self.collectionView.topShowPhotoPicker = topShowPhotoPicker;
        self.collectionView.dataArray = reSortArray;
        [self.collectionView reloadData];
    }
}


- (void) pickerCollectionViewDidSelected:(MLSelectPhotoPickerCollectionView *) pickerCollectionView deleteAsset:(MLSelectPhotoAssets *)deleteAssets{
    
    [self.makeView.layer removeAllAnimations];
    CAKeyframeAnimation *scaoleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaoleAnimation.duration = 0.25;
    scaoleAnimation.autoreverses = YES;
    scaoleAnimation.values = @[[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.2],[NSNumber numberWithFloat:1.0]];
    scaoleAnimation.fillMode = kCAFillModeForwards;
    [self.makeView.layer addAnimation:scaoleAnimation forKey:@"transform.rotate"];
    
    if (self.selectPickerAssets.count == 0){
        self.selectAssets = [NSMutableArray arrayWithArray:pickerCollectionView.selectAsstes];
    }else if (deleteAssets == nil){
        [self.selectAssets addObject:[pickerCollectionView.selectAsstes lastObject]];
    }
    
    if (self.selectPickerAssets.count || deleteAssets) {
        MLSelectPhotoAssets *asset = [pickerCollectionView.lastDataArray lastObject];
        if (deleteAssets){
            asset = deleteAssets;
        }
        
        NSInteger selectAssetsCurrentPage = -1;
        for (NSInteger i = 0; i < self.selectAssets.count; i++) {
            MLSelectPhotoAssets *photoAsset = self.selectAssets[i];
            if([[[[asset.asset defaultRepresentation] url] absoluteString] isEqualToString:[[[photoAsset.asset defaultRepresentation] url] absoluteString]]){
                selectAssetsCurrentPage = i;
                break;
            }
        }
        
        if (
            (self.selectAssets.count > selectAssetsCurrentPage)
            &&
            (selectAssetsCurrentPage >= 0)
            ){
            if (deleteAssets){
                [self.selectAssets removeObjectAtIndex:selectAssetsCurrentPage];
            }
            [self.collectionView.selectsIndexPath removeObject:@(selectAssetsCurrentPage)];
            self.makeView.text = [NSString stringWithFormat:@"%ld",self.selectAssets.count];
        }
        // 刷新下最小的页数
        self.maxCount = self.selectAssets.count + (_privateTempMaxCount - self.selectAssets.count);
        
        self.makeView.hidden = !self.selectAssets.count;
        self.makeView.text = [NSString stringWithFormat:@"%ld",(long)self.selectAssets.count];
        self.doneBtn.enabled = (self.selectAssets.count > 0);
        self.previewBtn.enabled = (self.selectAssets.count > 0);
        
    }else{
        
        NSInteger count = 0;
        if (pickerCollectionView.selectAsstes.count < self.selectAssets.count) {
            count = pickerCollectionView.selectAsstes.count;
        }else{
            count = self.selectAssets.count;
        }
        
        self.makeView.hidden = !count;
        self.makeView.text = [NSString stringWithFormat:@"%ld",(long)count];
        self.doneBtn.enabled = (count > 0);
        self.previewBtn.enabled = (count > 0);
        
    }
}

#pragma mark -<Navigation Actions>
#pragma mark -开启异步通知
- (void) back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) done{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_TAKE_DONE object:nil userInfo:@{@"selectAssets":self.selectAssets}];
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc{
    // 赋值给上一个控制器
    self.groupVc.selectAsstes = self.selectAssets;
}

@end
