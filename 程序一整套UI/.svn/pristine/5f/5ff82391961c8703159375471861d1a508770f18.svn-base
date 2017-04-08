//
//  CXsearchCollectionViewCell.m
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "CXSearchCollectionViewCell.h"

@implementation CXSearchCollectionViewCell

+ (CGSize) getSizeWithText:(NSString*)text;
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+20, 24);
}

- (IBAction)select:(id)sender {
    if ([self.selectDelegate respondsToSelector:@selector(selectButttonClick:)]) {
        [self.selectDelegate selectButttonClick:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_contentButton.layer setMasksToBounds:YES];
    [_contentButton.layer setCornerRadius:12.0];
    [_contentButton setBackgroundColor:[UIColor colorWithWhite:0.957 alpha:1.000]];
}

@end
