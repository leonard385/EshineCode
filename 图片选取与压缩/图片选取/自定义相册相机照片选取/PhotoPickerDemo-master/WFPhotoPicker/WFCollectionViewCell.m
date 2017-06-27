//
//  WFCollectionViewCell.m
//  WFPhotoPicker
//
//  Created by 赚发2 on 16/9/5.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import "WFCollectionViewCell.h"
#import "WFPhotoAlbum.h"


@implementation WFCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void (^)(WFAlumbModel *))assignment{
    return ^ (WFAlumbModel *model){
        [[WFPhotoAlbum standarWFPhotosAlbum] getPhotosWithAsset:model.asset originalImage:NO completion:^(UIImage *image) {
            _imageView.image = image;
        }];
    };
}

@end
