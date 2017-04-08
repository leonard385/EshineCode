//
//  MMSImageShowView.h
//  MMS
//
//  Created by 逸信Mac on 16/7/28.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ISPhotoSrcName(file) [@"ImageShowImage.bundle" stringByAppendingPathComponent:file]

typedef void(^ISOpenPhotoLib)();
typedef void(^ISPreViewPhoto)(UIImage *image);
typedef void(^ISPreViewPhotoAtIndex)(NSUInteger idx);
typedef void(^ISPreViewPhotoSDBrowser)(UICollectionView * contentView,NSUInteger idx);
typedef void(^DeletePhotoAtIndex)(NSInteger idx);
typedef void(^ISViewHightChange)(CGFloat height);


@interface MMSImageShowView : UIView

@property(nonatomic,strong)UICollectionView *ImageCollectionView;
@property(nonatomic,strong)NSArray *ReportPhotos;//下载照片
@property(nonatomic,strong)NSMutableArray *UploadArrays;
@property(nonatomic,assign)NSUInteger PhotoLimitCount;//最大图片数量

@property(nonatomic,strong,readonly)NSString *PhotoIDS;

@property(nonatomic,copy)ISOpenPhotoLib ISOpenPhotoLibBlock;//打开相册
@property(nonatomic,copy)ISPreViewPhoto ISPreViewPhotoBlock;//预览相片
@property(nonatomic,copy)DeletePhotoAtIndex DeletePhotoAtIndexBlock;//删除相片

@property(nonatomic,copy)ISPreViewPhotoAtIndex ISPreViewPhotoAtIndexBlock;//预览具体位置照片

@property(nonatomic,copy)ISPreViewPhotoSDBrowser ISPreViewPhotoSDBrowserBlock;

@property(nonatomic,copy)ISViewHightChange ISViewHightChangeBlock;//高度改变

-(void)setISViewHightChangeBlock:(ISViewHightChange)ISViewHightChangeBlock;

-(void)setISOpenPhotoLibBlock:(ISOpenPhotoLib)ISOpenPhotoLibBlock;
-(void)setISPreViewPhotoBlock:(ISPreViewPhoto)ISPreViewPhotoBlock;

-(void)setISPreViewPhotoSDBrowserBlock:(ISPreViewPhotoSDBrowser)ISPreViewPhotoSDBrowserBlock;

-(void)setISPreViewPhotoAtIndexBlock:(ISPreViewPhotoAtIndex)ISPreViewPhotoAtIndexBlock;

- (void)setDeletePhotoAtIndexBlock:(DeletePhotoAtIndex)DeletePhotoAtIndexBlock;

-(void)addPhoto:(UIImage *)image;
-(void)addPhotosFromArray:(NSArray *)imageArray;

-(void)DelectAllPhotos;
-(void)DelectPhotosAtIndex:(NSInteger)index;
- (void)ImageClickWithPage:(NSInteger)index;

-(bool)IsAllTasksCommitComplete;//所有上传任务上传完成
@end
