//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  FooterCollectionReusableView.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-13.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "MLSelectPhotoPickerFooterCollectionReusableView.h"

@interface MLSelectPhotoPickerFooterCollectionReusableView ()
@property (weak, nonatomic) UILabel *footerLabel;

@end

@implementation MLSelectPhotoPickerFooterCollectionReusableView

- (UILabel *)footerLabel{
    if (!_footerLabel) {
        UILabel *footerLabel = [[UILabel alloc] init];
        footerLabel.frame = self.bounds;
        footerLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:footerLabel];
        self.footerLabel = footerLabel;
    }
    return _footerLabel;
}

- (void)setCount:(NSInteger)count{
    _count = count;
    if (count > 0) {
        self.footerLabel.text = [NSString stringWithFormat:@"有 %ld 张图片", (long)count];
    }
}

@end
