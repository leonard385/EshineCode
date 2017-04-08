//
//  CSBaseFuncVc.m
//  ComplainSYS
//
//  Created by 逸信Mac on 16/6/6.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "CSBaseFuncVC.h"

//照片相关库
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
//设备权限
#import "YHUtil.h"
#import "NSDate+Helper.h"
//图片压缩调整
#import "UIImage+Resize.h"
#import "NSFileManager+Paths.h"

@interface CSBaseFuncVC() <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,assign)NSUInteger PohoNum;//图片数量
@end

@implementation CSBaseFuncVC

-(instancetype)init
{
    self = [super init];
    if(self){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

#pragma mark - 网络请求数据
-(NSMutableArray *)DateArray
{
    if(_DateArray == nil){
        _DateArray = [NSMutableArray new];
    }
    return _DateArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self BFDateInit];
    
}

-(void)BFDateInit
{
    _EmptyImage = [UIImage imageNamed:@"DeFaultEmpty"];
    _EmptyTitle = @"暂无数据";
    _EmptySubTitle = @"";
    _EmptyBgColor = HEXCOLOR(0xf3f3f3);
    
    _isLoading = YES;
}


#pragma mark - 设置空白页相关数据
-(void)setEmptyImage:(UIImage *)EmptyImage
          EmptyTitle:(NSString *)EmptyTitle
       EmptySubTitle:(NSString *)EmptySubTitle
        EmptyBgColor:(UIColor *)EmptyBgColor
        BFRefreshDataBlock:(BFRefreshData)BFRefreshDataBlock
{
    _EmptyImage = EmptyImage;
    _EmptyTitle = EmptyTitle;
    _EmptySubTitle = EmptySubTitle;
    _EmptyBgColor = EmptyBgColor;
    _BFRefreshDataBlock = BFRefreshDataBlock;
}


#pragma mark - 结束加载并设置空白页相关数据
-(void)CommpleteLoddingWithEmptyImage:(UIImage *)EmptyImage
          EmptyTitle:(NSString *)EmptyTitle
       EmptySubTitle:(NSString *)EmptySubTitle
        EmptyBgColor:(UIColor *)EmptyBgColor
{
    _EmptyImage = EmptyImage;
    _EmptyTitle = EmptyTitle;
    _EmptySubTitle = EmptySubTitle;
    _EmptyBgColor = EmptyBgColor;
    _isLoading = NO;
    [self.tableView reloadEmptyDataSet];
}




#pragma mark - 显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if(!_isLoading){
    NSString *text = _EmptyTitle;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName: HEXCOLOR(0x999999)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }else{
        return nil;
    }
}

-(NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if(!_isLoading){
        NSString *text = _EmptySubTitle;
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                     NSForegroundColorAttributeName: HEXCOLOR(0xcccccc)};
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }else{
        return nil;
    }
}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return _EmptyBgColor;
}

#pragma mark - 图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.isLoading) {
        return [UIImage imageNamed:@"loading_imgBlue_78x78"];
    }
    else {
        return _EmptyImage;
    }
}

#pragma mark - 动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.isLoading;
}


-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    _isLoading = YES;
    [self.tableView reloadEmptyDataSet];
    if(_BFRefreshDataBlock){//重新刷新数据
        self.BFRefreshDataBlock();
    }
}

-(void)setIsLoading:(bool)isLoading
{
    _isLoading = isLoading;
    [self.tableView reloadEmptyDataSet];
}

-(void)StartLoding
{
    _isLoading = YES;
    [self.tableView reloadEmptyDataSet];
    if(_BFRefreshDataBlock){//重新刷新数据
        self.BFRefreshDataBlock();
    }
}


#pragma mark --------照片相关库代理方法
#pragma mark - 打开相册第三方库
-(void)OpenPotoLibWithPhotoLimit:(NSUInteger)num
{
    if([YHUtil isAllowPhotoAlbum]){//监测权限
        // 创建控制器
        MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
        // 默认显示相册里面的内容SavePhotos
        pickerVc.status = PickerViewShowStatusCameraRoll;
        pickerVc.maxCount = num;
        [pickerVc showPickerVc:self];
        
        pickerVc.callBack = ^(NSArray *assets){
            NSMutableArray *imageArray = [NSMutableArray array];
            
            for(int i= 0; i< assets.count;i++){
                MLSelectPhotoAssets *asset = assets[i];
                [imageArray addObject:[MLSelectPhotoPickerViewController getImageWithImageObj:asset]];
                
            }
            
            if(_BFPhotosBlock){
                _BFPhotosBlock(imageArray);
            }
        };}else{
  
            [self showSystemAlert:@"请打开 设置-隐私-照片 来进行设置"];
        }
    
}

-(void)showSystemAlert:(NSString *)msg{
 
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}



-(void)OpenCamera
{
    WeakSelf();
    if([YHUtil isAllowCamera]){
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = weakself;
            //设置拍照后的图片可被编辑
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [weakself presentViewController:picker animated:YES completion:nil];
        }else
        {
            NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        }}else{
            [self showSystemAlert:@"请打开 设置-隐私-相机 来进行设置"];
        }

}


