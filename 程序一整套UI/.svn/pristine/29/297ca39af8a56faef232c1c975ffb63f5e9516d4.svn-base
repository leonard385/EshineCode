//
//  BaiduWeekWeatherModel.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/9.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "BaiduWeekWeatherModel.h"

@implementation BaiduWeekWeatherModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dict];
        //当前温度处理
        NSRange CurBgRange = [_date rangeOfString:@"："];
        NSRange CurEndRange = [_date rangeOfString:@")"];
        NSUInteger length = (CurEndRange.location - CurBgRange.location) - 1;
        NSUInteger location = CurBgRange.location + 1;
        NSRange CurrentTemShowrange;
        CurrentTemShowrange.location = location;
        CurrentTemShowrange.length = length;
        NSString *CurrentTemShow = [_date substringWithRange:CurrentTemShowrange];
        _C_temp = CurrentTemShow;
        
        //最高最低温度处理
        NSArray *strArray =[_temperature componentsSeparatedByString:@"~"];
        _H_temp = [NSString stringWithFormat:@"%@℃",strArray[0]];
        _L_temp = strArray[1];

    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setNilValueForKey:(NSString *)key
{
    
}
@end
