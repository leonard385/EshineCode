//
//  CSBaseFuncVc.h
//  ComplainSYS
//
//  Created by 逸信Mac on 16/6/6.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
#import "HZQDatePickerView.h"

typedef void(^BFRefreshData)();
typedef void(^BFPhotos)(NSArray *photoArray);

@interface CSBaseFuncVC:UIViewController <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UIScrollView *ScrollerView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UICollectionView *collectionView;
//控制器数据数组
@property(nonatomic,strong)NSMutableArray *DateArray;

@property(nonatomic,assign)bool isLoading;

//空白显示页相关数据
@property(nonatomic,strong)UIImage* EmptyImage;
@property(nonatomic,strong)NSString *EmptyTitle;
@property(nonatomic,strong)NSString *EmptySubTitle;
@property(nonatomic,strong)UIColor *EmptyBgColor;

//刷新数据
@property(nonatomic,copy)BFRefreshData BFRefreshDataBlock;

//照片数据返回
@property(nonatomic,copy)BFPhotos BFPhotosBlock;

//设置重载函数
-(void)setBFRefreshDataBlock:(BFRefreshData)BFRefreshDataBlock;

//设置空白页显示
-(void)setEmptyImage:(UIImage *)EmptyImage
          EmptyTitle:(NSString *)EmptyTitle
          EmptySubTitle:(NSString *)EmptySubTitle
        EmptyBgColor:(UIColor *)EmptyBgColor
        BFRefreshDataBlock:(BFRefreshData)BFRefreshDataBlock;

//结束加载
-(void)CommpleteLoddingWithEmptyImage:(UIImage *)EmptyImage
                           EmptyTitle:(NSString *)EmptyTitle
                        EmptySubTitle:(NSString *)EmptySubTitle
                         EmptyBgColor:(UIColor *)EmptyBgColor;


-(void)setBFPhotosBlock:(BFPhotos)BFPhotosBlock;

//开始加载数据
-(void)StartLoding;

////打开相册
//-(void)OpenPotoLibWithPhotoLimit:(NSUInteger)num Photos:(BFPhotos)BFPhotosBlock;
//
////打开照相机
//-(void)OpenCameraPhotos:(BFPhotos)BFPhotosBlock;

//打开选择相机或者相册
-(void)openMenuWithPohoNumLimit:(NSUInteger)Num Photos:(BFPhotos)PhotosBlock;

//图片压缩
-(void)CompressImages:(NSArray *)ImageArray
               toSize:(CGSize)size
              Quality:(CGInterpolationQuality)QualityKind
          returnBlock:(void(^)(NSArray *CompressedImages,NSArray *datas))ImageReturnBlock;


//数据保存到本地
-(void)SaveFilesToUserDocument:(NSArray*)FileArray
                   WithOrderID:(NSString *)OrderID;

//时间选择器
-(void)GetTimePickViewWithTimeFormatType:(DPFormatType)FormatType Finnish:(void(^)(NSString *datestr ,NSDate *date))TimeDateBlock;
@end
