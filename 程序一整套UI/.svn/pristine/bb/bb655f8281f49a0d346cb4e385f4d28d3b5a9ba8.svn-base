//
//  BaiDuWeather.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/9.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "BaiDuWeather.h"
#import "BSEHttpTool.h"

#define BaiDuUserAppKey @"6cdb2b6f774b89e675d37b2e24cf23c3"
static NSString *WeatherHttpUrl = @"http://apis.baidu.com/apistore/weatherservice/cityname";
#define LastSevenWeatherUrl @"http://api.map.baidu.com/telematics/v3/weather"

#define BundleID @"com.eshine.JyBsem"
@implementation BaiDuWeather

/**
 *  当天天气信息
 *
 *  @param CityName     城市
 *  @param successblock successblock description
 *  @param errorblock   errorblock description
 */
+(void)GetWeatherInfoForCity:(NSString*)CityName Success:(DWSuccessBlock)successblock error:(DWerrorBlock)errorblock {
    
    NSRange tmp = [CityName rangeOfString:@"市"];
    NSString *tempname = [CityName substringToIndex:tmp.location];
    NSString * name = [tempname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * City = [NSString stringWithFormat:@"cityname=%@",name];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", WeatherHttpUrl, City];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: BaiDuUserAppKey forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                                   errorblock(error);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   id jsondate = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   NSLog(@"HttpResponseCode:%ld", (long)responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                                   successblock(jsondate);
                               }
                           }];
}

/**
 *   车联网API 未来7天天气查询
 *
 *  @param CityName     <#CityName description#>
 *  @param successblock <#successblock description#>
 *  @param errorblock   <#errorblock description#>
 */

+(void)GetWeekWeatherInfoForCity:(NSString*)CityName Success:(DWSuccessBlock)successblock error:(DWerrorBlock)errorblock
{
    
    __block NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    if (CityName) {
        [dictM setObject:CityName forKey:@"location"];
    }
    
    [dictM setObject:@"json" forKey:@"output"];
    [dictM setObject:kBaiduMapKey forKey:@"ak"];
    [dictM setObject:BundleID forKey:@"mcode"];
    
    //根据当前地址获取当前天气
    [BSEHttpTool getWithURL:LastSevenWeatherUrl params:dictM progress:^(id progress) {
        
    } success:^(id json) {
        successblock?successblock(json):nil;
    } failure:^(NSError *error) {
        errorblock?errorblock(error):nil;
    }];
}


@end
