//
//  ImagePickerThirdDemoController.m
//  ImagePickDemo
//
//  Created by 倪望龙 on 2017/6/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ImagePickerThirdDemoController.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "ImageGridCollectionViewCell.h"
@interface ImagePickerThirdDemoController ()<TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,LxGridViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *imageCollection;
@property(nonatomic,strong)NSMutableArray *selectImages;
@property(nonatomic,strong)NSMutableArray *selectAssets;
@end

@implementation ImagePickerThirdDemoController
-(NSMutableArray *)selectImages{
    if(_selectImages == nil){
        _selectImages = [NSMutableArray new];
    }
    return _selectImages;
}

-(NSMutableArray *)selectAssets{
    if(_selectAssets == nil){
        _selectAssets = [NSMutableArray new];
    }
    return _selectAssets;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self IPSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)IPSetUpSubviews{
    LxGridViewFlowLayout *layout = [LxGridViewFlowLayout new];
    CGFloat margin = 4.0f;
    CGFloat itemW = (self.view.frame.size.width - 3 * margin - 12.0f * 2.0f) / 4.0f;
    layout.itemSize = CGSizeMake(itemW, itemW);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    _imageCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64.0f, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    _imageCollection.backgroundColor = [UIColor orangeColor];
    _imageCollection.alwaysBounceVertical = YES;
    _imageCollection.contentInset         = UIEdgeInsetsMake(10, 12, 10, 12);
    _imageCollection.dataSource = self;
    _imageCollection.delegate = self;
    _imageCollection.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_imageCollection registerClass:[ImageGridCollectionViewCell class] forCellWithReuseIdentifier:@"ImageGridCollectionViewCell"];
    [self.view addSubview:_imageCollection];
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _selectImages.count + 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageGridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageGridCollectionViewCell" forIndexPath:indexPath];
     cell.imageView.image = nil;
    if(indexPath.row < _selectImages.count){
      cell.imageView.image = _selectImages[indexPath.row];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < self.selectImages.count){//图片预览
        TZImagePickerController *imagePreview = [[TZImagePickerController alloc]initWithSelectedAssets:_selectAssets selectedPhotos:_selectImages index:indexPath.row];
        imagePreview.maxImagesCount = self.selectImages.count;
        [imagePreview setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL stop){
            [self.selectImages removeAllObjects];
            self.selectImages = [photos mutableCopy];
            [self.selectAssets removeAllObjects];
            self.selectAssets = [assets mutableCopy];
            [self.imageCollection reloadData];
        }];
        [self presentViewController:imagePreview animated:NO completion:nil];
       
    }else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:10.0 delegate:self];
        imagePickerVc.allowPickingOriginalPhoto = NO;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL stop){
            [self.selectImages removeAllObjects];
            self.selectImages = [photos mutableCopy];
            
            [self.selectAssets removeAllObjects];
            self.selectAssets = [assets mutableCopy];
            [self.imageCollection reloadData];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectImages.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectImages.count && destinationIndexPath.item < _selectImages.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectImages[sourceIndexPath.item];
    [_selectImages removeObjectAtIndex:sourceIndexPath.item];
    [_selectImages insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectAssets[sourceIndexPath.item];
    [_selectAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectAssets insertObject:asset atIndex:destinationIndexPath.item];
    [_imageCollection reloadData];
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
