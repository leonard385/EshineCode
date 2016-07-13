## 使用方法
* 导入UIViewController+XHPhoto.h 头文件,在控制器中调用

	### 调用相机相册代理方法
	
	[self setOpenCamreBlock:^{

        [weakself OpenCamera]; 
  
    } OpenPhotoBlock:^(NSUInteger PhotoNum) {
        
        [weakself MMSOPenPotoLib];

    }];
    
    ### 返回当前选择的图片代理方法
    
    self.photoBlock = ^(UIImage *image){
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.imageView.image = image;
        });
    };
    
    > 如果是想选择多张图片返回的，里面有一个属性数组photoArray存放着已选择的图片
    
##  安装

*   1.将 WWPhoto 文件夹添加到工程目录中
*   2.导入 UIViewController+WWPhoto.h

	> 具体请查看viewController的Demo
	
## 说明
* 该库可以进行相机和相册操作，并对选择的照片进行了本地存取

* 该库使用了几种第三方库  若已经引导可以不用重复导入
* 因水平有限，类别里面的属性只能保存当前选择的照片，故弄了一个WWPhotoModel来保存每次选择的图片

