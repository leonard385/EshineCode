//
//  MMEmployStatisticTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployStatisticTableViewCell.h"
#import "MMEmployStatisticSubCell.h"
#import "MMEMStatisticHeadView.h"
@class MMEmployStatisticModel;
@interface  MMEmployStatisticTableViewCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)MMEMStatisticHeadView *headView;
@end

@implementation MMEmployStatisticTableViewCell

-(MMEMStatisticHeadView *)headView{
    if(_headView == nil){
        _headView = [[MMEMStatisticHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 12.0f*2.0f, 37.0f)];
    }
    return _headView;
}
-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setText:@"员工动态表"];
        [_lableTitle setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return _lableTitle;
}

-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[MMEmployStatisticSubCell class] forCellReuseIdentifier:@"MMEmployStatisticSubCell"];
        _tableView.backgroundColor = HEXCOLOR(0xf0f3f8);
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 37.0f;
        _tableView.layer.borderWidth = 0.5f;
        _tableView.tableHeaderView = self.headView;
        _tableView.layer.borderColor = HEXCOLOR(0xcccccc).CGColor;
    }
    return _tableView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self STSetUpSubviews];
    }
    return self;
}

-(void)updateConstraints{
    //数据
    CGFloat tableViewContentH = _tableView.contentSize.height;
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_lableTitle);
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(12.0f);
        make.height.mas_equalTo(tableViewContentH);
        make.bottom.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    [super updateConstraints];
}

-(void)STSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.tableView];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.height.mas_equalTo(20.0f);
    }];
}

-(void)setDatas:(NSArray *)datas{
    _datas = datas;
    [_tableView reloadData];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MMEmployStatisticSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMEmployStatisticSubCell"];
    if(cell == nil){
        cell = [[MMEmployStatisticSubCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMEmployStatisticSubCell"];
    }
    
    MMEmployStatisticModel *model = _datas[indexPath.row];
    [cell setCellModel:model];
    if(indexPath.row % 2 == 0){
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }else if(indexPath.row % 2 == 1){
        cell.contentView.backgroundColor = HEXCOLOR(0xf7f7f7);
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
