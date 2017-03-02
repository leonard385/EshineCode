//
//  Created by Colin Eberhardt on 24/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTRecentSearchItemTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTPreviousSearchViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RWTRecentSearchItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalResultsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

@end

@implementation RWTRecentSearchItemTableViewCell

- (void)bindViewModel:(id)viewModel {
    RWTPreviousSearchViewModel *photo = viewModel;
    self.searchLabel.text = photo.searchString;
    self.totalResultsLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)photo.totalResults];
    //加载图片
    self.totalResultsLabel.contentMode = UIViewContentModeScaleToFill;
    [self.thumbnailImage sd_setImageWithURL:photo.thumbnail];
}

@end
