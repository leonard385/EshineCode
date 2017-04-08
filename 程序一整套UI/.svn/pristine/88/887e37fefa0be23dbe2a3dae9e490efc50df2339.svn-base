//
//  MMSImageShowView.m
//  MMS
//
//  Created by 逸信Mac on 16/7/28.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "MMSImageShowView.h"
#import "SDPhotoBrowser.h"
#import "MMSImageUploadModel.h"
#import "MMSProgressView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@class MMSImageCell;
typedef void(^ISBtnSeePhotoClick)();
typedef void(^ISBtnDeleteClick)();

typedef void(^ISUploadSuccess)(NSNumber *ImageID);
typedef void(^ISUploadFailure)();
typedef void(^ISDownLoadSuccess)(UIImage *image);


#pragma mark - CollecttionViewCell
@interface MMSImageCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView* PhotoView;
@property(nonatomic,strong)UIButton *DelButton;
@property(nonatomic,strong)UILabel *LableProgress;
@property(nonatomic,strong)MMSProgressView *progressView;

@property(nonatomic,strong)MMSImageUploadModel *CellModel;

@property(nonatomic,copy)ISBtnSeePhotoClick ISBtnSeePhotoClickBlock;
@property(nonatomic,copy)ISBtnDeleteClick ISBtnDeleteClickBlock;

@property(nonatomic,copy)ISUploadSuccess ISUploadSuccessBlock;
@property(nonatomic,copy)ISUploadFailure ISUploadFailureBlock;
@property(nonatomic,copy)ISDownLoadSuccess ISDownLoadSuccessBlock;

-(void)setISBtnSeePhotoClickBlock:(ISBtnSeePhotoClick)ISBtnSeePhotoClickBlock;
-(void)setISBtnDeleteClickBlock:(ISBtnDeleteClick)ISBtnDeleteClickBlock;

-(void)setISUploadSuccessBlock:(ISUploadSuccess)ISUploadSuccessBlock;
-(void)setISUploadFailureBlock:(ISUploadFailure)ISUploadFailureBlock;


-(void)setISUploadSuccessBlock:(ISUploadSuccess)ISUploadSuccessBlock FailureBlock:(ISUploadFailure)ISUploadFailureBlock;

-(void)setISDownLoadSuccessBlock:(ISDownLoadSuccess)ISDownLoadSuccessBlock;

-(void)SetImage:(UIImage *)Image;
@end

@implementation MMSImageCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      [self ISSetUpSubViews];
    }
    return self;
}

-(instancetype)init
{
    if(self = [super init]){
        [self ISSetUpSubViews];
    }
    return self;
}

-(void)ISSetUpSubViews
{
    __weak typeof(self) weakself = self;
    _PhotoView = [[UIImageView alloc]init];
    [_PhotoView setContentMode:UIViewContentModeScaleToFill];
    _PhotoView.layer.cornerRadius = 4.0f;
    _PhotoView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageClick)];
    [_PhotoView addGestureRecognizer:tap];
    [self.contentView addSubview:_PhotoView];
    
    UIButton *DelButton = [[UIButton alloc]init];
    [DelButton setBackgroundImage:[UIImage imageNamed:ISPhotoSrcName(@"deletePhoto.png")] forState:UIControlStateNormal];
    [DelButton addTarget:self
                  action:@selector(deletePhotoItem)
        forControlEvents:UIControlEventTouchUpInside];
    [DelButton setBackgroundColor:HEXCOLOR(0xcccccc) forState:UIControlStateNormal];
    [DelButton setBackgroundColor:HEXCOLOR(0xff3333) forState:UIControlStateNormal];
    _DelButton = DelButton;
    [self.contentView addSubview:_DelButton];
    
    //进度条
    _progressView = [MMSProgressView new];
    
    [_progressView setRetryClickBlock:^{
        [weakself CommitReportImage:weakself.CellModel.Photo];
    }];
    [self.contentView addSubview:_progressView];
    
    [_PhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self);
    }];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(_PhotoView);
    }];
    
    [_DelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.PhotoView);
        make.right.mas_equalTo(self.PhotoView);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    
}

-(void)setCellModel:(MMSImageUploadModel *)CellModel
{
    _CellModel = CellModel;
    if([_CellModel.isCommit boolValue] == NO){//上传状态
        [self CommitReportImage:_CellModel.Photo];
    }
    if(NotNilAndNull(CellModel.Photo)){
        _PhotoView.image = CellModel.Photo;
    }
    
    if(NotNilAndNull(CellModel.PhotoUrl)){
        [_PhotoView sd_setImageWithURL:[NSURL URLWithString:CellModel.PhotoUrl] placeholderImage:[UIImage imageNamed:@"PlaceHoldImage"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _ISDownLoadSuccessBlock?_ISDownLoadSuccessBlock(image):nil;
        }];
    }
}


-(void)setISUploadSuccessBlock:(ISUploadSuccess)ISUploadSuccessBlock FailureBlock:(ISUploadFailure)ISUploadFailureBlock
{
    _ISUploadSuccessBlock = ISUploadSuccessBlock;
    _ISUploadFailureBlock = ISUploadFailureBlock;
}


