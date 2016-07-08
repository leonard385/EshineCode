//
//  ESDatePickerView.m
//  ESDatePickerViewDemo
//
//  Created by eshine_lsc on 16/7/7.
//  Copyright © 2016年 eshine_lsc. All rights reserved.
//

#import "ESDatePickerView.h"

#define ESDPScreen_W [UIScreen mainScreen].bounds.size.width

#define ESDPScreen_H [UIScreen mainScreen].bounds.size.height

@interface ESDatePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)NSMutableArray *pickerArray1;//年

@property(nonatomic,strong)NSMutableArray *pickerArray2;//月

@property(nonatomic,strong)NSMutableArray *pickerArray3;//日

@property(nonatomic,strong)UIPickerView *pickerView; //选择器

@end

@implementation ESDatePickerView

-(instancetype)init{
    if (self = [super init]) {
        self.pickerArray1 = [NSMutableArray array];
        self.pickerArray2 = [NSMutableArray array];
        self.pickerArray3 = [NSMutableArray array];
        self.frame = CGRectMake(0, 0, ESDPScreen_W, ESDPScreen_H);
        for (int i = 0; i < 5000; i++) {
            [self.pickerArray1 addObject:[NSString stringWithFormat:@"%d年",i]];
        }
        for (int i = 1; i < 13; i++) {
            [self.pickerArray2 addObject:[NSString stringWithFormat:@"%02d月",i]];
        }
        for (int i = 1; i < 32; i++) {
            [self.pickerArray3 addObject:[NSString stringWithFormat:@"%02d日",i]];
        }
        [self setDatePicker];
        
    }
    return self;
}

-(void)setDatePicker{
    UIImageView *pBgV = [[UIImageView alloc]init];
    pBgV.backgroundColor = [UIColor blackColor];
    pBgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    pBgV.userInteractionEnabled = YES;
    pBgV.alpha = 0.2;
    [self addSubview:pBgV];
    
    UIImageView * pBgV2 = [[UIImageView alloc]init];
    pBgV2.backgroundColor = [UIColor whiteColor];
    pBgV2.frame = CGRectMake(30, 0, [UIScreen mainScreen].bounds.size.width - 60, 190);
    pBgV2.center = self.center;
    pBgV2.userInteractionEnabled = YES;
    
    
    UIImageView *pBgV3 = [[UIImageView alloc]init];
    pBgV3.backgroundColor = [self colorWithHexString:@"#02B2F8"];
    pBgV3.frame = CGRectMake(0, 0, pBgV2.bounds.size.width, 40);
    pBgV3.userInteractionEnabled = YES;
    [pBgV2 addSubview:pBgV3];
    
    UIButton *comBtn = [[UIButton alloc]init];
    comBtn.frame = CGRectMake(CGRectGetWidth(pBgV3.frame)-60, 5, 60, 30);
    comBtn.backgroundColor = [UIColor clearColor];
    [comBtn setTitle:@"确定" forState:UIControlStateNormal];
    [comBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    comBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [comBtn addTarget: self action: @selector(quebClicked) forControlEvents: UIControlEventTouchUpInside];
    [pBgV3 addSubview:comBtn];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    cancelBtn.frame = CGRectMake(0, 5, 60, 30);
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelBtn addTarget: self action: @selector(cancalbClicked) forControlEvents: UIControlEventTouchUpInside];
    [pBgV3 addSubview:cancelBtn];
    
    
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.frame = CGRectMake((pBgV2.bounds.size.width -240) * 0.15, 40,pBgV2.bounds.size.width - (pBgV2.bounds.size.width- 240) *0.30, 150);
    self.pickerView.backgroundColor = [UIColor whiteColor];
    
    self.pickerView.dataSource = self;   //这个不用说了瑟
    
    self.pickerView.delegate = self;       //这个不用说了瑟
    
    self.pickerView.showsSelectionIndicator = YES;    //这个最好写 你不写来试下哇
    
    NSDate *now=[NSDate date];
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int time=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *t=[cal components:time fromDate:now];
    
    [self.pickerView selectRow:t.year inComponent:0 animated:NO];
    [self.pickerView selectRow:t.month - 1 inComponent:1 animated:NO];
    [self.pickerView selectRow:t.day - 1 inComponent:2 animated:NO];
    
    //手动选中该行
    [self pickerView:nil didSelectRow:t.month - 1 inComponent:1];
    
    [pBgV2 addSubview:self.pickerView];
    
    [self addSubview:pBgV2];
    
}

#pragma mark -

#pragma mark UIPickerViewDataSource



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 3;     //这个picker里的组键数
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (component == 0) {
        return 16384;  //数组个数
    }
    else{
        return 16384;  //数组个数
    }
    
}

#pragma mark -

