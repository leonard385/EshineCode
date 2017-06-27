//
//  ImageGridCollectionViewCell.m
//  ImagePickDemo
//
//  Created by 倪望龙 on 2017/6/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ImageGridCollectionViewCell.h"

@implementation ImageGridCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self IGSetUpSubviews];
    }
    return self;
}

#pragma mark - 设置视图
-(void)IGSetUpSubviews{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.width)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.cornerRadius = 5.0f;
    _imageView.layer.borderWidth = 1.0f;
    _imageView.layer.borderColor = [UIColor redColor].CGColor;
    _imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imageView];
}

- (UIView *)snapshotView {
    UIView *snapshotView = [[UIView alloc]init];
    
    UIView *cellSnapshotView = nil;
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
    } else {
        CGSize size = CGSizeMake(self.bounds.size.width + 20, self.bounds.size.height + 20);
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
    }
    
    snapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    cellSnapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    
    [snapshotView addSubview:cellSnapshotView];
    return snapshotView;
}
@end
