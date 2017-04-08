//
//  CXsearchCollectionViewCell.h
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXSearchCollectionViewCell;

@protocol SelectCollectionCellDelegate <NSObject>
- (void)selectButttonClick:(CXSearchCollectionViewCell *)cell;
@end

@interface CXSearchCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *contentButton;

@property (weak, nonatomic) id<SelectCollectionCellDelegate> selectDelegate;
+ (CGSize) getSizeWithText:(NSString*)text;

@end