#pragma mark  - 照相机
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        NSArray *ImageArray = [NSArray arrayWithObject:image];
        if(_BFPhotosBlock){
            _BFPhotosBlock(ImageArray);
        }
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma  mark - 压缩图片
-(void)CompressImages:(NSArray *)ImageArray
               toSize:(CGSize)size
              Quality:(CGInterpolationQuality)QualityKind
          returnBlock:(void(^)(NSArray *CompressedImages,NSArray *datas))ImageReturnBlock
{
    __block NSMutableArray *CompressedArray = [NSMutableArray new];
    __block NSMutableArray *CompressData = [NSMutableArray new];
    [ImageArray enumerateObjectsUsingBlock:^(UIImage*  _Nonnull img, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *NewImage = [img resizedImage:size interpolationQuality:QualityKind];//调整尺寸
        
        NSData* Imagedata = [NSData new];
        if (UIImagePNGRepresentation(NewImage) == nil)
        {
            Imagedata = UIImageJPEGRepresentation(NewImage, 0.2);
        }
        else
        {
            Imagedata = UIImagePNGRepresentation(NewImage);
        }
        [CompressData addObject:Imagedata];
        UIImage *compressedImage = [UIImage imageWithData:Imagedata];
        [CompressedArray addObject:compressedImage];

    }];
    if((CompressedArray.count != 0)&&(ImageReturnBlock)){//返回处理后的数据
        ImageReturnBlock(CompressedArray,CompressData);
    }
}

#pragma mark - 以ID的方式读取图片数据
-(void)ReadImagesWithOrderID:(NSString *)OrderID
                 returnBlock:(void(^)(NSArray*Array))ImageReturnBlock
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@imagePath.plist",kUserPath,OrderID];
    NSArray *ImageArray = [NSArray arrayWithContentsOfFile:filePath];
    
    __block NSMutableArray *Array = [NSMutableArray new];
    [ImageArray enumerateObjectsUsingBlock:^(NSString*  _Nonnull FilePath, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *imge = [UIImage imageWithContentsOfFile:filePath];
        [Array addObject:imge];
    }];
    
    if(ImageReturnBlock){
        ImageReturnBlock(Array);
    }
}

#pragma mark - 以ID的方式保存图片数据
-(void)SaveFilesToUserDocument:(NSArray*)FileArray
                   WithOrderID:(NSString *)OrderID
{
    //文件管理器
   __block NSFileManager *fileManager = [NSFileManager defaultManager];
    __block NSMutableArray *PathArray = [NSMutableArray new];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@imagePath.plist",kUserPath,OrderID];
    //添加文件夹
    [fileManager createDirectoryAtPath:kUserPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    [FileArray enumerateObjectsUsingBlock:^(NSData* _Nonnull data, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{//子线程
            
            NSString *fileName = [NSString stringWithFormat:@"/_image%lu.png",[[NSDate date]utcTimeStamp]];
            
            [fileManager createFileAtPath:[kUserPath stringByAppendingString:fileName] contents:data attributes:nil];
            [PathArray addObject:fileName];
             [PathArray writeToFile:filePath atomically:YES];
        });
    }];
    
    
   
    
    
}


//打开选择列表
-(void)openMenuWithPohoNumLimit:(NSUInteger)Num Photos:(BFPhotos)PhotosBlock{
    
    _BFPhotosBlock = PhotosBlock;
    _PohoNum = Num;
    //在这里呼出下方菜单按钮项
    UIActionSheet *PicActionSheet = [[UIActionSheet alloc]
                                     initWithTitle:nil
                                     delegate:self
                                     cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:nil
                                     otherButtonTitles:@"打开照相机",@"从手机相册获取", nil];
    [PicActionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == actionSheet.cancelButtonIndex){
        NSLog(@"取消");
    }
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
        {
            [self OpenPotoLibWithPhotoLimit:_PohoNum];
        }
            
            break;
        default:
            break;
    }
}

#pragma mark - 打开相册
-(void)takePhoto{
    [self OpenCamera];
}

#pragma mark - 显示图片
////点击第几张图片
//- (void)imageClickWithPage:(NSInteger)index
//{
//    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
//    photoBrowser.delegate = self;
//    photoBrowser.currentImageIndex = index;
//    photoBrowser.imageCount = self.photosArray.count;
//    photoBrowser.sourceImagesContainerView = self.collectionView;
//    [photoBrowser show];
//}
//
////返回临时占位图片（即原来的小图）
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    return self.photosArray[index];
//}

#pragma mark - 时间
-(void)GetTimePickViewWithTimeFormatType:(DPFormatType)FormatType Finnish:(void(^)(NSString *datestr ,NSDate *date))TimeDateBlock
{
    HZQDatePickerView *TimePicView = [HZQDatePickerView instanceDatePickerView];
    TimePicView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight + 20);
    [TimePicView setBackgroundColor:[UIColor clearColor]];
    TimePicView.type = DateTypeOfStart;
    [TimePicView setDateFormat:FormatType];
    
    NSDate *currentDate = [NSDate date];
    [TimePicView.datePickerView setDate:currentDate];
    [self.view addSubview:TimePicView];
    
    
    [TimePicView setGetSelectDateAndTypeBlock:^(NSDate *date,NSString *dateStr, DateType type) {
        NSString *DealdateStr = [date string];
        TimeDateBlock(DealdateStr,date);
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