#pragma mark UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    
    if (component == 0) {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
        
        myView.textAlignment = NSTextAlignmentLeft;
        
        myView.text = [self.pickerArray1 objectAtIndex:(row%self.pickerArray1.count)];
        
        myView.font = [UIFont systemFontOfSize:18];         //用label来设置字体大小
        myView.textColor = [self colorWithHexString:@"#333333"];
        
        myView.backgroundColor = [UIColor clearColor];
        
    }else if(component == 1){
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
        
        myView.text = [self.pickerArray2 objectAtIndex:(row%self.pickerArray2.count)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:18];
        
        myView.textColor = [self colorWithHexString:@"#333333"];
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    else{
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
        
        myView.text = [self.pickerArray3 objectAtIndex:(row%self.pickerArray3.count)];
        
        myView.textAlignment = NSTextAlignmentRight;
        
        myView.font = [UIFont systemFontOfSize:18];
        
        myView.textColor = [self colorWithHexString:@"#333333"];
        
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 1) {
        switch (row%12) {
            case 0:case 2:case 4:case 6:case 7:case 9:case 11:
            {
                [self.pickerArray3 removeAllObjects];
                for (int i = 1; i < 32; i++) {
                    [self.pickerArray3 addObject:[NSString stringWithFormat:@"%02d日",i]];
                }
            }
                break;
            case 3:case 5:case 8:case 10:
            {
                [self.pickerArray3 removeAllObjects];
                for (int i = 1; i < 31; i++) {
                    [self.pickerArray3 addObject:[NSString stringWithFormat:@"%02d日",i]];
                }
            }
                break;
            case 1:
            {
                [self.pickerArray3 removeAllObjects];
                for (int i = 1; i < 29; i++) {
                    [self.pickerArray3 addObject:[NSString stringWithFormat:@"%02d日",i]];
                }
            }
                break;
                
            default:
                break;
        }
        [self.pickerView reloadComponent:2];
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component

{
    
    CGFloat componentWidth = 0.0;
    
    
    
    if (component == 0)
        
        componentWidth = 80.0; // 第一个组键的宽度
    
    else
        
        componentWidth = 80.0; // 第2个组键的宽度
    
    
    
    return componentWidth;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 30.0;
    
}

#pragma btnClick
-(void)cancalbClicked{
    
    [self removeFromSuperview];
    
}

-(void)quebClicked{
    
    NSInteger year = [self.pickerView selectedRowInComponent: 0];
    NSInteger moon = [self.pickerView selectedRowInComponent: 1];
    NSInteger day = [self.pickerView selectedRowInComponent: 2];
    
    NSString *yearStr = [self.pickerArray1 objectAtIndex: year%5000];
    NSString *monthStr = [self.pickerArray2 objectAtIndex: moon%12];
    NSString *dayStr = @"";
    switch (moon%12) {
        case 0:case 2:case 4:case 6:case 7:case 9:case 11:
        {
            dayStr = [self.pickerArray3 objectAtIndex:day%31];
        }
            break;
        case 3:case 5:case 8:case 10:
        {
            dayStr = [self.pickerArray3 objectAtIndex:day%30];
        }
            break;
        case 1:
        {
            dayStr = [self.pickerArray3 objectAtIndex:day%28];
        }
            break;
            
        default:
            break;
    }
    
    if ([yearStr isEqualToString: monthStr] && [monthStr isEqualToString: dayStr]) {
        monthStr = @"";
        dayStr = @"";
    }
    else if ([monthStr isEqualToString: dayStr]) {
        dayStr = @"";
    }
    
    if ([monthStr integerValue] < 10) {
        monthStr = [NSString stringWithFormat:@"%@",monthStr];
    }
    if ([dayStr integerValue] < 10) {
        dayStr = [NSString stringWithFormat:@"%@",dayStr];
    }
    
    //把年月日进行拼接
//    NSString *showMsg = [NSString stringWithFormat: @"%@ %@ %@.", provinceStr, cityStr, districtStr];
//    NSString *areaA = [showMsg substringToIndex:showMsg.length - 1];
//    NSString *timeB = [areaA stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    
    [self removeFromSuperview];
    
    //去掉后面的年月日
    yearStr = [yearStr substringToIndex:yearStr.length-1];
    monthStr = [monthStr substringToIndex:monthStr.length-1];
    dayStr = [dayStr substringToIndex:dayStr.length-1];
    
    if ([self.delegate respondsToSelector:@selector(ESDPGetYear:month:day:)]) {
        [self.delegate ESDPGetYear:yearStr month:monthStr day:dayStr];
    }
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self removeFromSuperview];
}


#pragma mark - 将16进制字符串转化成颜色
/**
 *  由16进制的颜色字符串 转十进制颜色 @“#60B30E”--> 60B30E @“0x60B30E”--> 60B30E
 *
 *  @param color 16进制颜色字符串
 *
 *  @return 颜色对象
 */
-(UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


@end
