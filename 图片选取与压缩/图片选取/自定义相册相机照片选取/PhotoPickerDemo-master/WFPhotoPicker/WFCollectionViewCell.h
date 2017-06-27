//
//  WFCollectionViewCell.h
//  WFPhotoPicker
//
//  Created by 赚发2 on 16/9/5.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFCacheModel.h"

@interface WFCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

- (void (^)(WFAlumbModel *))assignment;

@end
