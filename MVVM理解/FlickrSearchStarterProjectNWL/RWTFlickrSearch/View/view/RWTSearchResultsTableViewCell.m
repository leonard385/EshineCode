//
//  Created by Colin Eberhardt on 26/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <SDWebImage/UIImageView+WebCache.h>
#import "RWTFlickrPhoto.h"

#import "RWTSearchResultsItemViewModel.h"

@interface RWTSearchResultsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *favouritesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentsIcon;
@property (weak, nonatomic) IBOutlet UIImageView *favouritesIcon;

@end

@implementation RWTSearchResultsTableViewCell


#pragma mark - 绑定数据
- (void)bindViewModel:(id)viewModel {
    RWTSearchResultsItemViewModel *photo = viewModel;
    
    self.titleLabel.text = photo.title;
    
    //图片加载
    self.imageThumbnailView.contentMode = UIViewContentModeScaleToFill;
    [self.imageThumbnailView sd_setImageWithURL:photo.url];
    
    //相关属性值处理使得view能够正常显示
    [RACObserve(photo, favorites) subscribeNext:^(NSNumber *x) {
        self.favouritesLabel.text = [x stringValue];
        self.favouritesIcon.hidden = (x == nil);
    }];
    [RACObserve(photo, comments) subscribeNext:^(NSNumber *x) {
        self.commentsLabel.text = [x stringValue];
        self.commentsIcon.hidden = (x == nil);
    }];
    
    //visible状态切换
    photo.isVisible = YES;

    //cell被移出table view进行重用时会被设置成NO。我们通过rac_prepareForReuseSignal信号来实现这步操作。
    [self.rac_prepareForReuseSignal subscribeNext:^(id x) {
        photo.isVisible = NO;
    }];
}

#pragma mark - 设置偏移量
- (void)setParallax:(CGFloat)value {
    self.imageThumbnailView.transform = CGAffineTransformMakeTranslation(0, value);
}
@end
