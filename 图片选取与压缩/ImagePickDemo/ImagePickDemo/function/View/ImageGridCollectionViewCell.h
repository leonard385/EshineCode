//
//  ImageGridCollectionViewCell.h
//  ImagePickDemo
//
//  Created by 倪望龙 on 2017/6/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageGridCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;

- (UIView *)snapshotView;
@end
