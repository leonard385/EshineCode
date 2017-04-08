//
//  MMTrainItemCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/22.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainItemCell.h"
#import "MMTrainItemSubCell.h"
#import "MMTrainItemFileModel.h"
#import "MMTrainItemFileFrame.h"
@interface MMTrainItemCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *lableContent;//内容
@property(nonatomic,strong)UITableView * tableView;//tableView
@property(nonatomic,strong)UIView *verLine;//竖线

@property(nonatomic,strong)NSArray *fileFrameModels;
@end

@implementation MMTrainItemCell
-(UILabel *)lableContent{
    if(_lableContent == nil){
        _lableContent = [UILabel new];
        [_lableContent setTextColor:HEXCOLOR(0x666666)];
        [_lableContent setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableContent;
}

-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[MMTrainItemSubCell class] forCellReuseIdentifier:@"MMTrainItemSubCell"];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = HEXCOLOR(0xf0f3f8);
        _tableView.layer.cornerRadius = 5.0f;
        _tableView.layer.masksToBounds = YES;
        _tableView.contentInset = UIEdgeInsetsMake(7.0f, 0.0f, 7.0f, 0.0f);
        
    }
    return _tableView;
}

-(UIView *)verLine{
    if(_verLine == nil){
        _verLine = [UIView new];
        _verLine.backgroundColor = HEXCOLOR(kBlueColor);
    }
    return _verLine;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self TISetUpSubviews];
    }
    return self;
}

-(void)TISetUpSubviews{
    [self.contentView addSubview:self.verLine];
    [self.contentView addSubview:self.lableContent];
    [self.contentView addSubview:self.tableView];

}

-(void)setFrameModel:(MMTrainCellFrameModel *)frameModel{
    _frameModel = frameModel;
    [self setFrameWithFrameModel:frameModel];
    [self setCellModelWithModel:frameModel.cellModel];
}

-(void)setFrameWithFrameModel:(MMTrainCellFrameModel *)frameModel{
    _lableContent.frame = frameModel.titleFrame;
    _verLine.frame = frameModel.verLineFrame;
    _tableView.frame = frameModel.tableviewFrame;
    _lableContent.numberOfLines = frameModel.titleLines;
    _fileFrameModels = frameModel.subCellFrameModels;
    [self.tableView reloadData];
}

-(void)setCellModelWithModel:(MMTrainItemModel *)model{
    _lableContent.text = model.subtitle;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fileFrameModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMTrainItemFileFrame *frameModel = _fileFrameModels[indexPath.row];
    return frameModel.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MMTrainItemSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTrainItemSubCell"];
    if(cell == nil){
        cell = [[MMTrainItemSubCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMTrainItemSubCell"];
    }
    [cell setIndex:indexPath.row + 1];
    MMTrainItemFileFrame *frameModel = _fileFrameModels[indexPath.row];
    [cell setFrameModel:frameModel];
    [cell.contentView setBackgroundColor:HEXCOLOR(0xf0f3f8)];
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
