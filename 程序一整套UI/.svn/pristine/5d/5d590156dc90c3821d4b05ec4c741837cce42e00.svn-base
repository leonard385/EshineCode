//
//  QJVersionUpdateVIew.h
//  QJVersionUpdateView
//
//  Created by Justin on 16/3/8.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RemoveUpdateViewBlock)();

@interface QJVersionUpdateVIew : UIView

@property (nonatomic, copy)RemoveUpdateViewBlock removeUpdateViewBlock;

@property (nonatomic, copy)dispatch_block_t GoTOAppstoreBlock;

-(instancetype)initWith:(NSString *)version Describe:(NSArray *)describeArr;

@end