#pragma mark - 上传当前图片数据
-(void)CommitReportImage:(UIImage*)Image
{
//    //参数上传
//    __block NSMutableArray* dataArray = [[NSMutableArray alloc]init];
//        
//        MMSFormData* Date =[[MMSFormData alloc]init];
//        NSData *imageData =  UIImagePNGRepresentation(Image);
//        Date.data = imageData;
//        Date.mimeType = @"application/octet-stream";
//        NSString *FileName = @"pictureFile";
//        Date.name = FileName;
//        Date.filename = FileName;
//        [dataArray addObject:Date];
//        
//        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
//        paras[@"body"] = @(2);
//        paras[@"foreignId"] = @(-1);
//        paras[@"versionName"] = @"app";
//        
//        [BSEHttpTool postImageWithURL:kUploadImage
//                               params:paras
//                             formData:Date
//                              success:^(id json) {
//                                  NSDictionary *JsonDic = json;
//                                  if(NotNilAndNull(JsonDic)){
//                                      NSNumber *codeNum = JsonDic[@"code"];
//                                      if(NotNilAndNull(codeNum) && [codeNum longValue] == 200){//提交成功
//                                          self.progressView.hidden = YES;
//                                          NSNumber *ImageID = JsonDic[@"result"][@"id"];
//                                          _ISUploadSuccessBlock?_ISUploadSuccessBlock(ImageID):nil;
//                                      }else{//上传失败
//                                          _ISUploadFailureBlock?_ISUploadFailureBlock():nil;
//                                          [_progressView setUploadFailed];
//                                          NSString *msgStr = JsonDic[@"msg"];
//                                          [SVProgressHUD showErrorWithStatus:msgStr];
//                                      }
//                                  }
//                              } progress:^(long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//                                  _progressView.hidden = NO;
//                                  double progress = ((double)totalBytesWritten/(double)totalBytesExpectedToWrite);
//                                  if(progress == 1.0){
//                                    [_progressView setProgress:0.99];
//                                  }else{
//                                    [_progressView setProgress:progress];
//                                  }
//                                 
//                              } failure:^(NSError *error) {
//                                   _ISUploadFailureBlock?_ISUploadFailureBlock():nil;
//                                   [SVProgressHUD showErrorWithStatus:@"连接超时"];
//                                  [_progressView setUploadFailed];
//                              }];
}

#pragma mark - 照片点击
-(void)ImageClick
{
    if(_ISBtnSeePhotoClickBlock){
        _ISBtnSeePhotoClickBlock();
    }
}

#pragma mark - 删除按钮点击
-(void)deletePhotoItem
{
    if(_ISBtnDeleteClickBlock){
        _ISBtnDeleteClickBlock();
    }
}


-(void)SetImage:(UIImage *)Image
{
    _PhotoView.image = Image;
}

@end


#pragma mark - CollecttionViewCell2
typedef void(^BtnChooseClick)();
@interface MMSOpenCarmeCell : UICollectionViewCell
@property(nonatomic,strong)UIButton *AddButton;
@property(nonatomic,copy)BtnChooseClick BtnChooseClickBlock;

-(void)setBtnChooseClickBlock:(BtnChooseClick)BtnChooseClickBlock;
@end

