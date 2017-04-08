//
//  MMRankingActiveHeadItem.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/8.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    firstType = 0,
    secondType,
    thirdType,
} RAItemType;

@interface MMRankingActiveHeadItem : UIView
@property(nonatomic,assign) RAItemType itemType;
- (instancetype)initWithType:(RAItemType)Type;
@end
