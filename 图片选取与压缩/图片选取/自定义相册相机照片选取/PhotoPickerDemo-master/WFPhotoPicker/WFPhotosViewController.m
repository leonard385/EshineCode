//
//  WFPhotosViewController.m
//  WFPhotoPicker
//
//  Created by 赚发2 on 16/9/2.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import "WFPhotosViewController.h"
#import "WFCollectionViewCell.h"
#import "WFTailoringViewController.h"
#import "WFPhotoAlbum.h"
#import "PopView.h"
#import <Photos/Photos.h>
#import "WFCacheModel.h"

static NSString *const indentifier = @"CELL";

@interface WFPhotosViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

//资源的集合
@property (nonatomic, strong) NSMutableArray *photos;


@end

@implementation WFPhotosViewController

#pragma mark - UIViewController life cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"相片";
    [self private_confguireCollectionView];
    
    [[WFPhotoAlbum standarWFPhotosAlbum] getCameraSuccess:^(WFCacheModel *model) {
         self.photos = [model.models copy];
         [_collectionView reloadData];
    }];
    
}

#pragma mark - event reponse -
- (void)returnPage{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private methods -
- (void)private_confguireCollectionView{
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(0, 0, 40, 40);
    [returnButton addTarget:self action:@selector(returnPage) forControlEvents:UIControlEventTouchUpInside];
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    [returnButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:returnButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 4;
    flowLayout.minimumInteritemSpacing = 4;
    CGFloat width = (self.view.frame.size.width - 12) / 4;
    flowLayout.itemSize = CGSizeMake(width, width);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[WFCollectionViewCell class] forCellWithReuseIdentifier:indentifier];
}


//裁剪图片,此处裁剪为125*125大的图,即为我们的缩略图
- (UIImage *)wf_thumbnailsCutfullPhoto:(UIImage*)fullPhoto
{
    CGSize newSize;
    CGImageRef imageRef = nil;
    if ((fullPhoto.size.width / fullPhoto.size.height) < 1) {
        newSize.width = fullPhoto.size.width;
        newSize.height = fullPhoto.size.width * 1;
        imageRef = CGImageCreateWithImageInRect([fullPhoto CGImage], CGRectMake(0, fabs(fullPhoto.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = fullPhoto.size.height;
        newSize.width = fullPhoto.size.height * 1;
        imageRef = CGImageCreateWithImageInRect([fullPhoto CGImage], CGRectMake(fabs(fullPhoto.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

#pragma mark - UICollectionViewDelegate -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];

    cell.assignment(self.photos[indexPath.item]);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WFTailoringViewController *tailoringVC = [[WFTailoringViewController alloc] init];
    WFAlumbModel *model = self.photos[indexPath.item];
    tailoringVC.asset = model.asset;
    tailoringVC.tailoredImage = ^ (UIImage *image){
        _tailoredImage ? _tailoredImage(image) : nil;
    };
    [self.navigationController pushViewController:tailoringVC animated:YES];
}

#pragma mark - setters and getters -

- (NSMutableArray *)photos{
    if (_photos == nil) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
