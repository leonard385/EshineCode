//
//  MMEmployStatisticChartCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployStatisticChartCell.h"
#import "MMEmployStatisticTipItem.h"
#import "PNChart.h"
#define cellHeight 254.0f
@interface MMEmployStatisticChartCell()
@property(nonatomic,strong)UIView *subContrainer;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)MMEmployStatisticTipItem *leaveTip;
@property(nonatomic,strong)MMEmployStatisticTipItem *addTip;
@property(nonatomic,strong)PNLineChart *lineChart;
@end

@implementation MMEmployStatisticChartCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self SCSetUpSubviews];
    }
    return self;
}

-(void)SCSetUpSubviews{
    
    _subContrainer = [[UIView alloc]initWithFrame:CGRectMake(0, 10.0f, kScreenWidth, cellHeight - 10.0f)];
    _subContrainer.backgroundColor = [UIColor whiteColor];
    
    CGFloat addTipW = 70.0f;
    CGFloat addTipX = kScreenWidth - 12.0f - addTipW;
    CGFloat addTipY = 12.0f;
     _addTip = [[MMEmployStatisticTipItem alloc]initWithFrame:CGRectMake(addTipX, addTipY, addTipW, 22.0f) Title:@"新增员工" IconColor:HEXCOLOR(0x69a5e1)];
    CGFloat leaveTipW = 70.0f;
    CGFloat leaveTipX = CGRectGetMinX(_addTip.frame) - 2.0f - leaveTipW;
    CGFloat leaveTipY = 12.0f;
    _leaveTip = [[MMEmployStatisticTipItem alloc]initWithFrame:CGRectMake(leaveTipX, leaveTipY, leaveTipW, 22.0f) Title:@"离职员工" IconColor:HEXCOLOR(0x5dd054)];
    
    CGFloat lableTitleW = kScreenWidth - CGRectGetMinX(_leaveTip.frame) - 2.0f - 12.0f;
    CGFloat lableTitleX = 12.0f;
    CGFloat lableTitleY = 12.0f;
    _lableTitle = [[UILabel alloc]initWithFrame:CGRectMake(lableTitleX, lableTitleY,lableTitleW, 22.0f)];
    [_lableTitle setTextColor:HEXCOLOR(0x333333)];
    [_lableTitle setText:@"员工动态折线图"];
    [_lableTitle setFont:[UIFont systemFontOfSize:14.0f]];
    
    CGFloat lineChartX = 12.0f;
    CGFloat lineChartY = CGRectGetMaxY(self.lableTitle.frame) + 12.0f;
    CGFloat lineChartW = self.subContrainer.width - 12.0f * 2.0f;
    CGFloat lineChartH = self.subContrainer.height - 12.0f - lineChartY;
    CGRect frame = CGRectMake(lineChartX, lineChartY, lineChartW, lineChartH);
    PNLineChart *chart =  [[PNLineChart alloc]initWithFrame:frame];
    chart.showGenYLabels = YES;
    chart.showYGridLines = YES;
    _lineChart = chart;

    self.contentView.backgroundColor = HEXCOLOR(0xf0f3f8);
    [self.contentView addSubview:self.subContrainer];
    [self.subContrainer addSubview:self.lableTitle];
    [self.subContrainer addSubview:self.leaveTip];
    [self.subContrainer addSubview:self.addTip];
    [self.subContrainer addSubview:self.lineChart];
}

-(void)redraw{
    [_lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = _lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = _lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    _lineChart.chartData = @[data01, data02];
    [_lineChart strokeChart];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
