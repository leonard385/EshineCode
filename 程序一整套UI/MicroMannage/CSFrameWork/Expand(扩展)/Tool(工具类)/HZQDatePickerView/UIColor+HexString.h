//
//  UIColor+HexString.h
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
/**
 *  十六进制的颜色转换为UIColor
 *
 *  @param color   十六进制的颜色
 *
 *  @return   UIColor
 */
+ (UIColor *)colorwithHexString:(NSString *)color;

@end