@implementation MMSOpenCarmeCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self ISSetUpSubViews];
    }
    return self;
}
-(void)ISSetUpSubViews
{
    _AddButton = [[UIButton alloc]init];
    [_AddButton setBackgroundImage:[UIImage imageNamed:ISPhotoSrcName(@"addPhoto.png")] forState:UIControlStateNormal];
    [_AddButton addTarget:self
                  action:@selector(AddPhotoItem)
        forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_AddButton];
    
    [_AddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
}

#pragma mark - 删除按钮点击
-(void)AddPhotoItem
{
    if(_BtnChooseClickBlock){
        _BtnChooseClickBlock();
    }
}
@end



#import "MMSImageUploadModel.h"
@interface MMSImageShowView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>


/**布局*/
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;


@end

@implementation MMSImageShowView


-(NSMutableArray *)UploadArrays
{
    if(_UploadArrays == nil){
        _UploadArrays = [[NSMutableArray alloc]init];
    }
    return _UploadArrays;
}

//-(NSMutableArray *)Photos
//{
//    if(_Photos == nil){
//        _Photos = [[NSMutableArray alloc]init];
//    }
//    return _Photos;
//}

-(instancetype)init
{
    self = [super init];
    if(self){
        [self ISSetUpSubViews];
        [self ISKVOInit];
    }
    return self;
}

-(void)dealloc
{
    [self.ImageCollectionView removeObserver:self forKeyPath:@"contentSize"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _ImageCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)ISKVOInit
{
    [self.ImageCollectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

-(void)ISSetUpSubViews
{
    WeakSelf();
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    [layOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    _layout.itemSize = CGSizeMake(60, 60);
    _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _layout = layOut;
    
    _ImageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) collectionViewLayout:_layout];
    _ImageCollectionView.backgroundColor = [UIColor whiteColor];
    
    _ImageCollectionView.delegate = self;
    _ImageCollectionView.dataSource = self;
    [_ImageCollectionView  setShowsVerticalScrollIndicator:NO];
    [_ImageCollectionView setShowsHorizontalScrollIndicator:YES];
    _ImageCollectionView.collectionViewLayout = _layout;
    
    [_ImageCollectionView
                      registerClass:[MMSImageCell class]
                      forCellWithReuseIdentifier:@"MMSImageCell"];
    
    [_ImageCollectionView registerClass:[MMSOpenCarmeCell class]
             forCellWithReuseIdentifier:@"MMSOpenCarmeCell"];
    
    [self addSubview:_ImageCollectionView];
}

#pragma mark 代理方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf();
    
    if(indexPath.row < _UploadArrays.count){
    MMSImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MMSImageCell" forIndexPath:indexPath];
        MMSImageUploadModel *model = _UploadArrays[indexPath.row];
        
        [cell setCellModel:model];
        
        [cell setISUploadSuccessBlock:^(NSNumber *ImageID) {
            model.isCommit = @(YES);
            model.ImageID = ImageID;
        } FailureBlock:^{
            model.isCommit = @(NO);
        }];
        [cell setISDownLoadSuccessBlock:^(UIImage *image) {
            model.Photo = image;
        }];
        
        [cell setISBtnDeleteClickBlock:^{//删除按钮点击
            [weakself.UploadArrays removeObjectAtIndex:indexPath.row];
            [weakself.ImageCollectionView reloadData];
            if (_DeletePhotoAtIndexBlock) {
                _DeletePhotoAtIndexBlock(indexPath.row);
            }
        }];
        [cell setISBtnSeePhotoClickBlock:^{//查看照片
            MMSImageUploadModel *Model = weakself.UploadArrays[indexPath.row];
            UIImage *image = Model.Photo;
            if(_ISPreViewPhotoBlock){
                _ISPreViewPhotoBlock(image);
            }
        }];
        return cell;
    }else{
        MMSOpenCarmeCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MMSOpenCarmeCell" forIndexPath:indexPath];
        [cell setBtnChooseClickBlock:^{//点击添加
            if(_ISOpenPhotoLibBlock){
                _ISOpenPhotoLibBlock();
            }
        }];
        return cell;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.UploadArrays.count < _PhotoLimitCount){
        return self.UploadArrays.count + 1;
    }else{
        return self.UploadArrays.count;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //图片点击
    if(indexPath.row < self.UploadArrays.count){
       [self ImageClickWithPage:indexPath.row];
        if(_ISPreViewPhotoSDBrowserBlock){
            _ISPreViewPhotoSDBrowserBlock(self.ImageCollectionView,indexPath.row);
        }
    }
}


#pragma mark - 检查任务上传状态
-(bool)IsAllTasksCommitComplete
{
    for (MMSImageUploadModel *model in _UploadArrays) {
        if([model.isCommit boolValue] == 0){
            return NO;
        }
    }
    return YES;
}


-(void)addPhoto:(UIImage *)image
{
    MMSImageUploadModel *model = [MMSImageUploadModel new];
    model.Photo = image;
    [self.UploadArrays addObject:model];
    [_ImageCollectionView reloadData];
}

-(void)setReportPhotos:(NSArray *)ReportPhotos
{
    _ReportPhotos = ReportPhotos;
    _UploadArrays = [ReportPhotos mutableCopy];
    [_ImageCollectionView reloadData];
}


-(void)addPhotosFromArray:(NSArray *)imageArray
{
    [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MMSImageUploadModel *model = [MMSImageUploadModel new];
        model.Photo = obj;
        [self.UploadArrays addObject:model];
    }];
    [_ImageCollectionView reloadData];
}

-(void)DelectAllPhotos
{
    [_UploadArrays removeAllObjects];
    [_ImageCollectionView reloadData];
}

-(void)DelectPhotosAtIndex:(NSInteger)index
{
    [_UploadArrays removeObjectAtIndex:index];
    [_ImageCollectionView reloadData];
}

-(NSString *)PhotoIDS
{
    __block NSMutableString *PhotoIDS = [NSMutableString new];
    [_UploadArrays enumerateObjectsUsingBlock:^(MMSImageUploadModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx == 0){
            [PhotoIDS appendString:[obj.ImageID stringValue]];
        }else{
            [PhotoIDS appendString:[NSString stringWithFormat:@",%@",[obj.ImageID stringValue]]];
        }
    }];
    return PhotoIDS;
}

//图片点击显示
- (void)ImageClickWithPage:(NSInteger)index
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = index;
    photoBrowser.imageCount = self.UploadArrays.count;
    photoBrowser.sourceImagesContainerView = self.ImageCollectionView;
    [photoBrowser show];
}


// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    MMSImageUploadModel *model = self.UploadArrays[index];
    return model.Photo;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if([keyPath isEqualToString:@"contentSize"]){
        CGFloat Height = self.ImageCollectionView.contentSize.height;
        _ISViewHightChangeBlock?_ISViewHightChangeBlock(Height):nil;
    }
    
}


@end
