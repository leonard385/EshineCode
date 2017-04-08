//
//  TagsTableCell.h
//  WrapViewWithAutolayout
//
//  Created by Shaokang Zhao on 15/1/12.
//  Copyright (c) 2015年 shiweifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTagView;
@interface TagsTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet SKTagView *tagView;
@end
