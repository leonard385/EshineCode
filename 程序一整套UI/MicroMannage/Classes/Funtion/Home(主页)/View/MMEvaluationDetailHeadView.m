//
//  MMEvaluationDetailHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationDetailHeadView.h"
#import "MMEvaluationDetailItem.h"
#import "PNChart.h"
#import "YYText.h"
@interface MMEvaluationDetailHeadView()
@property(nonatomic,strong)UILabel *lableHeadTitle;
@property(nonatomic,strong)UILabel *lableStatic;
@property(nonatomic,strong)PNLineChart *lineChart;
@property(nonatomic,strong)UIView *lineView;
@end

@implementation MMEvaluationDetailHeadView
-(UILabel *)lableHeadTitle{
    if(_lableHeadTitle == nil){
        _lableHeadTitle = [UILabel new];
        [_lableHeadTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableHeadTitle setFont:[UIFont systemFontOfSize:14.0f]];
        _lableHeadTitle.text = @"员工考试曲线图";
    }
    return _lableHeadTitle;
}

-(UILabel *)lableStatic{
    if(_lableStatic == nil){
        _lableStatic = [UILabel new];
        [_lableStatic setTextColor:HEXCOLOR(0x333333)];
        [_lableStatic setFont:[UIFont systemFontOfSize:14.0f]];
        _lableStatic.text = @"总人数(600)";
    }
    return _lableStatic;
}

-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [UIView new];
        _lineView.backgroundColor = HEXCOLOR(0xf0f3f8);
    }
    return _lineView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self EDSetUpSubviews];
    }
    return self;
}

-(void)EDSetUpSubviews{
    [self addSubview:self.lableHeadTitle];
    [self addSubview:self.lableStatic];
    [self addSubview:self.lineView];
    
    CGFloat contentW = self.width;
    
    CGFloat HeadTitleX = 12.0f;
    CGFloat HeadTitleY = 12.0f;
    CGFloat HeadTitleW = contentW - HeadTitleX * 2.0f;
    CGFloat HeadTitleH = 25.0f;
    _lableHeadTitle.frame = CGRectMake(HeadTitleX, HeadTitleY, HeadTitleW, HeadTitleH);
    
    CGFloat StaticX = HeadTitleX;
    CGFloat StaticY = CGRectGetMaxY(self.lableHeadTitle.frame) + 7.0f;
    CGFloat StaticW = HeadTitleW;
    CGFloat StaticH = 19.0f;
    _lableStatic.frame = CGRectMake(StaticX, StaticY, StaticW, StaticH);
    
    CGFloat lineChartY = CGRectGetMaxY(_lableStatic.frame) + 12.0f;
    _lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(12.0f, lineChartY, self.width - 12.0f * 2.0f,192.0f)];
    _lineChart.showGenYLabels = YES;
    _lineChart.showYGridLines = YES;
    [self addSubview:self.lineChart];
    
    CGFloat lineX = 0.0f;
    CGFloat lineY = CGRectGetMaxY(_lineChart.frame) + 12.0f;
    CGFloat lineW = contentW;
    CGFloat lineH = 10.0f;
    _lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    [self setTotal:@"300" Pass:@"40" Avg:@"80" High:@"99"];
}

-(void)redraw{
    [_lineChart setXLabels:@[@"0~10",@"11~20",@"21~30",@"31~40",@"41~50"]];
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = _lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    _lineChart.chartData = @[data02];
    [_lineChart strokeChart];
    
}

-(void)setTotal:(NSString *)total Pass:(NSString*)pass Avg:(NSString *)avg High:(NSString *)high{
    NSMutableAttributedString * str = [self getAtrstrWithTotal:total pass:pass avg:avg high:high];
    _lableStatic.attributedText = str;
}

-(NSMutableAttributedString*)getAtrstrWithTotal:(NSString *)Total pass:(NSString *)pass avg:(NSString *)avg high:(NSString *)high{
    NSString *passScore = [NSString stringWithFormat:@"(%@)",pass];
    NSString *avgScore = [NSString stringWithFormat:@"(%@)",avg];
    NSString *highScore = [NSString stringWithFormat:@"(%@)",high];

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总人数(%@)  合格分%@  平均分%@ 最高分%@",Total,passScore,avgScore,highScore]];
    
    [text yy_setFont:[UIFont systemFontOfSize:11.0f] range:[text yy_rangeOfAll]];
    [text yy_setColor:HEXCOLOR(0x333333) range:[text yy_rangeOfAll]];
    
    NSRange range0 = [[text string] rangeOfString:pass options:NSCaseInsensitiveSearch];
    [text yy_setColor:HEXCOLOR(kBlueColor) range:range0];
    
    NSRange range1 = [[text string] rangeOfString:avg options:NSCaseInsensitiveSearch];
    [text yy_setColor:HEXCOLOR(0x5cd054) range:range1];
    
    NSRange range2 = [[text string] rangeOfString:high options:NSCaseInsensitiveSearch];
    [text yy_setColor:HEXCOLOR(0xffad33) range:range2];
    return text;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
