//
//  RWTableViewBindingHelper.h
//  RWTwitterSearch
//
//  Created by Colin Eberhardt on 24/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

@import Foundation;
#import <ReactiveCocoa/ReactiveCocoa.h>

/// A helper class for binding view models with NSArray properties to a UITableView.
@interface CETableViewBindingHelper : NSObject

// forwards the UITableViewDelegate methods
@property (weak, nonatomic) id<UITableViewDelegate> delegate;

- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                      templateCell:(UINib *)templateCellNib;

+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection
                              templateCell:(UINib *)templateCellNib;

@end
