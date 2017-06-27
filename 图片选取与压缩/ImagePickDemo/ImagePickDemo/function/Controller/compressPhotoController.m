//
//  compressPhotoController.m
//  ImagePickDemo
//
//  Created by 倪望龙 on 2017/6/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "compressPhotoController.h"
#import "UIImage+compress.h"
#import "MWPhotoBrowser.h"

@interface compressPhotoController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,MWPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *orginImageView;
@property (weak, nonatomic) IBOutlet UIImageView *compressImage;
@property (weak, nonatomic) IBOutlet UILabel *lableTip;

@property(nonatomic,strong)NSMutableArray *photos;//图片
@end

@implementation compressPhotoController

-(NSMutableArray *)photos{
    if(_photos == nil){
        _photos = [NSMutableArray new];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CPSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)CPSetUpSubviews{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(previewClick)];
    self.orginImageView.userInteractionEnabled = YES;
    [self.orginImageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(previewClick)];
    self.compressImage.userInteractionEnabled = YES;
    [self.compressImage addGestureRecognizer:tap2];
}

#pragma mark - 摄像头点击
- (IBAction)btnCameraClick:(id)sender {
    [self openCamera];
}

#pragma mark - 打开相机
-(void)openCamera{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        NSLog(@"没有摄像头设备");
    }
}

#pragma mark  - step点击
- (IBAction)compressStepChange:(UIStepper *)sender {
    double value = sender.value;
    self.lableTip.text = [NSString stringWithFormat:@"%.1f",value];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"editingInfo: %@",editingInfo);
    NSLog(@"image: %@",image);
    self.orginImageView.image = image;
    NSData *originData = UIImageJPEGRepresentation(image, 1.0f);
    NSLog(@"%@",[NSString stringWithFormat:@"原数据大小:%.4f MB",((double)originData.length/1024.0f/1024.0f)]);
    NSLog(@"原数据尺寸: width:%f height:%f",image.size.width,image.size.height);
    
    //图片压缩
    UIImage *compressImage = [UIImage compressImage:image toByte:(NSUInteger)1024 * (NSUInteger)1024 * 0.5];
    NSLog(@"压缩数据尺寸: width:%f height:%f",compressImage.size.width,image.size.height);
    NSData *compressData = UIImageJPEGRepresentation(compressImage, 1.0f);
    NSLog(@"压缩数据大小:%.4f MB",(double)compressData.length/1024.0f/1024.0f);
    self.compressImage.image = compressImage;
    
    MWPhoto *photo1 = [MWPhoto photoWithImage:image];
    MWPhoto *photo2 = [MWPhoto photoWithImage:compressImage];
    self.photos = @[photo1,photo2].mutableCopy;
}


-(void)previewClick{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [browser setCurrentPhotoIndex:1];
    // Present
    [self.navigationController pushViewController:browser animated:YES];
}
#pragma mark- 取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
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
