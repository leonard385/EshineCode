//
//  NSDate+NWL.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/23.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "NSDate+NWL.h"

@implementation NSDate (NWL)
-(NSTimeInterval)TimeIntervalWithLastTime:(NSDate*)date
{
//NSDate *starttime = [NSDate dateFromString:_VcModel.genStime];
//NSDate *Curtime = [NSDate date];

NSTimeInterval startInterval= [date timeIntervalSince1970];
NSTimeInterval NowInterval= [self timeIntervalSince1970];

NSTimeInterval cha=NowInterval-startInterval;
return cha;
}
@end
