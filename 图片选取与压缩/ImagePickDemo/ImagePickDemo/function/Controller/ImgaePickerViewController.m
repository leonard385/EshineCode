//
//  ImgaePickerViewController.m
//  ImagePickDemo
//
//  Created by 倪望龙 on 2017/6/26.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ImgaePickerViewController.h"
typedef enum : NSUInteger {
    kindA,
    kindB,
} kindType;
@interface ImgaePickerViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property(nonatomic,assign)kindType Type;
@end

@implementation ImgaePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self IPSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)IPSetUpSubviews{
    _ImageView.contentMode         = UIViewContentModeScaleAspectFill;
    _ImageView.layer.borderWidth   = 1.0f;
    _ImageView.layer.borderColor   = [UIColor blackColor].CGColor;
    _ImageView.layer.cornerRadius  = 5.0f;
    _ImageView.layer.masksToBounds = YES;
    

}

/**
 *  选择按钮点击
 *
 *  @param sender 按钮
 */
- (IBAction)btnSelectClick:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择" message:@" " preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoLib];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];

}

#pragma mark - 打开相机
-(void)openCamera{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //      imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        NSLog(@"没有摄像头设备");
    }
}

#pragma mark - 打开相册
-(void)openPhotoLib{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.sourceType    = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        NSLog(@"没有相册权限");
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"editingInfo: %@",editingInfo);
    NSLog(@"image: %@",image);
    self.ImageView.image = image;
}

#pragma mark- 取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
