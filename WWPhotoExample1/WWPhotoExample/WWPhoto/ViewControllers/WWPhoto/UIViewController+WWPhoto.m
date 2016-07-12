//
//  UIViewController+WWPhoto.m
//  WWPhotoExample
//
//  Created by eshine on 16/7/12.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "UIViewController+WWPhoto.h"
//照片相关库
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "BSECustomTool.h"

#import "YHUtil.h"
#import "NSDate+Helper.h"
#import "UIImage+Resize.h"
#import "objc/runtime.h"
#import "WWPhotoModel.h"

static  char blockKey1;
static  char blockKey2;
static  char blockKey3;

static  char photpKey1;
static  char photpKey2;
static  char photpKey3;
static  char photpKey4;


#define WeakSelf() __weak typeof(self) weakself= self

@interface UIViewController () <UIActionSheetDelegate>

@property(nonatomic,copy)OpenPhotoBlock openPhoto;
@property(nonatomic,copy)OpenCamreBlock openCamre;

@end

@implementation UIViewController (WWPhoto)

#pragma mark-set
-(void)setPhotoBlock:(photoBlock)photoBlock
{
    self.photosArray = [NSMutableArray new];
    self.SelectedPhotos = [NSMutableArray new];
    self.ImgFilePaths = [NSMutableArray new];
    
    objc_setAssociatedObject(self, &blockKey1, photoBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setOpenPhoto:(OpenPhotoBlock)openPhoto
{
    objc_setAssociatedObject(self, &blockKey2, openPhoto, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setOpenCamre:(OpenCamreBlock)openCamre
{
    objc_setAssociatedObject(self, &blockKey3, openCamre, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPhotosArray:(NSMutableArray *)photosArray
{
    objc_setAssociatedObject(self, &photpKey1, photosArray, OBJC_ASSOCIATION_RETAIN);
}

- (void)setImgFilePaths:(NSMutableArray *)ImgFilePaths
{
    objc_setAssociatedObject(self, &photpKey2, ImgFilePaths, OBJC_ASSOCIATION_RETAIN);
}

- (void)setSelectedPhotos:(NSMutableArray *)SelectedPhotos
{
    objc_setAssociatedObject(self, &photpKey3, SelectedPhotos, OBJC_ASSOCIATION_RETAIN);
}

- (void)setDocumentsPath:(NSString *)DocumentsPath
{
    objc_setAssociatedObject(self, &photpKey4, DocumentsPath, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark-get
- (photoBlock )photoBlock
{
    return objc_getAssociatedObject(self, &blockKey1);
}

- (OpenPhotoBlock )openPhoto
{
    return objc_getAssociatedObject(self, &blockKey2);
}

- (OpenCamreBlock )openCamre
{
    return objc_getAssociatedObject(self, &blockKey3);
}

- (NSMutableArray*)photosArray
{
    return objc_getAssociatedObject(self, &photpKey1);
}

- (NSMutableArray*)SelectedPhotos
{
    return objc_getAssociatedObject(self, &photpKey2);
}

- (NSMutableArray*)ImgFilePaths
{
    return objc_getAssociatedObject(self, &photpKey3);
}

- (NSString*)DocumentsPath
{
    return objc_getAssociatedObject(self, &photpKey4);
}

#pragma mark --------照片相关库代理方法
#pragma mark - 打开相册第三方库
-(void)MMSOPenPotoLib
{
    if([YHUtil isAllowPhotoAlbum]){//监测权限
        // 创建控制器
        MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
        // 默认显示相册里面的内容SavePhotos
        pickerVc.status = PickerViewShowStatusCameraRoll;
        pickerVc.maxCount = 30;
        [pickerVc showPickerVc:self];
        
        pickerVc.callBack = ^(NSArray *assets){
            NSMutableArray *imageArray = [NSMutableArray array];
            
            for(int i= 0; i< assets.count;i++){
                MLSelectPhotoAssets *asset = assets[i];
                [imageArray addObject:[MLSelectPhotoPickerViewController getImageWithImageObj:asset]];
                
            }
            //保存到沙盒
            [imageArray enumerateObjectsUsingBlock:^(UIImage*  _Nonnull Img, NSUInteger idx, BOOL * _Nonnull stop) {
                [self SavePicToDocuments:Img];
            }];
        };}else{
            [BSECustomTool alertMessage:@"请打开 设置-隐私-照片 来进行设置"];
        }
    
}


-(void)OpenCamera
{
    if([YHUtil isAllowCamera]){
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            //设置拍照后的图片可被编辑
            //picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];
        }else
        {
            NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        }}else{
            [BSECustomTool alertMessage:@"请打开 设置-隐私-相机 来进行设置"];
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
        //相片保存
        [self SavePicToDocuments:image];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void)showCanEdit:(BOOL)edit photo:(photoBlock)block
{
    
}

#pragma  mark - 图片存沙盒目录
//图片存沙盒目录
-(void)SavePicToDocuments:(UIImage*)image
{
    UIImage *NewImage = [image resizedImage:CGSizeMake(96*3, 136*3) interpolationQuality:kCGInterpolationDefault];
    [self.photosArray addObject:image];
    [[WWPhotoModel shareMannager] addImage:image];
    //异步执行 压缩保存
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data;
        //图片压缩
        if (UIImagePNGRepresentation(NewImage) == nil)
        {
            data = UIImageJPEGRepresentation(NewImage, 0.2);
        }
        else
        {
            data = UIImagePNGRepresentation(NewImage);
        }
        
        //添加
        UIImage *imagetemp = [UIImage imageWithData:data];
        [self.SelectedPhotos addObject:imagetemp];
        [[WWPhotoModel shareMannager] addSelectImage:imagetemp];

        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSString *fileName = [NSString stringWithFormat:@"/_image%lu.png",[[NSDate date]utcTimeStamp]];
        
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:fileName] contents:data attributes:nil];
        
        //保存图片名称并把数组写入plist文件
        [self.ImgFilePaths addObject:fileName];
        [[WWPhotoModel shareMannager] addImageFilePath:fileName];

        NSString *filePath = [NSString stringWithFormat:@"%@/_imageFilePath.plist",DocumentsPath];
        [self.ImgFilePaths writeToFile:filePath atomically:YES];
        
        if(self.photoBlock)
        {
            self.photoBlock(image);
        }
        
    });
}

//打开相机和相册的block代理方法
-(void)setOpenCamreBlock:(OpenCamreBlock)openCamre OpenPhotoBlock:(OpenPhotoBlock)openPhoto
{
    self.openPhoto = [openPhoto copy];
    self.openCamre = [openCamre copy];
    [self openMenu];
}

//打开选择列表
-(void)openMenu{
    if((self.openCamre)&&(self.openPhoto == nil)){//只有拍照
        [self takePhoto];
    }else{
        //在这里呼出下方菜单按钮项
        UIActionSheet *PicActionSheet = [[UIActionSheet alloc]
                                         initWithTitle:nil
                                         delegate:self
                                         cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                         otherButtonTitles:@"打开照相机",@"从手机相册获取", nil];
        [PicActionSheet showInView:self.view];
    }
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
            self.openPhoto((NSInteger)30);
        }
            
            break;
        default:
            break;
    }
}

-(void)takePhoto{
    if(self.openCamre){
        self.openCamre();}
}

@end
