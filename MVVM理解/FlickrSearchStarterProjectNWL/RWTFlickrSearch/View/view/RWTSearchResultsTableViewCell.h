//
//  Created by Colin Eberhardt on 26/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

@import UIKit;
@interface RWTSearchResultsTableViewCell : UITableViewCell
- (void)bindViewModel:(id)viewModel;//绑定
- (void) setParallax:(CGFloat)value;//滑动设置图片偏移量
@end
